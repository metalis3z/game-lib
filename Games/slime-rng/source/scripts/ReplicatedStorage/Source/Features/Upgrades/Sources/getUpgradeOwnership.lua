-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: getUpgradeOwnership, time of decompilation: Sun May  3 10:11:36 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

return function(s1: string) -- line: 7
	-- upvalues: getDataSource (copy), Vide (copy), UpgradeServiceUtils (copy)
	local v6 = getDataSource("upgrades")

	return Vide.derive(function() -- line: 9
		-- upvalues: UpgradeServiceUtils (copy), s1 (copy), v6 (copy)
		return UpgradeServiceUtils.ownsUpgrade(s1, v6())
	end)
end
