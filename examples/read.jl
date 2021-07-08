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

    for (chunk, data) in zip(chunks, datas)
        println("Chunk:")
        println("    offset: ", chunk.offset)
        println("    extent: ", chunk.extent)
        println("    minimum: ", minimum(data))
        println("    maximum: ", maximum(data))
    end

    return
end

filename = "hello.json"
main(filename)
