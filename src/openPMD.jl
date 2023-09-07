module openPMD

using CxxWrap
using MPI
using Memoize
using StaticArrays

# @wrapmodule "/Users/eschnett/src/openPMD-api/build/lib/libopenPMD_jl.dylib"

# Build openPMD_api in Yggdrasil via:
#     julia --color=yes build_tarballs.jl --debug --verbose --deploy=local --register x86_64-apple-darwin
# Then use the resulting package via:
#     Pkg> add openPMD_api_jll
#     Pkg> develop openPMD_api_jll

using openPMD_api_jll
@wrapmodule openPMD_api_jll.get_libopenPMD_jl_path

__init__() = @initcxx

################################################################################

# TODO:
#
# - do we really need all the `@cxxdereference` macros? yes we do.
#   maybe we need it only for explicitly declared functions and not
#   for wrapped functions? apparently that's true.
#
# - do we really need different names to call templated functions?
#   probably not, at least not for constructors. but we do need them
#   if only the return type differs, e.g. for various `get<T>`
#   functions. actually, yes we do, because this prevents CxxWrap's
#   automatic type conversion.
#
# - we might need to care how types are mapped, i.e. whether we use a
#   wrapped type directly, or a `CxxRef`, etc. this probably differs
#   depending on the C++ type: those types that are essentially a
#   `std::shared_ptr` should be wrapped directly, while those that are
#   objects should be wrapped as `CxxRef`. or should we introduce the
#   `std::shared_ptr` on the C++ side?
#
# - should `Vector{T}` in `OpenPMDTypes` be replaced by
#   `StdVector{T}`?

################################################################################

# Convert an MPI handle to a `UInt` of the respective size. This makes
# assumptions about how MPI handles are implemented, but they need to
# be either C integers or C pointers.
make_uint(h::Union{Int32,UInt32}) = h % UInt32
make_uint(h::Union{Int64,UInt64}) = h % UInt64
@assert sizeof(Ptr) == sizeof(UInt)
make_uint(h::Ptr) = h % UInt

# Convert Julia vectors to `StdVector`, leave all other types alone
wrap_vector(xs::AbstractVector) = StdVector(xs)
wrap_vector(x) = x

################################################################################

# The order in which these files are included matters. The order here
# should mirror the order in the file `openPMD.cpp` that implements
# the respective types, constants, and functions.

include("Access.jl")
include("ChunkInfo.jl")
include("Datatype.jl")
include("Format.jl")
include("UnitDimension.jl")

include("Attribute.jl")
include("Attributable.jl")
include("Dataset.jl")

# Forward declarations
abstract type AbstractIteration <: Attributable end
abstract type AbstractSeries <: Attributable end

include("BaseRecordComponent.jl")
include("RecordComponent.jl")
include("MeshRecordComponent.jl")

include("Mesh.jl")

include("Iteration.jl")

include("WriteIterations.jl")

include("Series.jl")

include("version.jl")

include("RecordComponent_Chunks.jl")

end
