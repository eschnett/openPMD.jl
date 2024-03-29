# Mesh

@doc """
    @enum Geometry begin
        GEOMETRY_cartesian
        GEOMETRY_theta_mode
        GEOMETRY_cylindrical
        GEOMETRY_spherical
        GEOMETRY_other
    end
""" Geometry
export Geometry, GEOMETRY_cartesian, GEOMETRY_theta_mode, GEOMETRY_cylindrical, GEOMETRY_spherical, GEOMETRY_other

@doc """
    @enum DataOrder begin
        DATAORDER_C
        DATAORDER_F
    end
""" DataOrder
export DataOrder, DATAORDER_C, DATAORDER_F

"""
    struct Mesh <: Attributable
        ...
    end
"""
struct Mesh <: Attributable   # AbstractDict{AbstractString,MeshRecordComponent}
    cxx_object::CxxRef{CXX_Mesh}
    iteration::AbstractIteration
end
export Mesh

"""
    eltype(::Type{Mesh})::Type
    eltype(::Mesh)::Type
"""
Base.eltype(::Type{Mesh}) = MeshRecordComponent
Base.eltype(::Mesh) = eltype(Mesh)

"""
    keytype(::Type{Mesh})::Type
    keytype(::Mesh)::Type
"""
Base.keytype(::Type{Mesh}) = AbstractString
Base.keytype(::Mesh) = keytype(Mesh)

"""
    isempty(mesh::Mesh)
"""
Base.isempty(mesh::Mesh) = cxx_empty(mesh.cxx_object)::Bool

"""
    length(mesh::Mesh)
"""
Base.length(mesh::Mesh) = Int(cxx_length(mesh.cxx_object))

"""
    empty!(mesh::Mesh)
"""
Base.empty!(mesh::Mesh) = (cxx_empty!(mesh.cxx_object); mesh)

"""
    getindex(mesh::Mesh, name::AbstractString)::MeshRecordComponent
    mesh[name]
"""
Base.getindex(mesh::Mesh, name::AbstractString) = MeshRecordComponent(cxx_getindex(mesh.cxx_object, name), mesh.iteration)

"""
    setindex!(mesh::Mesh, comp::MeshRecordComponent, name::AbstractString)
    mesh[name] = comp
"""
function Base.setindex!(mesh::Mesh, comp::MeshRecordComponent, name::AbstractString)
    cxx_setindex!(mesh.cxx_object, comp.cxx_object, name)
    return mesh
end

"""
    count(mesh::Mesh, name::AbstractString)::Int
"""
Base.count(mesh::Mesh, name::AbstractString) = Int(cxx_count(mesh.cxx_object, name))

"""
    in(name::AbstractString, mesh::Mesh)::Bool
    name in mesh
"""
Base.in(name::AbstractString, mesh::Mesh) = cxx_contains(mesh.cxx_object, name)::Bool

"""
    delete!(mesh::Mesh, name::AbstractString)
"""
Base.delete!(mesh::Mesh, name::AbstractString) = (cxx_delete!(mesh.cxx_object, name); mesh)

"""
    keys(mesh::Mesh)::AbstractVector{<:AbstractString}
"""
Base.keys(mesh::Mesh) = cxx_keys(mesh.cxx_object)

"""
    unit_dimension(mesh::Mesh)::SVector{7,Double}
"""
unit_dimension(mesh::Mesh) = cxx_unit_dimension(mesh.cxx_object)
export unit_dimension

"""
    isscalar(mesh::Mesh)::Bool
"""
isscalar(mesh::Mesh) = cxx_isscalar(mesh.cxx_object)::Bool
export isscalar

"""
    geometry(mesh::Mesh)::Geometry
"""
geometry(mesh::Mesh) = cxx_geometry(mesh.cxx_object)::Geometry
export geometry

"""
    set_geometry!(mesh::Mesh, geom::Geometry)
"""
set_geometry!(mesh::Mesh, geom::Geometry) = cxx_set_geometry!(mesh.cxx_object, geom)
export set_geometry!

"""
    geometry_parameters(mesh::Mesh)::AbstractString
"""
geometry_parameters(mesh::Mesh) = cxx_geometry_parameters(mesh.cxx_object)::AbstractString
export geometry_parameters

