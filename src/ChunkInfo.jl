# ChunkInfo

"""
    const Extent = Union{NTuple{D,Int},SVector{D,Int},Vector{D}}

Extent describes the size (shape) of a dataset. See [`Offset`](@ref).
"""
const Extent{D} = Union{NTuple{D,Int},SVector{D,Int},Vector{D}}
export Extent

# TODO: Don't call `reverse`, use something more efficient
wrap_extent(extent::Vector{UInt64}) = StdVector(reverse(extent))
wrap_extent(extent::Vector) = wrap_extent(Vector{UInt64}(extent))
wrap_extent(extent::SVector) = wrap_extent(UInt64[extent...])
wrap_extent(extent::Tuple) = wrap_extent(UInt64[extent...])

"""
    const Offset = Union{NTuple{D,Int},SVector{D,Int},Vector{D}}

Offset describes the location of a dataset in the containing mesh's
index space. See [`Extent`](@ref).
"""
const Offset{D} = Union{NTuple{D,Int},SVector{D,Int},Vector{D}}
export Offset

wrap_offset(offset) = wrap_extent(offset)

"""
    struct ChunkInfo{D}
        offset::NTuple{D,Int}
        extent::NTuple{D,Int}
    end
"""
struct ChunkInfo{D}
    offset::NTuple{D,Int}
    extent::NTuple{D,Int}
end
export ChunkInfo
ChunkInfo(chunks::CXX_ChunkInfo) = ChunkInfo(Int.(reverse(Tuple(cxx_offset(chunks)))), Int.(reverse(Tuple(cxx_extent(chunks)))))
