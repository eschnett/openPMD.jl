using openPMD

function main(filename::AbstractString)
    println("Creating file \"$filename\"...")

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

    close(iter)

    return
end

filename = "hello.json"
main(filename)
# run(`/Users/eschnett/Cactus/view/bin/openpmd-ls $filename`)
