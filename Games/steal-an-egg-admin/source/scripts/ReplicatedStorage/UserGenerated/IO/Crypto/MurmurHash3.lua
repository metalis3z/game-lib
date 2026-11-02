-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local bxor = bit32.bxor
local bor = bit32.bor
local len = buffer.len
local readu32 = buffer.readu32
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local fromstring = buffer.fromstring

function mul32(v1, v2) -- line 18 | captures: band, lshift, rshift
    local v3 = band(v1, 65535) * v2
    local v4 = rshift(v1, 16) * v2
    local v5 = band(v4, 65535)
    return v3 + lshift(v5, 16)
end

function DigestBufferUnsafe(v6, v7, v8, v9) -- line 24 | captures: band, lshift, rshift, lrotate, bxor, bor, readu32, readu8, readu16
    local v10
    if v9 == nil then
        v10 = 0
    else
        local v11 = bor(v9, 0) == v9
        assert(v11)
        v10 = v9
    end
    local v12 = v7
    while v12 < v7 + v8 - 3 do
        local v13 = readu32(v6, v12)
        local v14 = mul32(v13, 3432918353)
        local v15 = lrotate(v14, 15)
        local v16 = mul32(v15, 461845907)
        local v17 = bxor(v10, v16)
        local v18 = lrotate(v17, 13) * 5
        v10, v12 = lshift(v18, 0) + 3864292196, v12 + 4
    end
    local v19 = band(v8, 3)
    local v20
    if v19 > 0 then
        local v21
        if v19 == 3 then
            local v22 = readu8(v6, v12)
            local v23 = v12 + 1
            local v24 = readu16(v6, v23)
            v21 = v22 + lshift(v24, 8)
        elseif v19 == 2 then
            v21 = readu16(v6, v12)
        else
            v21 = readu8(v6, v12)
        end
        local v25 = mul32(v21, 3432918353)
        local v26 = lrotate(v25, 15)
        local v27 = mul32(v26, 461845907)
        v20 = bxor(v10, v27)
    else
        v20 = v10
    end
    local v28 = bxor(v20, v8)
    local v29 = rshift(v28, 16)
    local v30 = bxor(v28, v29)
    local v31 = mul32(v30, 2246822507)
    local v32 = rshift(v31, 13)
    local v33 = bxor(v31, v32)
    local v34 = mul32(v33, 3266489909)
    local v35 = rshift(v34, 16)
    return (bxor(v34, v35))
end

function DigestBufferCustom(v36, v37, v38, v39) -- line 61 | captures: len
    local v40 = type(v36) == "buffer"
    assert(v40)
    local v41 = if type(v37) == "number" and v37 >= 0 then v37 <= len(v36) else false
    assert(v41)
    local v42 = if type(v38) == "number" and v38 >= 0 then v38 <= len(v36) - v37 else false
    assert(v42)
    return DigestBufferUnsafe(v36, v37, v38, v39)
end

function DigestBuffer(v43, v44) -- line 70 | captures: len
    local v45 = len(v43)
    return DigestBufferUnsafe(v43, 0, v45, v44)
end

function Digest(v46, v47) -- line 74 | captures: len, fromstring
    local v48 = fromstring(v46)
    local v49 = len(v48)
    return DigestBufferUnsafe(v48, 0, v49, v47)
end

local v50 = {
    DigestBufferCustom = DigestBufferCustom,
    DigestBuffer = DigestBuffer,
    Digest = Digest
}
table.freeze(v50)
return v50
