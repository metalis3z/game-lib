-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
for v2 = 0, 255 do
    local v3 = v2
    for v4 = 1, 8 do
        if bit32.band(v3, 1) == 0 then
            v3 = bit32.rshift(v3, 1)
        else
            local v5 = bit32.rshift(v3, 1)
            v3 = bit32.bxor(v5, 3988292384)
        end
    end
    v1[v2 + 1] = v3
end
local v6 = {
    Init = function() -- Init | line 25
        return 4294967295
    end
}

function v6.Update(v7, v8, v9, v10) -- line 28 | captures: v1
    local v11 = v9 or 1
    local v12 = v11 + (v10 or string.len(v8)) - 1
    local v13 = v7
    for v14 = v11, v12 do
        local v15 = string.byte(v8, v14)
        local v16 = bit32.rshift(v13, 8)
        local v17 = bit32.bxor(v13, v15)
        local v18 = v1[bit32.band(v17, 255) + 1]
        v13 = bit32.bxor(v16, v18)
    end
    return v13
end

function v6.UpdateBuffer(v19, v20, v21, v22) -- line 46 | captures: v1
    local v23 = v21 or 0
    local v24 = v23 + (v22 or buffer.len(v20)) - 1
    local v25 = v19
    for v26 = v23, v24 do
        local v27 = buffer.readu8(v20, v26)
        local v28 = bit32.rshift(v25, 8)
        local v29 = bit32.bxor(v25, v27)
        local v30 = v1[bit32.band(v29, 255) + 1]
        v25 = bit32.bxor(v28, v30)
    end
    return v25
end

local function Finish(v31) -- line 64
    return (bit32.bnot(v31))
end

v6.Finish = Finish

function v6.Digest(v32, v33, v34) -- line 68 | captures: v6
    local v35 = v6.Update(v6.Init(), v32, v33, v34)
    return v6.Finish(v35)
end

function v6.DigestBuffer(v36, v37, v38) -- line 72 | captures: v6
    local v39 = v6.UpdateBuffer(v6.Init(), v36, v37, v38)
    return v6.Finish(v39)
end

return table.freeze(v6)
