# Datatype

@doc """
    @enum Datatype begin
        CHAR => CxxChar
        UCHAR => CxxUChar
        SHORT => CxxShort
        INT => CxxInt
        LONG => CxxLong,
        LONGLONG => CxxLongLong
        USHORT => CxxUShort
        UINT => CxxUInt
        ULONG => CxxULong,
        ULONGLONG => CxxULongLong
        FLOAT => CxxFloat
        DOUBLE => CxxDouble,
        CFLOAT => Complex{CxxFloat}
        CDOUBLE => Complex{CxxDouble}
        STRING => String,
        VEC_CHAR => Vector{CxxChar}
        VEC_UCHAR => Vector{CxxUChar}
        VEC_SHORT => Vector{CxxShort},
        VEC_INT => Vector{CxxInt}
        VEC_LONG => Vector{CxxLong}
        VEC_LONGLONG => Vector{CxxLongLong},
        VEC_USHORT => Vector{CxxUShort}
        VEC_UINT => Vector{CxxUInt}
        VEC_ULONG => Vector{CxxULong},
        VEC_ULONGLONG => Vector{CxxULongLong}
        VEC_FLOAT => Vector{CxxFloat},
        VEC_DOUBLE => Vector{CxxDouble}
        VEC_CFLOAT => Vector{Complex{CxxFloat}},
        VEC_CDOUBLE => Vector{Complex{CxxDouble}}
        VEC_STRING => Vector{String}
        BOOL => CxxBool,
        ARR_DBL_7 => SVector{7,CxxDouble})
    end
""" Datatype
export Datatype, CHAR, UCHAR, SHORT, INT, LONG, LONGLONG, USHORT, UINT, ULONG, ULONGLONG, FLOAT, DOUBLE, CFLOAT, CDOUBLE, STRING,
       VEC_CHAR, VEC_UCHAR, VEC_SHORT, VEC_INT, VEC_LONG, VEC_LONGLONG, VEC_USHORT, VEC_UINT, VEC_ULONG, VEC_ULONGLONG, VEC_FLOAT,
       VEC_DOUBLE, VEC_CFLOAT, VEC_CDOUBLE, VEC_STRING, ARR_DBL_7, BOOL

# CxxWrap promises these types, but doesn't define them
const CxxDouble = Cdouble
const CxxFloat = Cfloat
const CxxInt = Cint
const CxxShort = Cshort
const CxxUInt = Cuint
const CxxUShort = Cushort
export CxxDouble, CxxFloat, CxxInt, CxxShort, CxxUInt, CxxUShort

# Missing conversions
# Base.convert(::Type{Datatype}, d::CxxWrap.CxxWrapCore.ConstCxxRef{Datatype}) = d[]::Datatype

# Missing `setindex!` signatures
Base.setindex!(h::Dict{Datatype, Type}, v0::Type, key0::CxxWrap.CxxWrapCore.ConstCxxRef{openPMD.Datatype}) =
    setindex!(h, v0, key0[])
Base.setindex!(h::Dict{Datatype, Symbol}, v0::Symbol, key0::CxxWrap.CxxWrapCore.ConstCxxRef{openPMD.Datatype}) =
 setindex!(h, v0, key0[])

Base.hash(b::CxxBool, u::UInt) = hash(hash(Bool(b), u), UInt(0x4c87662d))

# We cannot use this definition for equality. It leads to `LONG` ==
# `LONGLONG` on some systems.

# Base.:(==)(d::Datatype, e::Datatype) = cxx_is_same(d, e)
# function Base.hash(d::Datatype, h::UInt)
#     isvec = cxx_is_vector(d)
#     isint, issig = cxx_is_integer(d)
#     isfp = cxx_is_floating_point(d)
#     iscfp = cxx_is_complex_floating_point(d)
#     bits = cxx_to_bits(d)
#     return hash(0x6b224312, hash(isvec, hash(isint, hash(issig, hash(isfp, hash(iscfp, hash(bits, h)))))))
# end

Base.hash(d::Datatype, u::UInt) = hash(hash(convert(UInt, d), u), UInt(0x6b224312))

# Convert between Julia types and OpenPMD type ids

