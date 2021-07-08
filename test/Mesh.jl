function test_Mesh(mesh::Mesh)
    @testset "Mesh" begin
        @test Geometry isa Type
        @test GEOMETRY_cartesian isa Geometry
        @test GEOMETRY_theta_mode isa Geometry
        @test GEOMETRY_cylindrical isa Geometry
        @test GEOMETRY_spherical isa Geometry
        @test GEOMETRY_other isa Geometry

        @test DataOrder isa Type
        @test DATAORDER_C isa DataOrder
        @test DATAORDER_F isa DataOrder

        @test Mesh isa Type
    end
end
