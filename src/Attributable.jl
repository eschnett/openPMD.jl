# Attributable

"""
    abstract type Attributable end
"""
abstract type Attributable end
export Attributable

"""
    set_attribute!(attr::Attributable, key::AbstractString, value::OpenPMDType)
"""
function set_attribute!(attr::Attributable, key::AbstractString, value::OpenPMDType)
    cxx_set_attribute!(attr.cxx_object, key, value)
    return attr
end
export set_attribute!
for (otype, jtype) in julia_types
    @eval begin
        @cxxdereference function cxx_set_attribute!(attr::CXX_Attributable, key::AbstractString, value::$jtype)
            $(Symbol("cxx_set_attribute_", type_symbols[otype], "!"))(attr, key, wrap_vector(value))
            return attr
        end
    end
end

"""
    get_attribute(attr::Attributable, key::AbstractString)::OpenPMDType
"""
get_attribute(attr::Attributable, key::AbstractString) = cxx_get_attribute(attr.cxx_object, key)[]
export get_attribute

"""
    delete_attribute!(attr::Attributable, key::AbstractString)
"""
delete_attribute!(attr::Attributable, key::AbstractString) = cxx_delete_attribute!(attr.cxx_object, key)
export delete_attribute!

"""
    attributes(attr::Attributable)::AbstractVector{<:AbstractString}
"""
attributes(attr::Attributable) = cxx_attributes(attr.cxx_object)::AbstractVector{<:AbstractString}
export attributes

"""
    num_attributes(attr::Attributable)::Int
"""
num_attributes(attr::Attributable) = Int(cxx_num_attributes(attr.cxx_object))
export num_attributes

"""
    contains_attribute(attr::Attributable, key::AbstractString)::Bool
"""
contains_attribute(attr::Attributable, key::AbstractString) = cxx_contains_attribute(attr.cxx_object, key)::Bool
export contains_attribute

"""
    comment(attr::Attributable)::AbstractString
"""
comment(attr::Attributable) = cxx_comment(attr.cxx_object)::AbstractString
export comment

"""
    set_comment!(attr::Attributable, comment::AbstractString)
"""
set_comment!(attr::Attributable, comment::AbstractString) = cxx_set_comment!(attr.cxx_object, comment)
export set_comment!

"""
    series_flush(attr::Attributable)
"""
series_flush(attr::Attributable) = cxx_series_flush(attr.cxx_object)
export series_flush