@memoize function type_symbols()
    return Dict{Datatype,Symbol}(CHAR => :CHAR, UCHAR => :UCHAR, SHORT => :SHORT, INT => :INT, LONG => :LONG,
                                 LONGLONG => :LONGLONG, USHORT => :USHORT, UINT => :UINT, ULONG => :ULONG,
                                 ULONGLONG => :ULONGLONG, FLOAT => :FLOAT, DOUBLE => :DOUBLE, CFLOAT => :CFLOAT,
                                 CDOUBLE => :CDOUBLE, STRING => :STRING, VEC_CHAR => :VEC_CHAR, VEC_UCHAR => :VEC_UCHAR,
                                 VEC_SHORT => :VEC_SHORT, VEC_INT => :VEC_INT, VEC_LONG => :VEC_LONG,
                                 VEC_LONGLONG => :VEC_LONGLONG, VEC_USHORT => :VEC_USHORT, VEC_UINT => :VEC_UINT,
                                 VEC_ULONG => :VEC_ULONG, VEC_ULONGLONG => :VEC_ULONGLONG, VEC_FLOAT => :VEC_FLOAT,
                                 VEC_DOUBLE => :VEC_DOUBLE, VEC_CFLOAT => :VEC_CFLOAT, VEC_CDOUBLE => :VEC_CDOUBLE,
                                 VEC_STRING => :VEC_STRING, ARR_DBL_7 => :ARR_DBL_7, BOOL => :BOOL)
end

@memoize function julia_types()
    return Dict{Datatype,Type}(CHAR => CxxChar, UCHAR => CxxUChar, SHORT => CxxShort, INT => CxxInt, LONG => CxxLong,
                               LONGLONG => CxxLongLong, USHORT => CxxUShort, UINT => CxxUInt, ULONG => CxxULong,
                               ULONGLONG => CxxULongLong, FLOAT => CxxFloat, DOUBLE => CxxDouble,
                               CFLOAT => Complex{CxxFloat}, CDOUBLE => Complex{CxxDouble}, STRING => String,
                               VEC_CHAR => Vector{CxxChar}, VEC_UCHAR => Vector{CxxUChar}, VEC_SHORT => Vector{CxxShort},
                               VEC_INT => Vector{CxxInt}, VEC_LONG => Vector{CxxLong}, VEC_LONGLONG => Vector{CxxLongLong},
                               VEC_USHORT => Vector{CxxUShort}, VEC_UINT => Vector{CxxUInt}, VEC_ULONG => Vector{CxxULong},
                               VEC_ULONGLONG => Vector{CxxULongLong}, VEC_FLOAT => Vector{CxxFloat},
                               VEC_DOUBLE => Vector{CxxDouble}, VEC_CFLOAT => Vector{Complex{CxxFloat}},
                               VEC_CDOUBLE => Vector{Complex{CxxDouble}}, VEC_STRING => Vector{String},
                               ARR_DBL_7 => SVector{7,CxxDouble}, BOOL => CxxBool)
end
function julia_type(d::Datatype)
    T = get(julia_types(), d, nothing)
    T ≡ nothing && error("unknown Datatype $d")
    return T
end

@memoize function abstract_julia_types()
    return Dict{Datatype,Type}(CHAR => CxxChar, UCHAR => CxxUChar, SHORT => CxxShort, INT => CxxInt,
                               LONG => CxxLong, LONGLONG => CxxLongLong, USHORT => CxxUShort, UINT => CxxUInt,
                               ULONG => CxxULong, ULONGLONG => CxxULongLong, FLOAT => CxxFloat,
                               DOUBLE => CxxDouble, CFLOAT => Complex{CxxFloat}, CDOUBLE => Complex{CxxDouble},
                               STRING => AbstractString, VEC_CHAR => AbstractVector{CxxChar},
                               VEC_UCHAR => AbstractVector{CxxUChar}, VEC_SHORT => AbstractVector{CxxShort},
                               VEC_INT => AbstractVector{CxxInt}, VEC_LONG => AbstractVector{CxxLong},
                               VEC_LONGLONG => AbstractVector{CxxLongLong},
                               VEC_USHORT => AbstractVector{CxxUShort}, VEC_UINT => AbstractVector{CxxUInt},
                               VEC_ULONG => AbstractVector{CxxULong},
                               VEC_ULONGLONG => AbstractVector{CxxULongLong},
                               VEC_FLOAT => AbstractVector{CxxFloat}, VEC_DOUBLE => AbstractVector{CxxDouble},
                               VEC_CFLOAT => AbstractVector{Complex{CxxFloat}},
                               VEC_CDOUBLE => AbstractVector{Complex{CxxDouble}},
                               VEC_STRING => AbstractVector{<:AbstractString},
                               ARR_DBL_7 => Union{NTuple{7,CxxDouble},SVector{7,CxxDouble}}, BOOL => CxxBool)
