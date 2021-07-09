# version

"""
    get_version()::AbstractString
"""
function get_version end
export get_version

"""
    get_standard()::AbstractString
"""
function get_standard end
export get_standard

"""
    get_standard_minimum()::AbstractString
"""
function get_standard_minimum end
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

"""
    get_file_extensions()::AbstractVector{<:AbstractString}
"""
function get_file_extensions end
export get_file_extensions
