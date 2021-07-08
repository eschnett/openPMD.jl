function test_BaseRecordComponent(comp::BaseRecordComponent)
    @testset "BaseRecordComponent" begin
        @test BaseRecordComponent isa Type
        @test isabstracttype(BaseRecordComponent)

        #TODO comp = ???
        #TODO comp::BaseRecordComponent
        #TODO @test unit_SI(comp) isa CxxDouble

        #TODO
    end
end
