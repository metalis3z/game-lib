-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Types)
local Configs = script.Configs
local v1 = {
    ["Abyss Ocean Bat"] = require(Configs["Abyss Ocean Bat"]),
    Bat = require(Configs.Bat),
    BeeLauncher = require(Configs.BeeLauncher),
    BodySwap = require(Configs.BodySwap),
    Boogie = require(Configs.Boogie),
    ["Cosmic Bat"] = require(Configs["Cosmic Bat"]),
    ["Demon Slap"] = require(Configs["Demon Slap"]),
    ["Desert Bat"] = require(Configs["Desert Bat"]),
    ["Diamond Slap"] = require(Configs["Diamond Slap"]),
    ["Dirt Slap"] = require(Configs["Dirt Slap"]),
    ["Emerald Slap"] = require(Configs["Emerald Slap"]),
    Flyswatter = require(Configs.Flyswatter),
    ["Forest Bat"] = require(Configs["Forest Bat"]),
    ["Golden Slap"] = require(Configs["Golden Slap"]),
    InvisibilityCap = require(Configs.InvisibilityCap),
    ["Jungle Bat"] = require(Configs["Jungle Bat"]),
    Katana = require(Configs.Katana),
    ["Lake Bat"] = require(Configs["Lake Bat"]),
    LaserCap = require(Configs.LaserCap),
    Magnet = require(Configs.Magnet),
    MedusaHead = require(Configs.MedusaHead),
    Megaphone = require(Configs.Megaphone),
    ["Prehistoric Bat"] = require(Configs["Prehistoric Bat"]),
    RageTable = require(Configs.RageTable),
    RainbowWrath = require(Configs.RainbowWrath),
    SentryTurret = require(Configs.SentryTurret),
    Slap = require(Configs.Slap),
    ["Snow Bat"] = require(Configs["Snow Bat"]),
    SubspaceMine = require(Configs.SubspaceMine),
    TaserGun = require(Configs.TaserGun),
    ["Titan Axe"] = require(Configs["Titan Axe"]),
    Trap = require(Configs.Trap)
}

v1["Volcano Bat"] = require(Configs["Volcano Bat"])
v1.WebSlinger = require(Configs.WebSlinger)

local v2 = table.freeze(v1)
local freeze = table.freeze
local v3 = { Directory = v2 }

function v3.GearNameExists(v4) -- line 46 | captures: v2
    if rawget(v2, v4) == nil then
        return false, (("Gears name \"%*\" does not exist in the Gears directory."):format(v4))
    end
    return true
end

return freeze(v3)