end
function abstract_julia_type(d::Datatype)
    T = get(abstract_julia_types(), d, nothing)
    T ≡ nothing && error("unknown Datatype $d")
    return T
end

openpmd_type(::Type{CxxChar}) = CHAR
openpmd_type(::Type{CxxUChar}) = UCHAR
openpmd_type(::Type{CxxShort}) = SHORT
openpmd_type(::Type{CxxInt}) = INT
openpmd_type(::Type{CxxLong}) = LONG
openpmd_type(::Type{CxxLongLong}) = LONGLONG
openpmd_type(::Type{CxxUShort}) = USHORT
openpmd_type(::Type{CxxUInt}) = UINT
openpmd_type(::Type{CxxULong}) = ULONG
openpmd_type(::Type{CxxULongLong}) = ULONGLONG
openpmd_type(::Type{CxxFloat}) = FLOAT
openpmd_type(::Type{CxxDouble}) = DOUBLE
openpmd_type(::Type{Complex{CxxFloat}}) = CFLOAT
openpmd_type(::Type{Complex{CxxDouble}}) = CDOUBLE
openpmd_type(::Type{<:AbstractString}) = STRING
openpmd_type(::Type{<:AbstractVector{CxxChar}}) = VEC_CHAR
openpmd_type(::Type{<:AbstractVector{CxxUChar}}) = VEC_UCHAR
openpmd_type(::Type{<:AbstractVector{CxxShort}}) = VEC_SHORT
openpmd_type(::Type{<:AbstractVector{CxxInt}}) = VEC_INT
openpmd_type(::Type{<:AbstractVector{CxxLong}}) = VEC_LONG
openpmd_type(::Type{<:AbstractVector{CxxLongLong}}) = VEC_LONGLONG
openpmd_type(::Type{<:AbstractVector{CxxUShort}}) = VEC_USHORT
openpmd_type(::Type{<:AbstractVector{CxxUInt}}) = VEC_UINT
openpmd_type(::Type{<:AbstractVector{CxxULong}}) = VEC_ULONG
openpmd_type(::Type{<:AbstractVector{CxxULongLong}}) = VEC_ULONGLONG
openpmd_type(::Type{<:AbstractVector{CxxFloat}}) = VEC_FLOAT
openpmd_type(::Type{<:AbstractVector{CxxDouble}}) = VEC_DOUBLE
openpmd_type(::Type{<:AbstractVector{Complex{CxxFloat}}}) = VEC_CFLOAT
openpmd_type(::Type{<:AbstractVector{Complex{CxxDouble}}}) = VEC_CDOUBLE
openpmd_type(::Type{<:AbstractVector{<:AbstractString}}) = VEC_STRING
openpmd_type(::Type{<:Union{NTuple{7,CxxDouble},SVector{7,CxxDouble}}}) = ARR_DBL_7
openpmd_type(::Type{CxxBool}) = BOOL

"""
    openPMD_datatypes()::AbstractVector{Datatype}
"""
function openpmd_datatypes()
    return [CHAR, UCHAR, SHORT, INT, LONG, LONGLONG, USHORT, UINT, ULONG, ULONGLONG, FLOAT, DOUBLE, CFLOAT, CDOUBLE, STRING,
            VEC_CHAR, VEC_UCHAR, VEC_SHORT, VEC_INT, VEC_LONG, VEC_LONGLONG, VEC_USHORT, VEC_UINT, VEC_ULONG, VEC_ULONGLONG,
            VEC_FLOAT, VEC_DOUBLE, VEC_CFLOAT, VEC_CDOUBLE, VEC_STRING, ARR_DBL_7, BOOL]
end
export openpmd_datatypes

"""
    OpenPMDType = Union{...}
"""
const OpenPMDType = Union{CxxChar,CxxUChar,CxxShort,CxxInt,CxxLong,CxxLongLong,CxxUShort,CxxUInt,CxxULong,CxxULongLong,CxxFloat,
                          CxxDouble,Complex{CxxFloat},Complex{CxxDouble},String,Vector{CxxChar},Vector{CxxUChar},Vector{CxxShort},
                          Vector{CxxInt},Vector{CxxLong},Vector{CxxLongLong},Vector{CxxUShort},Vector{CxxUInt},Vector{CxxULong},
                          Vector{CxxULongLong},Vector{CxxFloat},Vector{CxxDouble},Vector{Complex{CxxFloat}},
                          Vector{Complex{CxxDouble}},Vector{String},SVector{7,CxxDouble},CxxBool}
