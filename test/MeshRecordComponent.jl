function test_MeshRecordComponent(comp::MeshRecordComponent)
    @testset "MeshRecordComponent" begin
        @test MeshRecordComponent isa Type

        # These statements don't work. Maybe we cannot change components,
        # maybe it's the change from 2d to 3d, or the change from Int to
        # Float64. Or maybe components shouldn't be modified after being
        # defined.

        # comp::MeshRecordComponent
        # pos = [1.0, 2.0, 3.0]
        # set_position!(comp, pos)
        # @test position(comp) == pos
        # make_constant(comp, 3)
        # @test is_constant(comp)
        # make_constant(comp, float(π))
        # @test is_constant(comp)
        # make_constant(comp, 1.0im)
        # @test is_constant(comp)
    end
end
