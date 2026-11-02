-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(v2, ...)
    table.insert(v2, ...)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v3 = {}
local v4 = table.freeze({ "Tung Tung Sahur", 39 })
local v5 = table.freeze({ "Bananita Dolphinita", 25 })
local v6 = table.freeze({ "Belula Beluga", 20 })
local v7 = table.freeze({ "Mangolini Parrochini", 10 })
local v8 = { "Bomboclat Crocolat", 5 }
local v9 = table.freeze(v8)
local v10 = { "Strawberry Elephant", 1 }

v3[1] = v4
v3[2] = v5
v3[3] = v6
v3[4] = v7
v3[5] = v9
v3[6] = table.freeze(v10)

local v11 = table.freeze(v3)
local v12 = #v11 == 6
assert(v12, "Brainrot egg presentation requires exactly six drop entries")
local v13 = {}
for v14, v15 in ipairs(v11) do
    local v16 = v15[1]
    local v17 = v15[2]
    t.strict(t.string)(v16)
    t.strict(t.number)(v17)
    local v18 = v17 > 0
    local v19 = ("Brainrot egg drop entry %* requires positive weight"):format(v14)
    assert(v18, v19)
    v1(v13, table.freeze({
        AssetId = v16,
        Weight = v17
    }))
end
local v20 = {
    DisplayName = "Brainrot Egg",
    BackgroundImage = "rbxassetid://70476079280223",
    DropTable = v11,
    Entries = table.freeze(v13)
}
return (table.freeze(v20))
