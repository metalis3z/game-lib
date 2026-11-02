-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: useSetting, time of decompilation: Sun May  3 10:11:57 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local SettingsServiceClient = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceClient)
local SettingsServiceUtils = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceUtils)

return function(p1) -- line: 8
	-- upvalues: SettingsServiceUtils (copy), getDataSource (copy), Vide (copy), SettingsServiceClient (copy)
	local v7 = SettingsServiceUtils.convertPathToSettingPath(p1)
	local v8 = getDataSource(v7)

	return Vide.derive(function() -- line: 12
		-- upvalues: SettingsServiceUtils (copy), v7 (copy), v8 (copy)
		return SettingsServiceUtils.resolveValue(v7, v8())
	end), function(p2) -- line: 16
		-- upvalues: SettingsServiceClient (copy), p1 (copy)
		SettingsServiceClient:set(p1, p2)
	end
end
