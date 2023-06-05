# openPMD.jl

A Julia interface for
[openPMD-api](https://github.com/openPMD/openPMD-api), the reference
API for the open Particle/Mesh-Data Adaptable standard.

* [![Documenter](https://img.shields.io/badge/docs-dev-blue.svg)](https://eschnett.github.io/openPMD.jl/dev)
* [![GitHub
  CI](https://github.com/eschnett/openPMD.jl/workflows/CI/badge.svg)](https://github.com/eschnett/openPMD.jl/actions)
* [![Codecov](https://codecov.io/gh/eschnett/openPMD.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/eschnett/openPMD.jl)

# Examples

## Writing a file

```Julia
julia> filename = "hello.json"
julia> series = Series(filename, ACCESS_CREATE)
julia> set_name!(series, "hello")
julia> set_author!(series, "Erik Schnetter <schnetter@gmail.com>")

julia> iter = iterations(series)[0]

julia> mesh = meshes(iter)["my_first_mesh"]

julia> data = Int[10i + j for i in 1:2, j in 1:3]
2×3 Matrix{Int64}:
 11  12  13
 21  22  23

julia> T = eltype(data)
Int64

julia> off = (0, 0)
(0, 0)

julia> sz = size(data)
(2, 3)

julia> dset = Dataset(T, sz)

julia> comp = mesh["my_first_record"]
julia> reset_dataset!(comp, dset)
julia> set_position!(comp, (0.0, 0.0))

julia> store_chunk(comp, data, off, sz)

julia> close(iter)
```

## Reading a file

```Julia
julia> filename = "hello.json"
julia> series = Series(filename, ACCESS_READ_ONLY)
julia> println("name: ", name(series))
name: hello

julia> println("author: ", author(series))
author: Erik Schnetter <schnetter@gmail.com>

julia> println("iterations: ", keys(iterations(series)))
iterations: [0]

julia> iter = iterations(series)[0]

julia> println("meshes: ", keys(meshes(iter)))
julia> mesh = meshes(iter)["my_first_mesh"]

julia> println("mesh record components: ", keys(mesh))
julia> comp = mesh["my_first_record"]
julia> T = eltype(comp)
Int64

julia> D = ndims(comp)
2

julia> sz = size(comp)
(2, 3)

julia> pos = position(comp)
(0, 0)

julia> println("type: ", T)
type: Int64

julia> println("ndims: ", D)
ndims: 2

julia> println("size: ", sz)
size: (2, 3)

julia> println("position: ", pos)
position: (0, 0)

julia> chunks = available_chunks(comp)
1-element Vector{ChunkInfo{2}}:
 ChunkInfo{2}((0, 0), (2, 3))

julia> datas = Array{T,D}[]
julia> for chunk in chunks
           off = chunk.offset
           ext = chunk.extent
           data = Array{T}(undef, ext)
           load_chunk(comp, data, off, ext)
           push!(datas, data)
       end
julia> 
julia> close(iter)
julia> 
julia> for (chunk,data) in zip(chunks,datas)
           println("Chunk:")
           println("    offset: ", chunk.offset)
           println("    extent: ", chunk.extent)
           println("    minimum: ", minimum(data))
           println("    maximum: ", maximum(data))
       end
Chunk:
    offset: (0, 0)
    extent: (2, 3)
    minimum: 11
    maximum: 23
```
