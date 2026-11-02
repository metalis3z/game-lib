-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Types)
local Configs = script.Configs
local v1 = {
    ["Abyss Ocean"] = require(Configs["Abyss Ocean"]),
    ["Cherry Blossom"] = require(Configs["Cherry Blossom"]),
    Cosmic = require(Configs.Cosmic),
    Desert = require(Configs.Desert),
    Forest = require(Configs.Forest),
    Jungle = require(Configs.Jungle),
    ["Titan Temple"] = require(Configs["Titan Temple"]),
    Lake = require(Configs.Lake)
}

v1.Prehistoric = require(Configs.Prehistoric)
v1.Snow = require(Configs.Snow)
v1.Volcano = require(Configs.Volcano)

local v2 = table.freeze(v1)
local freeze = table.freeze
local v3 = { Directory = v2 }

function v3.AreaNameExists(v4) -- line 20 | captures: v2
    if rawget(v2, v4) == nil then
        return false, (("Area name \"%*\" does not exist in the Areas directory."):format(v4))
    end
    return true
end

return freeze(v3)
