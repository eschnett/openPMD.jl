function test_version()
    @testset "version" begin
        @test get_version() isa AbstractString
        @test get_standard() isa AbstractString
        @test get_standard_minimum() isa AbstractString
        vars = get_variants()
        @test vars isa Dict{String,Bool}
        @test "json" ∈ keys(vars)
        @test vars["json"]
        exts = get_file_extensions()
        @test exts isa AbstractVector{<:AbstractString}
        # Only "json" is guaranteed to exist; the other formats depend
        # on ADIOS2, which doesn't support 32-bit architectures
        # @test "bp" ∈ exts
        @test "json" ∈ exts
        # @test "ssc" ∈ exts
        # @test "sst" ∈ exts
    end
end
