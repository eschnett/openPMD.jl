# MeshRecordComponent

@doc """
    mutable struct MeshRecordComponent <: RecordComponent
        ...
    end

This holds (a pointer to) a C++ MeshRecordComponent.
""" MeshRecordComponent
const MeshRecordComponent = CxxRef{MeshRecordComponent1}
export MeshRecordComponent

@doc """
    position(comp::MeshRecordComponent)::AbstractVector{CxxDouble}
""" Base.position
Base.position(comp::MeshRecordComponent) = position1(comp[])

@doc """
    set_position!(comp::MeshRecordComponent, newpos::Union{NTuple{D,CxxDouble}, AbstractVector{CxxDouble}})
""" set_position!
export set_position!
set_position!(comp::MeshRecordComponent, newpos::AbstractVector{CxxDouble}) = set_position1!(comp[], wrap_vector(newpos))
set_position!(comp::MeshRecordComponent, newpos::NTuple{D,CxxDouble} where {D}) = set_position!(comp, CxxDouble[newpos...])

@doc """
    make_constant(comp::MeshRecordComponent, value::OpenMPType)
""" make_constant
export make_constant
for (otype, jtype) in julia_types
    @eval begin
        function make_constant(comp::MeshRecordComponent, value::$jtype)
            return $(Symbol("make_constant1_", type_symbols[otype]))(comp[], value)
        end
    end
end
