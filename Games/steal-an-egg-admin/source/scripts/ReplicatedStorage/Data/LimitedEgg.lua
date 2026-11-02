-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(script.Types.Interface)
local v1 = {}
local v2 = table.freeze({ "Scorpio", 39 })
local v3 = table.freeze({ "Froggo", 24 })
local v4 = table.freeze({ "Crawler", 18 })
local v5 = table.freeze({ "Crocodon", 11 })
local v6 = table.freeze({ "Krakenoid", 6.5 })

v1[1] = v2
v1[2] = v3
v1[3] = v4
v1[4] = v5
v1[5] = v6
v1[6] = table.freeze({ "Dreadscale", 0.5 })

local v7 = table.freeze(v1)
local v8 = {}
local v9 = table.freeze({ "Mecha Scorpio", 40 })
local v10 = table.freeze({ "Mecha Froggo", 24 })
local v11 = table.freeze({ "Mecha Crawler", 18 })
local v12 = table.freeze({ "Mecha Crocodon", 11 })
local v13 = table.freeze({ "Mecha Krakenoid", 6.5 })

v8[1] = v9
v8[2] = v10
v8[3] = v11
v8[4] = v12
v8[5] = v13
v8[6] = table.freeze({ "Mecha Dreadscale", 0.5 })

local v14 = table.freeze(v8)
local v15 = if game:GetService("RunService"):IsStudio() then 0.5 else 0.01

local function buildEntries(v16) -- line 40 | captures: t
    local function v17(v18, ...)
        table.insert(v18, ...)
    end

    local v19 = {}
    for v20, v21 in ipairs(v16) do
        local v22 = v21[1]
        local v23 = v21[2]
        t.strict(t.string)(v22)
        t.strict(t.number)(v23)
        local v24 = v23 > 0
        local v25 = ("Limited egg drop entry %* requires positive weight"):format(v20)
        assert(v24, v25)
        v17(v19, table.freeze({
            AssetId = v22,
            Weight = v23
        }))
    end
    return table.freeze(v19)
end

local v26 = #v7 == 6
assert(v26, "Limited egg presentation requires exactly six drop entries")
local v27 = #v14 == #v7
assert(v27, "Limited egg mecha re-roll requires one mecha variant per base drop entry")
local v28 = if v15 > 0 then v15 <= 1 else false
assert(v28, "Limited egg mecha re-roll chance must be within (0, 1]")
assert(true, "Limited egg mecha re-roll live chance must be within (0, 1]")
local v29 = {
    DisplayName = "Monster Egg",
    InfoText = "Pets can have different <font color=\"#55FF77\"><b>sizes</b></font>, <font color=\"#55FF77\"><b>colors</b></font> and <font color=\"#55FF77\"><b>mutations</b></font>. Huge pets and pets with rare mutations earn <font color=\"#1AFF00\"><b>way more money</b></font>!",
    EndsAt = 1789225200,
    DropTable = v7,
    Entries = buildEntries(v7)
}
local v30 = {}
local v31 = table.freeze({
    Amount = 1,
    ProductName = "Limited Egg"
})
local v32 = table.freeze({
    Amount = 3,
    ProductName = "Limited Egg x3"
})
local v33 = table.freeze({
    Amount = 10,
    ProductName = "Limited Egg x10"
})

v30[1] = v31
v30[2] = v32
v30[3] = v33
v30[4] = table.freeze({
    Amount = 50,
    ProductName = "Limited Egg x50"
})
v29.Offers = table.freeze(v30)
v29.MechaReroll = table.freeze({
    DisplayChance = 0.01,
    Chance = v15,
    DropTable = v14,
    Entries = buildEntries(v14)
})
return (table.freeze(v29))
