function test_Attributable(attr::Attributable)
    @testset "Attributable ($(typeof(attr)))" begin
        @test Attributable isa Type
        @test isabstracttype(Attributable)

        set_attribute!(attr, "hello", 42)
        set_attribute!(attr, "world", [float(π)])
        @test get_attribute(attr, "hello") === 42
        @test get_attribute(attr, "world") == [float(π)]
        # Not all backends support deleting attributes
        # delete_attribute!(attr, "hello")
        # @test !contains_attribute(attr, "hello")
        @test contains_attribute(attr, "world")
        @test "world" ∈ attributes(attr)
        @test num_attributes(attr) ≥ 1

        set_comment!(attr, "abc αβγ")
        @test comment(attr) == "abc αβγ"

        # Don't flush or close anything until the end of the test
        # series_flush(attr)
    end
end
