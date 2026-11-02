-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

local function version_tostring(v2) -- line 7
    return string.format("%d.%d", v2.Major, v2.Minor)
end

local function version_lt(v3, v4) -- line 10
    if v3.Major == v4.Major then
        return v3.Minor < v4.Minor
    end
    return v3.Major < v4.Major
end

local function version_eq(v5, v6) -- line 19
    if v5.Major == v6.Major then
        return v5.Minor == v6.Minor
    end
    return false
end

local function double_to_int32(v7) -- line 23
    local v8 = tonumber(v7) or 0
    if math.clamp(v8, -2147483648, 2147483647) == v7 then
        if v7 <= -1 then
            return (math.ceil(v7))
        end
        if v7 >= 1 then
            return (math.floor(v7))
        end
        return 0
    end
    return UDim.new(nil, v7).Offset
end

function v1.new(v9, v10) -- line 36 | captures: version_tostring, version_lt, version_eq
    local v11 = newproxy(true)
    local v12 = getmetatable(v11)
    local v13 = {}
    local v14 = tonumber(v9) or 0
    if math.clamp(v14, -2147483648, 2147483647) == v9 then
        if v9 <= -1 then
            v13.Major = math.ceil(v9)
        elseif v9 < 1 then
            v13.Major = 0
        else
            v13.Major = math.floor(v9)
        end
    else
        v13.Major = UDim.new(nil, v9).Offset
    end
    local v15 = tonumber(v10) or 0
    if math.clamp(v15, -2147483648, 2147483647) == v10 then
        if v10 <= -1 then
            v13.Minor = math.ceil(v10)
        elseif v10 < 1 then
            v13.Minor = 0
        else
            v13.Minor = math.floor(v10)
        end
    else
        v13.Minor = UDim.new(nil, v10).Offset
    end
    v12.__index = v13
    v12.__metatable = "The metatable is locked"
    v12.__tostring = version_tostring
    v12.__lt = version_lt
    v12.__eq = version_eq
    table.freeze(v12)
    return v11
end

v1.current = v1.new(31, 1)
return table.freeze(v1)
