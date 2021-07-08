# BaseRecordComponent

"""
   abstract type BaseRecordComponent <: Attributable end
"""
abstract type BaseRecordComponent <: Attributable end
export BaseRecordComponent

"""
    unit_SI(comp::BaseRecordComponent)::CxxDouble
"""
unit_SI(comp::BaseRecordComponent) = cxx_unit_SI(comp.cxx_object)::CxxDouble
export unit_SI

"""
    reset_datatype!(comp::BaseRecordComponent, T::Type)
"""
reset_datatype!(comp::BaseRecordComponent, T::Type) = cxx_reset_datatype!(comp.cxx_object, openpmd_type(T))
export reset_datatype!

"""
    eltype(comp::BaseRecordComponent)::Type
"""
Base.eltype(comp::BaseRecordComponent) = julia_type(cxx_get_datatype(comp.cxx_object))

"""
    isconstant(comp::BaseRecordComponent)::Bool
"""
isconstant(comp::BaseRecordComponent) = is_constant(comp.cxx_object)
export isconstant
