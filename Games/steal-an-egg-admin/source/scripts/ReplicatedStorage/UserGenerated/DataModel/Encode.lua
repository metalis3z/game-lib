-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2, v3 = xpcall(function() -- line 8
    return workspace[nil]
end, function() -- line 10
    return debug.info(2, "f")
end)

if v2 then
    if type(v3) ~= "function" then
        function v3(v4, v5) -- line 18
            return v4[v5]
        end
    end
else
    function v3(v6, v7) -- line 14
        return v6[v7]
    end
end
v1.fastIndex = v3

local v8 = {}

v8.__index = v8

function v1.newWriter(v9) -- line 25 | captures: v8
    local v10 = v9 or 65536
    local v11 = {
        len = 0,
        buf = buffer.create(v10),
        cap = v10
    }
    return (setmetatable(v11, v8))
end

local function _ensure(v12, v13) -- line 30
    local v14 = v12.len + v13
    if not (v12.cap < v14) then
        return
    end
    local v15 = v12.cap * 2
    while v15 < v14 do
        v15 *= 2
    end
    local v16 = buffer.create(v15)
    buffer.copy(v16, 0, v12.buf, 0, v12.len)
    v12.buf = v16
    v12.cap = v15
end

v8._ensure = _ensure

local function u8(v17, v18) -- line 43
    v17:_ensure(1)
    local buf = v17.buf
    local len = v17.len
    buffer.writeu8(buf, len, v18)
    v17.len += 1
end

v8.u8 = u8

local function u16(v19, v20) -- line 48
    v19:_ensure(2)
    local buf = v19.buf
    local len = v19.len
    buffer.writeu16(buf, len, v20)
    v19.len += 2
end

v8.u16 = u16

local function u32(v21, v22) -- line 53
    v21:_ensure(4)
    local buf = v21.buf
    local len = v21.len
    buffer.writeu32(buf, len, v22)
    v21.len += 4
end

v8.u32 = u32

local function f32(v23, v24) -- line 58
    v23:_ensure(4)
    local buf = v23.buf
    local len = v23.len
    buffer.writef32(buf, len, v24)
    v23.len += 4
end

v8.f32 = f32

local function f64(v25, v26) -- line 63
    v25:_ensure(8)
    local buf = v25.buf
    local len = v25.len
    buffer.writef64(buf, len, v26)
    v25.len += 8
end

v8.f64 = f64

local function strU8(v27, v28) -- line 68
    local v29 = #v28
    v27:_ensure(v29 + 1)
    local buf = v27.buf
    local len = v27.len
    buffer.writeu8(buf, len, v29)
    v27.len += 1
    if v29 > 0 then
        buffer.writestring(v27.buf, v27.len, v28)
        v27.len += v29
    end
end

v8.strU8 = strU8

local function strU16(v30, v31) -- line 78
    local v32 = #v31
    local v33
    if v32 <= 65535 then
        v33 = v31
    else
        v33 = string.sub(v31, 1, 65535)
        v32 = 65535
    end
    v30:_ensure(v32 + 2)
    local buf = v30.buf
    local len = v30.len
    buffer.writeu16(buf, len, v32)
    v30.len += 2
    if v32 > 0 then
        buffer.writestring(v30.buf, v30.len, v33)
        v30.len += v32
    end
end

v8.strU16 = strU16

local function str32(v34, v35) -- line 95
    local v36 = #v35
    v34:_ensure(v36 + 4)
    local buf = v34.buf
    local len = v34.len
    buffer.writeu32(buf, len, v36)
    v34.len += 4
    if v36 > 0 then
        buffer.writestring(v34.buf, v34.len, v35)
        v34.len += v36
    end
end

v8.str32 = str32

local function patchU16(v37, v38, v39) -- line 105
    local buf = v37.buf
    buffer.writeu16(buf, v38, v39)
end

v8.patchU16 = patchU16

local function finish(v40) -- line 108
    local v41 = buffer.create(v40.len)
    buffer.copy(v41, 0, v40.buf, 0, v40.len)
    return v41
end

v8.finish = finish

function v1.writeValue(v42, v43) -- line 113
    if v43 == nil then
        v42:u8(0)
    else
        local v44 = typeof(v43)
        if v44 == "boolean" then
            local v45 = if v43 then 2 else 1
            v42:u8(v45)
        elseif v44 == "number" then
            v42:u8(3)
            v42:f64(v43)
        elseif v44 == "string" then
            v42:u8(4)
            v42:str32(v43)
        elseif v44 == "EnumItem" then
            v42:u8(5)
            v42:str32((tostring(v43)))
        elseif v44 == "Vector2" then
            v42:u8(6)
            v42:f32(v43.X)
            v42:f32(v43.Y)
        elseif v44 == "Vector3" then
            v42:u8(7)
            v42:f32(v43.X)
            v42:f32(v43.Y)
            v42:f32(v43.Z)
        elseif v44 == "Color3" then
            v42:u8(8)
            local v46 = v43.R * 255 + 0.5
            local v47 = math.floor(v46)
            v42:u8((math.clamp(v47, 0, 255)))
            local v48 = v43.G * 255 + 0.5
            local v49 = math.floor(v48)
            v42:u8((math.clamp(v49, 0, 255)))
            local v50 = v43.B * 255 + 0.5
            local v51 = math.floor(v50)
            v42:u8((math.clamp(v51, 0, 255)))
        elseif v44 == "CFrame" then
            v42:u8(9)
            local v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63 = v43:GetComponents()
            v42:f32(v52)
            v42:f32(v53)
            v42:f32(v54)
            v42:f32(v55)
            v42:f32(v56)
            v42:f32(v57)
            v42:f32(v58)
            v42:f32(v59)
            v42:f32(v60)
            v42:f32(v61)
            v42:f32(v62)
            v42:f32(v63)
        else
            v42:u8(10)
            v42:str32((tostring(v43)))
        end
    end
end

return v1
