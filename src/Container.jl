# Container

"""
    abstract type Container{T,K} <: Attributable end
"""
abstract type Container{T,K} <: Attributable end
export Container

Base.eltype(::Type{Container{T,K}}) where {T,K} = T
Base.keytype(::Type{Container{T,K}}) where {T,K} = K
Base.eltype(::Container{T,K}) where {T,K} = T
Base.keytype(::Container{T,K}) where {T,K} = K

"""
    isempty(cont::Container)
"""
Base.isempty(cont::Container) = isempty(cont.cxx_object)
@cxxdereference Base.isempty(cont::CXX_Container) = cxx_empty(cont)

"""
    length(cont::Container)
"""
Base.length(cont::Container) = length(cont.cxx_object)
@cxxdereference Base.length(cont::CXX_Container) = Int(cxx_length(cont))

"""
    empty!(cont::Container)
"""
Base.empty!(cont::Container) = (empty!(cont.cxx_object); cont)
@cxxdereference Base.empty!(cont::CXX_Container) = (cxx_empty!(cont); cont)

"""
    getindex(cont::Container, key)
    cont[key]
"""
Base.getindex(cont::Container, key) = cont.cxx_object[key]
@cxxdereference Base.getindex(cont::CXX_Container, key) = cxx_getindex(cont, key)

# """
#     get!(cont::Container, key)
# """
# Base.get!(cont::Container, key) = cxx_get!(cont.cxx_object, key)

"""
    setindex!(cont::Container, value, key)
    cont[key] = value
"""
Base.setindex!(cont::Container, value, key) = (cont.cxx_object[key] = value)
@cxxdereference Base.setindex!(cont::CXX_Container, value, key) = cxx_setindex!(cont, value, key)

"""
    count(cont::Container)
"""
Base.count(cont::Container, key) = count(cont.cxx_object, key)
@cxxdereference Base.count(cont::CXX_Container, key) = Int(cxx_count(cont, key))

"""
    in(key, cont::Container)
    key in cont
"""
Base.in(key, cont::Container) = key in cont.cxx_object
@cxxdereference Base.in(key, cont::CXX_Container) = cxx_contains(cont, key)

"""
    delete!(cont::Container, key)
"""
Base.delete!(cont::Container, key) = (delete!(cont.cxx_object, key); cont)
@cxxdereference Base.delete!(cont::CXX_Container, key) = (cxx_delete!(cont, key); cont)

"""
    keys(cont::Container)::AbstractVector
"""
Base.keys(cont::Container) = keys(cont.cxx_object)
@cxxdereference Base.keys(cont::CXX_Container) = cxx_keys(cont)

# Base.values(cont::Container) = cxx_values(cont.cxx_object)
# Base.collect(cont::Container) = cxx_collect(cont.cxx_object)
