# ChunkInfo

"""
    const Extent = NTuple{D,Int}

Extent describes the size (shape) of a dataset. See [`Offset`](@ref).
"""
const Extent{D} = NTuple{D,Int}
export Extent

# TODO: Don't call `reverse`, use something more efficient
wrap_extent(extent::Vector{UInt64}) = StdVector(reverse(extent))
wrap_extent(extent::AbstractVector) = wrap_extent(Vector{UInt64}(extent))
wrap_extent(extent::Tuple) = wrap_extent(UInt64[extent...])

"""
    const Offset = NTuple{D,Int}

Offset describes the location of a dataset in the containing mesh's
index space. See [`Extent`](@ref).
"""
const Offset{D} = NTuple{D,Int}
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
