using Base.Filesystem
using CxxWrap
using StaticArrays
using Test
using openPMD

# Test basic features

include("version.jl")

test_version()

# Test basic types

include("Access.jl")
include("Datatype.jl")
include("Format.jl")
include("UnitDimension.jl")

test_Access()
test_Datatype()
test_Format()
test_UnitDimension()

# Test types that need a file

include("Attribute.jl")
include("Attributable.jl")
include("Dataset.jl")

include("BaseRecordComponent.jl")
include("RecordComponent.jl")
include("MeshRecordComponent.jl")

include("Container.jl")
include("Mesh.jl")

include("Iteration.jl")

include("Series.jl")

tmpdir = Filesystem.mktempdir(; cleanup=true)
filename = joinpath(tmpdir, "hello.json")

function test_WriteFile()
    series = Series(filename, ACCESS_CREATE)
    set_name!(series, "hello")
    set_author!(series, "Erik Schnetter <schnetter@gmail.com>")

    iter = get_iteration(series, 0)

    mesh = get_mesh(iter, "my_first_mesh")

    data = Int[10i + j for i in 1:2, j in 1:3]
    T = eltype(data)
    off = (0, 0)
    sz = size(data)            # could be larger
    dset = Dataset(T, sz)

    comp = get_component(mesh, "my_first_record")
    reset_dataset!(comp, dset)
    set_position!(comp, (0.0, 0.0))

    store_chunk(comp, data, off, sz)

    test_Attribute()
    test_Attributable(series)
    test_Attributable(iter)
    test_Attributable(mesh)
    test_Attributable(comp)
    test_Dataset()

    test_BaseRecordComponent(comp)
    test_RecordComponent(comp)
    test_MeshRecordComponent(comp)

    test_Container(mesh)
    test_Mesh(mesh)

    test_Iteration(iter)

    test_Series(series)

    series_flush(mesh)
    series_flush(iter)
    series_flush(series)
    flush(series)

    return
end
test_WriteFile()

function test_ReadFile()
    series = Series(filename, ACCESS_READ_ONLY)
    @test name(series) == "hello"
    @test author(series) == "Erik Schnetter <schnetter@gmail.com>"

    iter = get_iteration(series, 0)

    mesh = get_mesh(iter, "my_first_mesh")

    comp = get_component(mesh, "my_first_record")
    T = eltype(comp)
    D = ndims(comp)
    sz = size(comp)
    @test T ≡ Int
    @test D == 2
    @test sz == (2, 3)
    @test position(comp) == (0.0, 0.0)

    chunks = available_chunks(comp)
    @test chunks isa Vector{ChunkInfo{D}}
    datas = Array{T,D}[]
    for chunk in chunks
        off = chunk.offset
        ext = chunk.extent
        data = Array{T}(undef, ext)
        load_chunk(comp, data, off, ext)
        push!(datas, data)
    end

    close(iter)

    for data in datas
        @test data == Int[10i + j for i in 1:2, j in 1:3]
    end
end
test_ReadFile()
