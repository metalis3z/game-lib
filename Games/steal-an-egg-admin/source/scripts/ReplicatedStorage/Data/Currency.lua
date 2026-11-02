-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Data.Rarity)
local Configs = script.Configs
local v1 = {
    Money = require(Configs.Money),
    SakuraCrystals = require(Configs.SakuraCrystals),
    SpinnyWheelTickets = require(Configs.SpinnyWheelTickets)
}
table.freeze(v1)
local freeze = table.freeze
local v2 = { Directory = v1 }

function v2.CurrencyNameExists(v3) -- line 13 | captures: v1
    if v1[v3] == nil then
        return false, (("Currency name \"%*\" does not exist in the Currency directory."):format(v3))
    end
    return true
end

return freeze(v2)
