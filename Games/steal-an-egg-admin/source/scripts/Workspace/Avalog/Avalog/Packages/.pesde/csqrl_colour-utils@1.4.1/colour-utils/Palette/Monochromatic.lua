-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local Monochromatic = Assert.prepTypeOf("Monochromatic")
local Monochromatic_2 = Assert.prepEvalArg("Monochromatic")
local insert = table.insert
local floor = math.floor
local sort = table.sort
return function(v1, v2) -- line 18 | captures: Monochromatic, Monochromatic_2, insert, floor, sort
    local v3 = v2 or 3
    Monochromatic("base", "Color3", v1)
    Monochromatic("swatches", "number", v3)
    local v4 = floor(v3)
    Monochromatic_2("swatches", "be greater than 0", v4 > 0, v4)
    local v5, v6, v7 = v1:ToHSV()
    local v8 = 1 / v4
    local v9 = {}
    for v10 = 1, v4 do
        local fromHSV = Color3.fromHSV
        insert(v9, fromHSV(v5, v6, v7))
        v7 = (v7 + v8) % 1
    end
    sort(v9, function(v11, v12) -- line 37
        return select(3, v11:ToHSV()) < select(3, v12:ToHSV())
    end)
    return v9
end
