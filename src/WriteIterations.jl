# WriteIterations

@doc """
   mutable struct WriteIterations
        ...
   end
""" WriteIterations
# export WriteIterations

@doc """
    getindex(iters::WriteIterations, key)::Iteration
    iters[key]::Iteration

This function inserts a new `Iteration` into the `WriteIterations`
object if they key does not yet exist. This is the proper way to
create a new `Iteration`.

There is no corresponding `setindex!` method since `Iteration` objects
cannot exist independent of a `Series`.
""" Base.getindex
@cxxdereference Base.getindex(iters::WriteIterations, key) = getindex1!(iters, key)::CxxRef{Iteration}
