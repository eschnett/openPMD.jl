# RecordComponent

@doc """
    @enum Allocation begin
        USER
        API
        AUTO
    end
""" Allocation
export Allocation, USER, API, AUTO

"""
    abstract type RecordComponent <: BaseRecordComponent end
"""
abstract type RecordComponent <: BaseRecordComponent end
export RecordComponent

"""
    set_unit_SI!(comp::RecordComponent, unit::CxxDouble)
"""
set_unit_SI!(comp::RecordComponent, unit::CxxDouble) = cxx_set_unit_SI!(comp.cxx_object, unit)
export set_unit_SI!

"""
    reset_dataset!(comp::RecordComponent, dset::Dataset)
"""
reset_dataset!(comp::RecordComponent, dset::Dataset) = cxx_reset_dataset!(comp.cxx_object, dset)
export reset_dataset!

"""
    ndims(comp::RecordComponent)
"""
Base.ndims(comp::RecordComponent) = Int(cxx_get_dimensionality(comp.cxx_object))

"""
    size(comp::RecordComponent)
"""
Base.size(comp::RecordComponent) = reverse(Int.(Tuple(cxx_get_extent(comp.cxx_object))))

"""
    make_constant(comp::RecordComponent, value::OpenMPType)
"""
function make_constant end
export make_constant
for (otype, jtype) in julia_types
    @eval begin
        function make_constant(comp::RecordComponent, value::$jtype)
            return $(Symbol("cxx_make_constant_", type_symbols[otype]))(comp.cxx_object, value)
        end
    end
end

"""
    make_empty(T::Type, comp::RecordComponent, ndims::Int)
"""
make_empty(T::Type, comp::RecordComponent, ndims::Int) = cxx_make_empty(comp.cxx_object, openpmd_type(T), ndims)
export make_empty

"""
    isempty(comp::RecordComponent)::Bool
"""
Base.isempty(comp::RecordComponent) = cxx_isempty(comp.cxx_object)::Bool
