# Dataset

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
#             return Dataset($otype, wrap_extent(extent), options)
#         end
#     end
# end

"""
    extend!(dset::Dataset, newextent::Extent)
"""
@cxxdereference extend!(dset::Dataset, newextent::Extent) = cxx_extend!(dset, wrap_extent(newextent))
export extend!

"""
    size(dset::Dataset)
"""
@cxxdereference Base.size(dset::Dataset) = reverse(Int.(Tuple(cxx_extent(dset))))

"""
    eltype(dset::Dataset)
"""
@cxxdereference Base.eltype(dset::Dataset) = julia_type(cxx_dtype(dset))

"""
    ndims(dset::Dataset)
"""
@cxxdereference Base.ndims(dset::Dataset) = Int(cxx_rank(dset))

@doc """
    options(dset::Dataset)::AbstractString
""" options
export options
