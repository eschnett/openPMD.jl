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
filename = "hello.json"
series = Series(filename, ACCESS_CREATE)
set_name!(series, "hello")
set_author!(series, "Erik Schnetter <schnetter@gmail.com>")

iter = get_iteration(series, 0)

mesh = get_mesh(iter, "my_first_mesh")

data = Int[10i + j for i in 1:2, j in 1:3]
T = eltype(data)
off = (0, 0)
sz = size(data)
dset = Dataset(T, sz)

comp = get_component(mesh, "my_first_record")
reset_dataset!(comp, dset)
set_position!(comp, (0.0, 0.0))

store_chunk(comp, data, off, sz)

close(iter)
```

## Reading a file

```Julia
filename = "hello.json"
series = Series(filename, ACCESS_READ_ONLY)
println("name: ", name(series))
println("author: ", author(series))

iter = get_iteration(series, 0)

mesh = get_mesh(iter, "my_first_mesh")

comp = get_component(mesh, "my_first_record")
T = eltype(comp)
D = ndims(comp)
sz = size(comp)
pos = position(comp)
println("type: ", T)
println("ndims: ", D)
println("size: ", sz)
println("position: ", pos)

chunks = available_chunks(comp)
datas = Array{T,D}[]
for chunk in chunks
    off = chunk.offset
    ext = chunk.extent
    data = Array{T}(undef, ext)
    load_chunk(comp, data, off, ext)
    push!(datas, data)
end

close(iter)

for (chunk,data) in zip(chunks,datas)
    println("Chunk:")
    println("    offset: ", chunk.offset)
    println("    extent: ", chunk.extent)
    println("    minimum: ", minimum(data))
    println("    maximum: ", maximum(data))
end
```
