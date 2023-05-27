# Series

"""
    mutable struct Series <: Attributable
        ...
    end
    Series()
    Series(filepath::AbstractString, access::Access, comm::MPI.Comm, options::AbstractString="{}")
    Series(filepath::AbstractString, access::Access, options::AbstractString="{}")
"""
mutable struct Series <: AbstractSeries
    cxx_object::CXX_Series
end
Series(filepath::AbstractString, access::Access, options::AbstractString="{}") = Series(CXX_Series(filepath, access, options))
function Series(filepath::AbstractString, access::Access, comm::MPI.Comm, options::AbstractString="{}")
    return Series(cxx_Series(filepath, access, make_uint(comm.val), options))
end
export Series

"""
    openPMD_version(series::Series)::AbstractString
"""
openPMD_version(series::Series) = cxx_openPMD_version(series.cxx_object)::AbstractString
export openPMD_version

"""
    set_openPMD_version!(series::Series, version::AbstractString)
"""
set_openPMD_version!(series::Series, version::AbstractString) = cxx_set_openPMD_version!(series.cxx_object, version)
export set_openPMD_version!

"""
    openPMD_extension(series::Series)::UInt32
"""
openPMD_extension(series::Series) = cxx_openPMD_extension(series.cxx_object)::UInt32
export openPMD_extension

"""
    set_openPMD_extension!(series::Series, extension::AbstractString)
"""
set_openPMD_extension!(series::Series, extension::UInt32) = cxx_set_openPMD_extension!(series.cxx_object, extension)
export set_openPMD_extension!

"""
    base_path(series::Series)::AbstractString
"""
base_path(series::Series) = cxx_base_path(series.cxx_object)::AbstractString
export base_path

"""
    set_base_path!(series::Series, path::AbstractString)
"""
set_base_path!(series::Series, path::AbstractString) = cxx_set_base_path!(series.cxx_object, path)
export set_base_path!

"""
    meshes_path(series::Series)::AbstractString
"""
meshes_path(series::Series) = cxx_meshes_path(series.cxx_object)::AbstractString
export meshes_path

"""
    set_meshes_path!(series::Series, path::AbstractString)
"""
set_meshes_path!(series::Series, path::AbstractString) = cxx_set_meshes_path!(series.cxx_object, path)
export set_meshes_path!

"""
    particles_path(series::Series)::AbstractString
"""
particles_path(series::Series) = cxx_particles_path(series.cxx_object)::AbstractString
export particles_path

"""
    set_particles_path!(series::Series, path::AbstractString)
"""
set_particles_path!(series::Series, path::AbstractString) = cxx_set_particles_path!(series.cxx_object, path)
export set_particles_path!

"""
    author(series::Series)::AbstractString
"""
author(series::Series) = cxx_author(series.cxx_object)::AbstractString
export author

"""
    set_author!(series::Series, author::AbstractString)
"""
set_author!(series::Series, author::AbstractString) = cxx_set_author!(series.cxx_object, author)
export set_author!

"""
    software(series::Series)::AbstractString
"""
software(series::Series) = cxx_software(series.cxx_object)::AbstractString
export software

"""
    set_software!(series::Series, software::AbstractString, version::AbstractString="unspecified")
"""
function set_software!(series::Series, software::AbstractString, version::AbstractString="unspecified")
    return cxx_set_software!(series.cxx_object, software, version)
end
export set_software!

"""
    software_version(series::Series)::AbstractString
"""
software_version(series::Series) = cxx_software_version(series.cxx_object)::AbstractString
export software_version

"""
    date(series::Series)::AbstractString
"""
date(series::Series) = cxx_date(series.cxx_object)::AbstractString
export date

"""
    set_date!(series::Series, date::AbstractString)
"""
set_date!(series::Series, date::AbstractString) = cxx_set_date!(series.cxx_object, date)
export set_date!

"""
    software_dependencies(series::Series)::AbstractString
"""
software_dependencies(series::Series) = cxx_software_dependencies(series.cxx_object)::AbstractString
export software_dependencies

"""
    set_software_dependencies!(series::Series, dependencies::AbstractString)
"""
function set_software_dependencies!(series::Series, dependencies::AbstractString)
    return cxx_set_software_dependencies!(series.cxx_object, dependencies)
end
export set_software_dependencies!

"""
    machine(series::Series)::AbstractString
"""
machine(series::Series) = cxx_machine(series.cxx_object)::AbstractString
export machine

