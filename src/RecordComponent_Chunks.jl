# RecordComponent_Chunks

@doc """
    TODO: update
    data = load_chunk(comp::RecordComponent, offset::Offset, extent::Extent)
""" load_chunk
export load_chunk
# TODO:
# - return IORef
# - take type from dataset
for (otype, jtype) in julia_types
    @eval begin
        @cxxdereference function load_chunk(comp::RecordComponent, buffer::AbstractArray{$jtype}, offset::Offset, extent::Extent)
            # @assert length(offset) == length(extent) == ndims(comp)
            @assert all(extent .>= 0)
            @assert length(buffer) == prod(extent)
            # TODO: check type of comp
            mark_buffer!(comp.iteration, buffer)
            ptr = $(Symbol("create_aliasing_shared_ptr_", type_symbols[otype]))(pointer(buffer))
            $(Symbol("cxx_load_chunk_", type_symbols[otype]))(comp.cxx_object, ptr, wrap_offset(offset), wrap_extent(extent))
            return
        end
    end
end

@doc """
    TODO: update
    store_chunk(comp::RecordComponent, data::AbstractArray, offset::Offset, extent::Extent)
""" store_chunk
export store_chunk
# TODO:
# - take extent from data size
for (otype, jtype) in julia_types
    @eval begin
        @cxxdereference function store_chunk(comp::RecordComponent, data::AbstractArray{$jtype}, offset::Offset, extent::Extent)
            # @assert length(offset) == length(extent) == ndims(comp)
            @assert all(extent .>= 0)
            @assert length(data) == prod(extent)
            # TODO: check type of comp
            mark_buffer!(comp.iteration, data)
            ptr = $(Symbol("create_aliasing_shared_ptr_", type_symbols[otype]))(pointer(data))
            $(Symbol("cxx_store_chunk_", type_symbols[otype]))(comp.cxx_object, ptr, wrap_offset(offset), wrap_extent(extent))
            return
        end
    end
end
