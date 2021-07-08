# version

@doc """
    get_version()::AbstractString
""" get_version
export get_version

@doc """
    get_standard()::AbstractString
""" get_standard
export get_standard

@doc """
    get_standard_minimum()::AbstractString
""" get_standard_minimum
export get_standard_minimum

"""
    get_variants()::Dict{String,Bool}
"""
function get_variants()
    cxx_variants = cxx_get_variants()
    variants = Dict{String,Bool}()
    for cxx_var in cxx_variants
        variants[first(cxx_var)] = second(cxx_var)
    end
    return variants
end
export get_variants

@doc """
    get_file_extensions()::AbstractVector{<:AbstractString}
""" get_file_extensions
export get_file_extensions
