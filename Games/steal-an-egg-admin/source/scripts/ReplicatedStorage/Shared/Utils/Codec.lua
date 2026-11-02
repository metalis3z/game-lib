-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local v1 = {}
for v2 = 0, 255 do
    local v3 = v2
    for v4 = 1, 8 do
        local v5 = bit32.band(v3, 1) == 1
        v3 = bit32.rshift(v3, 1)
        if v5 then
            v3 = bit32.bxor(v3, 3988292384)
        end
    end
    v1[v2] = v3
end
local v6 = {}

function v6.Crc32(v7) -- line 25 | captures: v1
    local function v8(v9, ...)
        return (bit32.bxor(v9, ...))
    end

    local v10 = #v7
    local v11 = 4294967295
    for v12 = 1, v10 do
        local v13 = v8(v11, string.byte(v7, v12))
        local v14 = bit32.band(v13, 255)
        local v15 = bit32.rshift(v11, 8)
        local v16 = v1[v14]
        v11 = bit32.bxor(v15, v16)
    end
    return (bit32.bnot(v11))
end

function v6.NewUid() -- line 38 | captures: HttpService
    local v17 = HttpService:GenerateGUID(false)
    return string.lower(string.gsub(v17, "-", ""))
end

function v6.CFrameFromComponents(v18) -- line 42
    return CFrame.new(table.unpack(v18, 1, 12))
end

function v6.ComponentsFromCFrame(v19) -- line 45
    return { v19:GetComponents() }
end

return table.freeze(v6)
