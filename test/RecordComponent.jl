function test_RecordComponent(comp::RecordComponent)
    @testset "RecordComponent" begin
        @test RecordComponent isa Type
        @test isabstracttype(RecordComponent)

        #TODO
    end
end
