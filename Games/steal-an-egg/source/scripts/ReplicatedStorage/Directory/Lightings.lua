-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local LightingsCore = require(ReplicatedStorage.Library.Client.LightingsCore)

require(ReplicatedStorage.Library.Functions.DeepCopyUnsafe)

local Interface = require(script.Types.Interface)
local t = {}
local tbl = {}

t.Directory = tbl
t.Types = Interface
tbl.Default = LightingsCore.Serialize(Lighting)
tbl.Default.Clouds = LightingsCore.SerializeClouds(Workspace.Terrain.Clouds)

if Constants.IS_STUDIO then
	for k, v in pairs(tbl) do
		local v1, v2 = Interface.LightingConfig(v)

		assert(v1, (("Invalid lighting config \"%*\": %*"):format(k, v2)))
	end
end

MakeTableStrict(tbl, "Lightings.Directory")

return t