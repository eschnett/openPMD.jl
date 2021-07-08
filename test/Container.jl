function test_Container(cont::Container{T,K}) where {T,K}
    @testset "Container{$T,$K}" begin
        @test Container{T,K} isa Type
        @test isabstracttype(Container{T,K})

        @test isempty(cont) isa Bool
        @test (length(cont) == 0) == isempty(cont)

        # This is apparently not how Containers work, at least not the
        # ones we are testing here.
        #
        # empty!(cont)
        # @test isempty(cont)
        # @test length(cont) == 0
        # 
        # newval = get!(cont, "bubble")
        # @test length(cont) == 1
        # @test cont["bubble"] == newval
        # 
        # cont["bobble"] = newval
        # @test length(cont) == 2
        # 
        # @test count(cont, "bubble") == 1
        # @test "bubble" ∈ cont
        # 
        # delete!(cont, "bobble")
        # @test length(cont) == 1
        # 
        # @test keys(cont) == ["bubble"]

        # @cxxdereference Base.values(cont::Container) = values1(cont)
        # @cxxdereference Base.collect(cont::Container) = collect1(cont)
    end
end