"""
    set_geometry_parameters!(mesh::Mesh, params::AbstractString)
"""
set_geometry_parameters!(mesh::Mesh, params::AbstractString) = cxx_set_geometry_parameters!(mesh.cxx_object, params)
export set_geometry_parameters!

"""
    data_order(mesh::Mesh)::DataOrder
"""
data_order(mesh::Mesh) = cxx_data_order(mesh.cxx_object)::DataOrder
export data_order

"""
    set_data_order!(mesh::Mesh, order::DataOrder)
"""
set_data_order!(mesh::Mesh, order::DataOrder) = cxx_set_data_order!(mesh.cxx_object, order)
export set_data_order!

"""
    axis_labels(mesh::Mesh)::AbstractVector{<:AbstractString}
"""
axis_labels(mesh::Mesh) = cxx_axis_labels(mesh.cxx_object)::AbstractVector{<:AbstractString}
export axis_labels

"""
    set_axis_labels!(mesh::Mesh, labels::AbstractVector{<:AbstractString})
"""
set_axis_labels!(mesh::Mesh, labels::AbstractVector{<:AbstractString}) = cxx_set_axis_labels1!(mesh.cxx_object, wrap_vector(labels))
export set_axis_labels!

"""
    grid_spacing(mesh::Mesh)::AbstractVector{CxxDouble}
"""
grid_spacing(mesh::Mesh) = cxx_grid_spacing(mesh.cxx_object)::AbstractVector{CxxDouble}
export grid_spacing

"""
    set_grid_spacing!(mesh::Mesh, spacing::AbstractVector{CxxDouble})
"""
set_grid_spacing!(mesh::Mesh, spacing::AbstractVector{CxxDouble}) = cxx_set_grid_spacing1!(mesh.cxx_object, wrap_vector(spacing))
export set_grid_spacing!

"""
    grid_global_offset(mesh::Mesh)::AbstractVector{CxxDouble}
"""
grid_global_offset(mesh::Mesh) = cxx_grid_global_offset(mesh.cxx_object)::AbstractVector{CxxDouble}
export grid_global_offset

"""
    set_grid_global_offset!(mesh::Mesh, offset::AbstractVector{CxxDouble})
"""
function set_grid_global_offset!(mesh::Mesh, offset::AbstractVector{CxxDouble})
    return cxx_set_grid_global_offset1!(mesh.cxx_object, wrap_vector(offset))
end
export set_grid_global_offset!

"""
    grid_unit_SI(mesh::Mesh)::CxxDouble
"""
grid_unit_SI(mesh::Mesh) = cxx_grid_unit_SI(mesh.cxx_object)::CxxDouble
export grid_unit_SI

"""
    set_grid_unit_SI!(mesh::Mesh, unit::CxxDouble)
"""
set_grid_unit_SI!(mesh::Mesh, unit::CxxDouble) = cxx_set_grid_unit_SI!(mesh.cxx_object, unit)
export set_grid_unit_SI!

"""
    set_unit_dimension!(mesh::Mesh, unit_dim::Dict{UnitDimension,<:AbstractFloat})
"""
function set_unit_dimension!(mesh::Mesh, unit_dim::Dict{UnitDimension,<:AbstractFloat})
    return cxx_set_unit_dimension1!(mesh.cxx_object,
                                    SVector{7,Float64}(get(unit_dim, UNITDIMENSION_L, 0.0), get(unit_dim, UNITDIMENSION_M, 0.0),
                                                       get(unit_dim, UNITDIMENSION_T, 0.0), get(unit_dim, UNITDIMENSION_I, 0.0),
                                                       get(unit_dim, UNITDIMENSION_θ, 0.0), get(unit_dim, UNITDIMENSION_N, 0.0),
                                                       get(unit_dim, UNITDIMENSION_J, 0.0)))
end
export set_unit_dimension!

"""
    time_offset(mesh::Mesh)::CxxDouble
"""
time_offset(mesh::Mesh) = cxx_time_offset(mesh.cxx_object)::CxxDouble
export time_offset

"""
    set_time_offset!(mesh::Mesh, unit::CxxDouble)
"""
set_time_offset!(mesh::Mesh, unit::CxxDouble) = cxx_set_time_offset!(mesh.cxx_object, unit)
export set_time_offset!

"""
    SCALAR()::AbstractString
"""
SCALAR() = cxx_SCALAR()
