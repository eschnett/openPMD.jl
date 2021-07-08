using openPMD

function main(filename::AbstractString)
    println("Reading file \"$filename\"...")

    series = Series(filename, ACCESS_READ_ONLY)
    println("name: ", name(series))
    println("author: ", author(series))

    iter = get_iteration(series, 0)

    mesh = get_mesh(iter, "my_first_mesh")

    comp = get_component(mesh, "my_first_record")
    T = eltype(comp)
    D = ndims(comp)
    sz = size(comp)
    off = (0, 0)
    println("type: ", T)
    println("ndims: ", D)
    println("size: ", sz)
    println("position: ", position(comp))

    data = Array{T}(undef, sz)
    load_chunk(comp, data, off, sz)

    close(iter)

    return
end

filename = "hello.json"
main(filename)
