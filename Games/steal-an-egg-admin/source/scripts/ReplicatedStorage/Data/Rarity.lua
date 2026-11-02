-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Configs = script.Configs
local v1 = table.freeze({
    Basic = require(Configs.Basic),
    BrainrotGod = require(Configs.BrainrotGod),
    Celestial = require(Configs.Celestial),
    Common = require(Configs.Common),
    Cosmic = require(Configs.Cosmic),
    Divine = require(Configs.Divine),
    Epic = require(Configs.Epic),
    Eternal = require(Configs.Eternal),
    Exclusive = require(Configs.Exclusive),
    Exotic = require(Configs.Exotic),
    Legendary = require(Configs.Legendary),
    Limited = require(Configs.Limited),
    Mythic = require(Configs.Mythic),
    Mythical = require(Configs.Mythical),
    Rainbow = require(Configs.Rainbow),
    Rare = require(Configs.Rare),
    Secret = require(Configs.Secret),
    SuperRare = require(Configs.SuperRare),
    Superior = require(Configs.Superior),
    Titan = require(Configs.Titan),
    Uncommon = require(Configs.Uncommon),
    Prismatic = require(Configs.Rainbow),
    Transcendent = require(Configs.Superior),
    Admin = require(Configs.Exclusive)
})
local freeze = table.freeze
local v2 = { Rarities = v1 }

function v2.RarityNameExists(v3) -- line 35 | captures: v1
    if v1[v3] == nil then
        return false, (("Rarity name \"%*\" does not exist in the Rarities directory."):format(v3))
    end
    return true
end

return freeze(v2)
