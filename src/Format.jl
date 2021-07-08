# Format

@doc """
    @enum Format begin
        FORMAT_HDF5
        FORMAT_ADIOS1
        FORMAT_ADIOS2
        FORMAT_ADIOS2_SST
        FORMAT_ADIOS2_SSC
        FORMAT_JSON
        FORMAT_DUMMY
    end
""" Format
export Format, FORMAT_HDF5, FORMAT_ADIOS1, FORMAT_ADIOS2, FORMAT_ADIOS2_SST, FORMAT_ADIOS2_SSC, FORMAT_JSON, FORMAT_DUMMY

Base.hash(fmt::Format, u::UInt) = hash(hash(convert(UInt, fmt), u), UInt(0x2d9a9364))::UInt

@doc """
    determine_format(filename::AbstractString)::Format
""" determine_format
export determine_format

@doc """
    suffix(format::Format)::AbstractString
""" suffix
export suffix
