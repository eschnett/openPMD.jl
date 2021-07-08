function test_Dataset()
    @testset "Dataset" begin
        @test Extent isa Type
        @test Offset isa Type
        @test Dataset isa Type

        data = Int[10i + j for i in 1:2, j in 1:3]
        T = eltype(data)
        off = (0, 0)
        sz = size(data)
        dset = Dataset(T, sz)

        @test size(dset) == sz
        @test eltype(dset) == T
        @test ndims(dset) == length(sz)

        # TODO: test chunk_size, compression, transform, options
    end
end
