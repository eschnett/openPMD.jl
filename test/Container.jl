@testset "Container{$contT}" begin
    T = contT
    K = contK
    @test Container{T,K} isa Type
    @test isabstracttype(Container{T,K})

    @show typeof(cont)
    @show supertype(typeof(cont))
    @show supertype(supertype(typeof(cont)))
    @show supertype(supertype(supertype(typeof(cont))))
    @show supertype(Mesh)
    @show supertype(supertype(Mesh))
    @show supertype(supertype(supertype(Mesh)))
    #TODO @test cont isa CxxRef{<:Container{T,K}}

    @test isempty(cont) isa Bool
    @test (length(cont) == 0) == isempty(cont)

    # This is apparently not how Containers work, at least not then
    # one we are testing here.
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
