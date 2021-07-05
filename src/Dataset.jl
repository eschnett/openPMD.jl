# Dataset

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

@doc """
    mutable struct Dataset
        ...
    end
    Dataset(::Type{<:OpenPMDType}, extent::Extent, options::AbstractString="{}")
    Dataset(extent::Extent)

Datasets only describe a dataset, they do not hold any data. Datasets
are value objects that can be copied.
""" Dataset
export Dataset

function Dataset(T::Type{<:OpenPMDType}, extent::Extent, options::AbstractString="{}")
    return Dataset(openpmd_type(T), wrap_extent(extent), options)
end
Dataset(extent::Extent) = Dataset(wrap_extent(extent))

# for (otype, jtype) in julia_types
#     @eval begin
#         @cxxdereference function Dataset(::Type{$jtype}, extent::Extent, options::AbstractString="{}")
#             return Dataset1($otype, wrap_extent(extent), options)
#         end
#     end
# end

@doc """
    extend!(dset::Dataset, newextent::Extent)
""" extend!
export extend!
extend!(dset::Dataset, newextent::Extent) = extend1!(dset, wrap_extent(newextent))

@doc """
    set_chunk_size!(dset::Dataset, chunk_size::Extent)
""" set_chunk_size!
export set_chunk_size!
set_chunk_size!(dset::Dataset, chunk_size::Extent) = set_chunk_size1!(dset, wrap_extent(chunk_size))

@doc """
    set_compression!(dset::Dataset, compression::AbstractString, level::Int)
""" set_compression!
export set_compression!

@doc """
    set_custom_transform!(dset::Dataset, transform::AbstractString)
""" set_custom_transform!
export set_custom_transform!

"""
    size(dset::Dataset)
"""
Base.size(dset::Dataset) = reverse(Int.(Tuple(extent1(dset))))

"""
    eltype(dset::Dataset)
"""
Base.eltype(dset::Dataset) = julia_type(dtype1(dset))

"""
    ndims(dset::Dataset)
"""
Base.ndims(dset::Dataset) = Int(rank1(dset))

"""
    chunk_size(dset::Dataset)
"""
chunk_size(dset::Dataset) = reverse(Int.(Tuple(chunk_size1(dset))))
export chunk_size

@doc """
    compression(dset::Dataset)::AbstractString
""" compression
export compression

@doc """
    transform(dset::Dataset)::AbstractString
""" transform
export transform

@doc """
    options(dset::Dataset)::AbstractString
""" options
export options
