using Base.Filesystem
using CxxWrap
using StaticArrays
using Test
using openPMD

include("Access.jl")
include("Datatype.jl")
include("Format.jl")
include("UnitDimension.jl")

#TODO const dirname = Filesystem.mktempdir(; cleanup=true)
const dirname = Filesystem.mktempdir(; cleanup=false)
const filename = joinpath(dirname, "hello.json")
println("[Creating output file \"$filename\"]...")

const series = Series(filename, CREATE)
@show typeof(series)
series::Series
set_name!(series, "hello")
set_author!(series, "Erik Schnetter <schnetter@gmail.com>")
const iters = write_iterations(series)
@show typeof(iters)
iters::WriteIterations
const iter = iters[0]
@show typeof(iter)
iter::CxxRef{Iteration}
@show typeof(meshes(iter))
meshes(iter)::CxxRef{Container{Mesh,StdString}}
const mesh = meshes(iter)["my_first_mesh"]
@show typeof(mesh)
mesh::CxxRef{Mesh}
const comp = mesh["my_first_record"]
@show typeof(comp)
comp::MeshRecordComponent
set_position!(comp, (0.0, 0.0))
const data = Int[10i + j for i in 1:2, j in 1:3]
const dsetT = eltype(data)
const off = (0, 0)
const ext = size(data)          # could be larger
const dset = Dataset(dsetT, ext)
@show typeof(dset)
dset::Dataset
reset_dataset!(comp, dset)
store_chunk(comp, data, off, size(data))

include("Attribute.jl")
include("Attributable.jl")
include("Dataset.jl")

include("BaseRecordComponent.jl")
include("RecordComponent.jl")
include("MeshRecordComponent.jl")

cont = mesh
contT = MeshRecordComponent
contK = StdString
include("Container.jl")
include("Mesh.jl")

include("Iteration.jl")

include("WriteIterations.jl")

include("Series.jl")

include("version.jl")

series_flush(series)
flush(series)

close(iter)
