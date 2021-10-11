using Base.Filesystem
using MPI
using Test
using openPMD

MPI.Init()

comm = MPI.COMM_WORLD
myproc = MPI.Comm_rank(comm)
nprocs = MPI.Comm_size(comm)

if myproc == 0
    tmpdir = Filesystem.mktempdir(; cleanup=true)
else
    tmpdir = nothing
end
tmpdir = MPI.bcast(tmpdir, 0, comm)

filename = joinpath(tmpdir, "hello.bp")

D = 3
dims = [0, 0, 0]
MPI.Dims_create!(nprocs, dims)

periodic = [0, 0, 0]
comm = MPI.Cart_create(comm, dims, periodic, true)
@test MPI.Comm_size(comm) == nprocs

myproc = MPI.Comm_rank(comm)
nprocs = MPI.Comm_size(comm)
coords = MPI.Cart_coords(comm)

T = Float64
gsh = [100, 101, 102]
lsh = (gsh + dims .- 1) .÷ dims
lbnd = lsh .* coords
ubnd = min.(gsh, lbnd + lsh)
lsh = ubnd - lbnd

S = Float64
gxmin = S(0.0)
gxmax = S(1.0)
dx = (gxmax - gxmin) ./ (gsh .- 1)

imin = zero(gsh)
imax = gsh .- 1
xcoord(ipos) = gxmin .* ((imax - ipos) ./ S.(imax - imin)) + gxmax .* ((ipos - imin) ./ S.(imax - imin))

lxmin = xcoord(lbnd)
lxmax = xcoord(ubnd)

data = randn(T, (lsh...))

@testset "Write file (MPI)" begin
    series = Series(filename, ACCESS_CREATE, comm)
    set_name!(series, "hello")
    set_author!(series, "Erik Schnetter <schnetter@gmail.com>")

    iter = get_iteration(series, 0)
    mesh = get_mesh(iter, "the_global_mesh")

    dset = Dataset(T, (gsh...,))

    comp = get_component(mesh, "the_record")
    reset_dataset!(comp, dset)
    set_position!(comp, (lxmin...,))

    store_chunk(comp, data, (lbnd...,), (lsh...,))

    # Flush series to wait for all pending writes
    flush(series)
end

MPI.Barrier(comm)

@testset "Read file (MPI)" begin
    series = Series(filename, ACCESS_READ_ONLY, comm)
    @test name(series) == "hello"
    @test author(series) == "Erik Schnetter <schnetter@gmail.com>"

    iter = get_iteration(series, 0)
    mesh = get_mesh(iter, "the_global_mesh")

    comp = get_component(mesh, "the_record")
    @test eltype(comp) == T
    @test ndims(comp) == D
    @test size(comp) == (gsh...,)

    chunks = available_chunks(comp)
    @test chunks isa Vector{ChunkInfo{D}}
    @test length(chunks) == nprocs
    data′ = nothing
    for chunk in chunks
        off = chunk.offset
        ext = chunk.extent
        if off == (lbnd...,)
            @assert data′ ≡ nothing
            data′ = Array{T}(undef, ext)
            load_chunk(comp, data′, off, ext)
        end
    end
    @assert data′ ≢ nothing

    # Close iteration to wait for all pending reads
    close(iter)

    for chunk in chunks
        off = chunk.offset
        ext = chunk.extent
        if off == (lbnd...,)
            @test data′ == data
        end
    end

    # Flush series to close file and free all MPI resources
    flush(series)
end

MPI.Barrier(comm)

println("Done.")
