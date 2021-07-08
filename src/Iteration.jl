# Iteration

"""
    struct Iteration <: Attributable
        ...
    end
"""
struct Iteration <: AbstractIteration
    cxx_object::CxxRef{CXX_Iteration}
    series::AbstractSeries
end
export Iteration

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
    return release_buffers!(iter.series)
end

"""
    closed(iter::Iteration)::Bool
"""
closed(iter::Iteration) = cxx_closed(iter.cxx_object)::Bool
export closed

"""
    closed_by_writer(iter::Iteration)::Bool
"""
closed_by_writer(iter::Iteration) = cxx_closed_by_writer(iter.cxx_object)::Bool
export closed_by_writer

"""
    get_mesh(iter::Iteration, key::AbstractString)::Mesh
"""
get_mesh(iter::Iteration, key::AbstractString) = Mesh(cxx_meshes(iter.cxx_object)[key], iter)
export get_mesh
