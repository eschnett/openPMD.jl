# Access

@doc """
    @enum Access begin
        ACCESS_READ_ONLY
        ACCESS_READ_WRITE
        ACCESS_CREATE
    end
""" Access
export Access, ACCESS_READ_ONLY, ACCESS_READ_WRITE, ACCESS_CREATE

Base.hash(acc::Access, u::UInt) = hash(hash(convert(UInt, acc), u), UInt(0x0bec3b3e))::UInt
