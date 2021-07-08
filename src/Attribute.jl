# Attribute

# We hide the `Attribute` class from the public; it shouldn't be necessary for Julia code.

# If we decide to make it visible, then it should be as `CxxRef{Attribute}`.

@cxxdereference dtype(attr::CXX_Attribute) = julia_type(cxx_dtype(attr))::Type

for (otype, jtype) in abstract_julia_types
    @eval begin
        @cxxdereference function Base.getindex(attr::CXX_Attribute, ::Type{<:$jtype})
            return $(Symbol("cxx_get_", type_symbols[otype]))(attr)::$jtype
        end
    end
end

@cxxdereference Base.getindex(attr::CXX_Attribute) = attr[dtype(attr)]::AbstractOpenPMDType
