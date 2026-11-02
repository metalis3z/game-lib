-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Array = require(script.Parent.Parent.Util.Array)
local Assert = require(script.Parent.Parent.Util.Assert)
require(script.Parent.Parent.Util.Types)
local HSL = require(script.Parent.Parent.HSL)
local Saturate = require(script.Parent.Parent.Saturate)
local Tailwind = Assert.prepTypeOf("Tailwind")
local find = table.find
local abs = math.abs
local v1 = {
    0.32,
    0.16,
    0.08,
    0.04,
    0,
    0,
    0.04,
    0.08,
    0.16,
    0.32,
    0.84
}
local v2 = {
    0.95,
    0.85,
    0.75,
    0.65,
    0.55,
    0.45,
    0.35,
    0.25,
    0.15,
    0.1,
    0.05
}

local function GetBaseColorSaturationIndex(v3) -- line 33 | captures: Array, find, abs, v2
    local v4 = v3.L / 100
    local v5 = Array.reduce(v2, function(v6, v7) -- line 36 | captures: v4, abs
        local v8 = v7 - v4
        local v9 = abs(v8)
        local v10 = v6 - v4
        if v9 < abs(v10) then
            return v7
        end
        return v6
    end)
    return find(v2, v5)
end

local function Tailwind_2(v11) -- line 61 | captures: Array, HSL, Saturate, Tailwind, find, abs, v1, v2
    Tailwind("base", "Color3", v11)
    local v12 = HSL.toHSL(v11)
    local v13 = v12.L / 100
    local v14 = Array.reduce(v2, function(v15, v16) -- line 36 | captures: v13, abs
        local v17 = v16 - v13
        local v18 = abs(v17)
        local v19 = v15 - v13
        if v18 < abs(v19) then
            return v16
        end
        return v15
    end)
    local v20 = find(v2, v14)
    local v21 = Array.map(Array.map(v2, function(v22) -- line 68 | captures: v12, HSL
        return HSL.fromHSL({
            H = v12.H,
            S = v12.S,
            L = v22 * 100
        })
    end), function(v23, v24) -- line 71 | captures: v20, Saturate, v1
        local v25 = v1[v24] - v1[v20]
        return Saturate(v23, v25)
    end)
    return Array.reduce(v21, function(v26, v27, v28) -- line 77 | captures: v21
        local v29 = if v28 == 1 then 50 else (v28 - 1) * 100
        if v28 == #v21 then
            v29 -= 50
        end
        v26[v29] = v27
        return v26
    end, {})
end

return Tailwind_2
