# MeshRecordComponent

"""
    mutable struct MeshRecordComponent <: RecordComponent
        ...
    end

This holds (a pointer to) a C++ MeshRecordComponent.
"""
struct MeshRecordComponent <: RecordComponent
    cxx_object::CxxRef{CXX_MeshRecordComponent}
    iteration::AbstractIteration
end
export MeshRecordComponent

"""
    position(comp::MeshRecordComponent)::NTuple{D,CxxDouble}
"""
Base.position(comp::MeshRecordComponent) = Int.(Tuple(cxx_position(comp.cxx_object)))

"""
    set_position!(comp::MeshRecordComponent, newpos::Union{NTuple{D,CxxDouble}, AbstractVector{CxxDouble}})
"""
function set_position!(comp::MeshRecordComponent, newpos::AbstractVector{CxxDouble})
    return cxx_set_position!(comp.cxx_object, wrap_vector(newpos))
end
set_position!(comp::MeshRecordComponent, newpos::NTuple{D,CxxDouble} where {D}) = set_position!(comp, CxxDouble[newpos...])
export set_position!

# """
#     make_constant(comp::MeshRecordComponent, value::OpenMPType)
# """
# function make_constant end
export make_constant
for (otype, jtype) in julia_types
    @eval begin
        function make_constant(comp::MeshRecordComponent, value::$jtype)
            return $(Symbol("cxx_make_constant_", type_symbols[otype]))(comp.cxx_object, value)
        end
    end
end
