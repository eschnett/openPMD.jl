# UnitDimension

@doc """
    @enum UnitDimension begin
        UNITDIMENSION_L    # length
        UNITDIMENSION_M    # mass
        UNITDIMENSION_T    # time
        UNITDIMENSION_I    # electric current
        UNITDIMENSION_θ    # thermodynamic temperature
        UNITDIMENSION_N    # amount of substance
        UNITDIMENSION_J    # luminous intensity
    end
""" UnitDimension
export UnitDimension, UNITDIMENSION_L, UNITDIMENSION_M, UNITDIMENSION_T, UNITDIMENSION_I, UNITDIMENSION_θ, UNITDIMENSION_N,
       UNITDIMENSION_J

Base.convert(::Type{I}, d::UnitDimension) where {I<:Integer} = convert(I, reinterpret(UInt8, d))

Base.hash(d::UnitDimension, u::UInt) = hash(hash(convert(UInt, d), u), UInt(0xe2ff8533))::UInt
