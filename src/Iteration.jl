# Iteration

"""
    struct Iteration <: Attributable
        ...
    end
"""
struct Iteration <: AbstractIteration
    cxx_object::CxxRef{CXX_Iteration}
    series::AbstractSeries
    buffers::Vector
    Iteration(cxx_iter::CxxRef{CXX_Iteration}, series::AbstractSeries) = new(cxx_iter, series, [])
end
export Iteration

mark_buffer!(iter::Iteration, buffer) = push!(iter.buffers, buffer)
release_buffers!(iter::Iteration) = empty!(iter.buffers)

"""
    time(iter::Iteration)::CxxDouble
"""
Base.time(iter::Iteration) = cxx_time(iter.cxx_object)

"""
    set_time!(iter::Iteration, time::CxxDouble)
"""
set_time!(iter::Iteration, time::CxxDouble) = cxx_set_time!(iter.cxx_object, time)
export set_time!

"""
    dt(iter::Iteration)::CxxDouble
"""
dt(iter::Iteration) = cxx_dt(iter.cxx_object)
export dt

"""
    set_dt!(iter::Iteration, dt::CxxDouble)
"""
set_dt!(iter::Iteration, dt::CxxDouble) = cxx_set_dt!(iter.cxx_object, dt)
export set_dt!

"""
    time_unit_SI(iter::Iteration)::CxxDouble
"""
time_unit_SI(iter::Iteration) = cxx_time_unit_SI(iter.cxx_object)::CxxDouble
export time_unit_SI

"""
    set_time_unit_SI!(iter::Iteration, time_unit_SI::CxxDouble)
"""
set_time_unit_SI!(iter::Iteration, time_unit_SI::CxxDouble) = cxx_set_time_unit_SI!(iter.cxx_object, time_unit_SI)
export set_time_unit_SI!

"""
    close(iter::Iteration; flush::Bool=true)
"""
function Base.close(iter::Iteration; flush::Bool=true)
    cxx_close(iter.cxx_object, flush)
    release_buffers!(iter)
    return nothing
end

"""
    closed(iter::Iteration)::Bool
"""
closed(iter::Iteration) = cxx_closed(iter.cxx_object)::Bool
export closed

"""
    isopen(iter::Iteration)::Bool
"""
Base.isopen(iter::Iteration) = !cxx_closed(iter.cxx_object)::Bool

"""
    struct Meshes   # <: AbstractDict{AbstractString,Mesh}
        ...
    end
"""
struct Meshes   # <: AbstractDict{AbstractString,Mesh}
    cxx_object::CxxRef{CXX_Container{CXX_Mesh,StdLib.StdString}}
    iteration::AbstractIteration
end
export Meshes

"""
    eltype(::Type{Meshes})::Type
    eltype(::Meshes)::Type
"""
Base.eltype(::Type{Meshes}) = Mesh
Base.eltype(::Meshes) = eltype(Meshes)

"""
    keytype(::Type{Meshes})::Type
    keytype(::Meshes)::Type
"""
Base.keytype(::Type{Meshes}) = AbstractString
Base.keytype(::Meshes) = keytype(Meshes)

"""
    isempty(meshes::Meshes)
"""
Base.isempty(meshes::Meshes) = cxx_empty(meshes.cxx_object)::Bool

"""
    length(meshes::Meshes)
"""
Base.length(meshes::Meshes) = Int(cxx_length(meshes.cxx_object))

"""
    empty!(meshes::Meshes)
"""
Base.empty!(meshes::Meshes) = (cxx_empty!(meshes.cxx_object); meshes)

"""
    getindex(meshes::Meshes, name::AbstractString)::MeshesRecordComponent
    meshes[name]
"""
Base.getindex(meshes::Meshes, name::AbstractString) = Mesh(cxx_getindex(meshes.cxx_object, name), meshes.iteration)

"""
    setindex!(meshes::Meshes, comp::MeshesRecordComponent, name::AbstractString)
    meshes[name] = mesh
"""
Base.setindex!(meshes::Meshes, mesh::Mesh, name::AbstractString) = (cxx_setindex!(meshes.cxx_object, mesh.cxx_object, name); meshes)

"""
    count(meshes::Meshes, name::AbstractString)::Int
"""
Base.count(meshes::Meshes, name::AbstractString) = Int(cxx_count(meshes.cxx_object, name))

"""
    in(name::AbstractString, meshes::Meshes)::Bool
    name in mesh
"""
Base.in(name::AbstractString, meshes::Meshes) = cxx_contains(meshes.cxx_object, name)::Bool

"""
    delete!(meshes::Meshes, name::AbstractString)
"""
Base.delete!(meshes::Meshes, name::AbstractString) = (cxx_delete!(meshes.cxx_object, name); meshes)

"""
    keys(meshes::Meshes)::AbstractVector{<:AbstractString}
"""
Base.keys(meshes::Meshes) = cxx_keys(meshes.cxx_object)

"""
     meshes(iter::Iteration)::Meshes
"""
meshes(iter::Iteration) = Meshes(cxx_meshes(iter.cxx_object), iter)
export meshes
