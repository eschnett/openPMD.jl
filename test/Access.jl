function test_Access()
    @testset "Access" begin
        @test Access isa Type
        @test ACCESS_READ_ONLY isa Access
        @test ACCESS_READ_WRITE isa Access
        @test ACCESS_CREATE isa Access

        @test ACCESS_READ_ONLY == ACCESS_READ_ONLY
        @test ACCESS_READ_ONLY ≠ ACCESS_READ_WRITE
        @test hash(ACCESS_READ_ONLY) isa UInt
        @test hash(ACCESS_READ_ONLY) ≠ hash(convert(UInt, ACCESS_READ_ONLY))
    end
end