export OpenPMDType

"""
    AbstractOpenPMDType = Union{...}
"""
const AbstractOpenPMDType = Union{CxxChar,CxxUChar,CxxShort,CxxInt,CxxLong,CxxLongLong,CxxUShort,CxxUInt,CxxULong,CxxULongLong,
                                  CxxFloat,CxxDouble,Complex{CxxFloat},Complex{CxxDouble},AbstractString,AbstractVector{CxxChar},
                                  AbstractVector{CxxUChar},AbstractVector{CxxShort},AbstractVector{CxxInt},AbstractVector{CxxLong},
                                  AbstractVector{CxxLongLong},AbstractVector{CxxUShort},AbstractVector{CxxUInt},
                                  AbstractVector{CxxULong},AbstractVector{CxxULongLong},AbstractVector{CxxFloat},
                                  AbstractVector{CxxDouble},AbstractVector{Complex{CxxFloat}},AbstractVector{Complex{CxxDouble}},
                                  AbstractVector{<:AbstractString},Union{NTuple{7,CxxDouble},SVector{7,CxxDouble}},CxxBool}
export AbstractOpenPMDType

"""
    determine_datatype(::Type)::Datatype
"""
determine_datatype(T::Type) = openpmd_type(T)::Datatype
export determine_datatype

"""
    to_bytes(::Type)::Int
"""
to_bytes(T::Type) = Int(cxx_to_bytes(openpmd_type(T)))
export to_bytes

"""
    to_bits(::Type)::Int
"""
to_bits(T::Type) = Int(cxx_to_bits(openpmd_type(T)))
export to_bits

"""
    is_vector(::Type)::Bool
"""
is_vector(T::Type) = cxx_is_vector(openpmd_type(T))::Bool
export is_vector

"""
    is_floating_point(::Type)::Bool
"""
is_floating_point(T::Type) = cxx_is_floating_point(openpmd_type(T))::Bool
export is_floating_point

"""
    is_complex_floating_point(::Type)::Bool
"""
is_complex_floating_point(T::Type) = cxx_is_complex_floating_point(openpmd_type(T))::Bool
export is_complex_floating_point

"""
    is_integer(::Type)::Tuple{Bool,Bool}

Whether the type is an integer (first tuple element), and if so,
whether it is signed (second tuple element).
"""
is_integer(T::Type) = Tuple{Bool,Bool}(cxx_is_integer(openpmd_type(T)))
export is_integer

"""
    is_same(::Type, ::Type)::Bool
"""
is_same(T1::Type, T2::Type) = cxx_is_same(openpmd_type(T1), openpmd_type(T2))::Bool
export is_same

# """
#     is_same_floating_point(::Type, ::Type)::Bool
# """
# is_same_floating_point(T1::Type, T2::Type) = is_same_floating_point(openpmd_type(T1), openpmd_type(T2))
# export is_same_floating_point
# 
# """
#     is_same_complex_floating_point(::Type, ::Type)::Bool
# """
# is_same_complex_floating_point(T!::Type, T2::Type) = is_same_complex_floating_point(openpmd_type(T1), openpmd_type(T2))
# export is_same_complex_floating_point
# 
# """
#     is_same_integer(::Type, ::Type)::Bool
# """
# is_same_integer(T1::Type, T2::Type) = is_same_integer(openpmd_type(T1), openpmd_type(T2))
# export is_same_integer

"""
    basic_datatype(::Type)::Type
"""
basic_datatype(T::Type) = julia_type(cxx_basic_datatype(openpmd_type(T)))::Type
export basic_datatype

"""
    to_vector_type(::Type)::Type
"""
to_vector_type(T::Type) = julia_type(cxx_to_vector_type(openpmd_type(T)))::Type
export to_vector_type

"""
    datatype_to_string(::Type)::AbstractString
"""
datatype_to_string(T::Type) = cxx_datatype_to_string(openpmd_type(T))::AbstractString
export datatype_to_string

"""
    string_to_datatype(str::AbstractString)::OpenPMDType
"""
string_to_datatype(str::AbstractString) = julia_type(cxx_string_to_datatype(str))::Type
export string_to_datatype

"""
    warn_wrong_dtype(key::AbstractString, ::Type{Store}, ::Type{Request}) where {Store,Request}
"""
function warn_wrong_dtype(key::AbstractString, ::Type{Store}, ::Type{Request}) where {Store,Request}
    return cxx_warn_wrong_dtype(key, openpmd_type(Store), openpmd_type(Request))
end
export warn_wrong_dtype
