function test_UnitDimension()
    @testset "UnitDimension" begin
        @test UnitDimension isa Type
        @test UNITDIMENSION_L isa UnitDimension
        @test UNITDIMENSION_M isa UnitDimension
        @test UNITDIMENSION_T isa UnitDimension
        @test UNITDIMENSION_I isa UnitDimension
        @test UNITDIMENSION_θ isa UnitDimension
        @test UNITDIMENSION_N isa UnitDimension
        @test UNITDIMENSION_J isa UnitDimension

        @test UNITDIMENSION_L == UNITDIMENSION_L
        @test UNITDIMENSION_L ≠ UNITDIMENSION_M
        @test hash(UNITDIMENSION_L) isa UInt
        @test hash(UNITDIMENSION_L) ≠ hash(convert(UInt, UNITDIMENSION_L))
    end
end
