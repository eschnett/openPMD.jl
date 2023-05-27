function test_Format()
    @testset "Format" begin
        @test Format isa Type
        @test FORMAT_HDF5 isa Format
        @test FORMAT_ADIOS2_BP isa Format
        @test FORMAT_ADIOS2_BP4 isa Format
        @test FORMAT_ADIOS2_BP5 isa Format
        @test FORMAT_ADIOS2_SST isa Format
        @test FORMAT_ADIOS2_SSC isa Format
        @test FORMAT_JSON isa Format
        @test FORMAT_DUMMY isa Format

        @test FORMAT_HDF5 == FORMAT_HDF5
        @test FORMAT_HDF5 ≠ FORMAT_ADIOS2_BP
        @test hash(FORMAT_HDF5) isa UInt
        @test hash(FORMAT_HDF5) ≠ hash(convert(UInt, FORMAT_HDF5))

        exts = get_file_extensions()
        for format in
            [FORMAT_HDF5, FORMAT_ADIOS2_BP, FORMAT_ADIOS2_BP4, FORMAT_ADIOS2_BP5, FORMAT_ADIOS2_SST, FORMAT_ADIOS2_SSC, FORMAT_JSON]
            suf = suffix(format)
            @test suf isa AbstractString
            @test !isempty(suf)
            if suf ∈ exts
                # Only test formats that are supported by this configuration
                # Not all formats can be uniquely recognized by suffix
                want_format = format ∈ [FORMAT_ADIOS_BP, FORMAT_ADIOS2_BP4] ? FORMAT_ADIOS2_BP5 : format
                @test determine_format("hello.$suf") == want_format
            end
        end
    end
end
