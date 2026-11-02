-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(...)
    assert(...)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Defaults = require(script.Defaults)
local Schema = require(script.Types.Schema)

if require(ReplicatedStorage.Shared.Globals.Constants).IS_STUDIO then
    v1(Schema(Defaults))
end
return Defaults
