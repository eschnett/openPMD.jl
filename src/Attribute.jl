# Attribute

# We hide the `Attribute` class from the public; it shouldn't be necessary for Julia code.

# If we decide to make it visible, then it should be as `CxxRef{Attribute}`.

@doc """
    mutable struct Attribute
        ...  
    end
""" Attribute
# export Attribute

@cxxdereference dtype(attr::Attribute) = julia_type(dtype1(attr))::Type

for (otype, jtype) in abstract_julia_types
    @eval begin
        @cxxdereference Base.getindex(attr::Attribute, ::Type{<:$jtype}) = $(Symbol("get1_", type_symbols[otype]))(attr)::$jtype
    end
end

@doc """
    getindex(attr::Attribute)
    attr[]
""" Base.getindex

@cxxdereference Base.getindex(attr::Attribute) = getindex(attr, dtype(attr))::AbstractOpenPMDType
