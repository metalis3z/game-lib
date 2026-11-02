-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local format = string.format
local abs = math.abs

local function StringifyColor3(v1) -- line 4
    return string.format("Color3<%.3g, %.3g, %.3g> \"#%s\"", v1.R * 255, v1.G * 255, v1.B * 255, v1:ToHex())
end

return function(v2, v3, v4) -- line 8 | captures: format, abs
    local function v5(v6, ...)
        table.insert(v6, ...)
    end

    local function v7(v8, ...)
        table.insert(v8, ...)
    end

    local function v9(v10, ...)
        table.insert(v10, ...)
    end

    local v11 = if type(v4) == "number" then v4 else 0.005
    local v12 = typeof(v2) == "Color3"
    assert(v12, "\"Base\" is not a Color3")
    local v13 = typeof(v3) == "Color3"
    assert(v13, "\"Compare\" is not a Color3")
    local v14 = v2.R - v3.R
    local v15 = abs(v14)
    local v16 = v2.G - v3.G
    local v17 = abs(v16)
    local v18 = v2.B - v3.B
    local v19 = abs(v18)
    local v20 = if v15 <= v11 and v17 <= v11 then v19 <= v11 else false
    if not v20 then
        local v21 = {}
        if v11 < v15 then
            local v22 = v11 - v15
            local v23 = abs(v22)
            v5(v21, format("R was out by %.3g", (tostring(v23))))
        end
        if v11 < v17 then
            local v24 = v11 - v17
            local v25 = abs(v24)
            v7(v21, format("G was out by %.3g", (tostring(v25))))
        end
        if v11 < v19 then
            local v26 = v11 - v19
            local v27 = abs(v26)
            v9(v21, format("B was out by %.3g", (tostring(v27))))
        end
        error(format("Expected %s (%s) to be within %s, got %s (%s) instead; %s", string.format("Color3<%.3g, %.3g, %.3g> \"#%s\"", v2.R * 255, v2.G * 255, v2.B * 255, v2:ToHex()), typeof(v2), tostring(v11), string.format("Color3<%.3g, %.3g, %.3g> \"#%s\"", v3.R * 255, v3.G * 255, v3.B * 255, v3:ToHex()), typeof(v3), table.concat(v21, ", ")), 2)
    end
    return v20
end