"""
    set_machine!(series::Series, machine::AbstractString)
"""
set_machine!(series::Series, machine::AbstractString) = cxx_set_machine!(series.cxx_object, machine)
export set_machine!

# TODO: type.method("iteration_encoding", &Series::iterationEncoding);
# TODO: type.method("set_iteration_encoding!", &Series::setIterationEncoding);

"""
    iteration_format(series::Series)::AbstractString
"""
iteration_format(series::Series) = cxx_iteration_format(series.cxx_object)::AbstractString
export iteration_format

"""
    set_iteration_format!(series::Series, format::AbstractString)
"""
set_iteration_format!(series::Series, format::AbstractString) = cxx_set_iteration_format!(series.cxx_object, format)
export set_iteration_format!

"""
    name(series::Series)::AbstractString
"""
name(series::Series) = cxx_name(series.cxx_object)::AbstractString
export name

"""
    set_name!(series::Series, name::AbstractString)
"""
set_name!(series::Series, name::AbstractString) = cxx_set_name!(series.cxx_object, name)
export set_name!

"""
    backend(series::Series)::AbstractString
"""
backend(series::Series) = cxx_backend(series.cxx_object)::AbstractString
export backend

"""
    flush(series::Series, backendConfig::AbstractString="{}")::Nothing
"""
function Base.flush(series::Series, backendConfig::AbstractString="{}")
    cxx_flush(series.cxx_object, backendConfig)
    return nothing
end

"""
    isvalid(series::Series)::Bool
"""
Base.isvalid(series::Series) = cxx_isvalid(series.cxx_object)::Bool

"""
    struct Iterations   # <: AbstractDict{Int,Iteration}
        ...
    end
"""
struct Iterations   # <: AbstractDict{Int,Iteration}
    cxx_object::CxxRef{CXX_Container{CXX_Iteration,UInt64}}
    series::AbstractSeries
end
export Iterations

"""
    eltype(::Type{Iterations})::Type
    eltype(::Iterations)::Type
"""
Base.eltype(::Type{Iterations}) = Iteration
Base.eltype(::Iterations) = eltype(Iterations)

"""
    keytype(::Type{Iterations})::Type
    keytype(::Iterations)::Type
"""
Base.keytype(::Type{Iterations}) = Int
Base.keytype(::Iterations) = keytype(Iterations)

"""
    isempty(iters::Iterations)
"""
Base.isempty(iters::Iterations) = cxx_empty(iters.cxx_object)::Bool

"""
    length(iters::Iterations)
"""
Base.length(iters::Iterations) = Int(cxx_length(iters.cxx_object))

"""
    empty!(iters::Iterations)
"""
Base.empty!(iters::Iterations) = (cxx_empty!(iters.cxx_object); iters)

"""
    getindex(iters::Iterations, n::Integer)::IterationsRecordComponent
    iters[n]
"""
Base.getindex(iters::Iterations, n::Integer) = Iteration(cxx_getindex(iters.cxx_object, UInt64(n)), iters.series)

"""
    setindex!(iters::Iterations, iter::Iteration, n::Integer)
    iters[n] = iter
"""
function Base.setindex!(iters::Iterations, iter::Iteration, n::Integer)
    return (cxx_setindex!(iters.cxx_object, iter.cxx_object, UInt64(n)); iters)
end

"""
    count(iters::Iterations, n::Integer)::Int
"""
Base.count(iters::Iterations, n::Integer) = Int(cxx_count(iters.cxx_object, UInt64(n)))

"""
    in(n::Integer, iters::Iterations)::Bool
    n in iters
"""
Base.in(n::Integer, iters::Iterations) = cxx_contains(iters.cxx_object, UInt64(n))::Bool

"""
    delete!(iters::Iterations, n::Integer)
"""
Base.delete!(iters::Iterations, n::Integer) = (cxx_delete!(iters.cxx_object, UInt64(n)); iters)

"""
    keys(iters::Iterations)::AbstractVector{Int}
"""
Base.keys(iters::Iterations) = Int.(cxx_keys(iters.cxx_object))

# TODO: Julia iteration interface (`iterate`...) etc.

"""
     iterations(series::Series)::Iterations
"""
iterations(series::Series) = Iterations(cxx_iterations(series.cxx_object), series)
export iterations

# @doc """
#     write_iterations(series::Series)
# """ write_iterations
# export write_iterations
