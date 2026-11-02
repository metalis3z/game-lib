-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Directory = require(ReplicatedStorage.Data.Currency).Directory
local Directory_2 = require(ReplicatedStorage.Data.Gears).Directory
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.string, function(v2) -- line 13
    return #v2 > 0
end)
local v3 = t.intersection(t.integer, t.numberPositive)
local v4 = {}
local v5 = t.strictInterface({
    Kind = t.literal("Currency"),
    Id = v1,
    Amount = v3
})
local v6 = t.strictInterface({
    Kind = t.literal("Gear"),
    Id = v1,
    Amount = v3
})
local v7 = t.strictInterface({
    Kind = t.literal("SpeedPower"),
    Amount = v3
})

v4.Schema = t.union(v5, v6, v7, t.strictInterface({
    Kind = t.literal("MonsterChestReward"),
    Id = v1,
    Amount = v3
}))

local v8 = {}

v8[MonsterParasite_2.RewardIds.MonsterEgg] = "Prismatic"

local v9 = {}

v9[250000] = "rbxassetid://75372541151576"
v9[1000000] = "rbxassetid://139742352093157"
v9[5000000] = "rbxassetid://112271178072366"

local function currencyIcon(v10, v11) -- line 29 | captures: v9
    local v12 = v10.Icon or ""
    local v13 = 0
    for v14, v15 in pairs(v9) do
        if v14 <= v11 and v13 < v14 then
            v12 = v15
            v13 = v14
        end
    end
    return v12
end

function v4.Describe(v16) -- line 40 | captures: Directory, Directory_2, MonsterParasite, Rarity, v4, v8, currencyIcon
    local v17 = v4.Schema(v16)
    assert(v17, "invalid notification item")
    if v16.Kind == "Currency" then
        local v18 = Directory[v16.Id]
        local v19 = ("unknown currency notification id: %*"):format(v16.Id)
        local v20 = assert(v18, v19)
        local v21 = {
            Name = v20.DisplayName or "",
            Description = v20.Desc or "",
            Icon = currencyIcon(v20, v16.Amount)
        }
        v21.Rarity = v20.Rarity or Rarity.Rarities.Rare
        return v21
    end
    if v16.Kind == "Gear" then
        local v22 = Directory_2[v16.Id]
        local v23 = ("unknown gear notification id: %*"):format(v16.Id)
        local v24 = assert(v22, v23)
        local v25 = {
            Name = v24.DisplayName or "",
            Description = v24.Description or "",
            Icon = v24.Icon or ""
        }
        v25.Rarity = Rarity.Rarities[v24.Rarity] or Rarity.Rarities.Basic
        return v25
    end
    if v16.Kind == "MonsterChestReward" then
        local v26 = MonsterParasite.GetReward(v16.Id)
        local v27 = v8[v16.Id] or v26.Rarity
        local v28 = {
            Name = v26.DisplayName,
            Description = v26.DisplayNote or "",
            Icon = v26.Icon or "rbxassetid://99458650446228"
        }
        v28.Rarity = Rarity.Rarities[v27] or Rarity.Rarities.Basic
        return v28
    end
    return {
        Name = "Speed Power",
        Description = "SPEED",
        Icon = "rbxassetid://99458650446228",
        Rarity = Rarity.Rarities.Rare
    }
end

return v4
