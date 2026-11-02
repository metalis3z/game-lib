-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
-- [[ Script name: UpgradeServiceClient ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

local t1 = {}
local t2 = {
	["Not enough currency"] = true,
	["Upgrade cannot be purchased"] = true,
	["Upgrade not found"] = true,
	["owned"] = true,      -- FIXED: treat "owned" as a known/silent case
	["maxlevel"] = true,   -- also silent
	["broke"] = true,      -- also silent
	["tutorial"] = true,   -- also silent
	["invalid"] = true,    -- also silent
	["nodata"] = true,     -- also silent
	["nocost"] = true,     -- also silent
	["unknown"] = true,    -- also silent
}

function t1.init(p1)
	p1.networker = Networker.client.new("UpgradeService", p1)
end

function t1.unlockUpgrade(p2, s1: string)
	if not TutorialServiceClient:canUnlockUpgrade(s1) then
		ErrorMessages.add("That upgrade is locked during the tutorial.")
		return false
	end

	local v15, v16 = p2.networker:fetch("requestUnlock", s1)

	if not v15 then
		-- FIXED: handle all known server response codes
		if v16 == "owned" then
			-- Server already owns it, client cache was stale — silent, no error
			print("[UpgradeServiceClient] Already owns:", s1, "- client resynced")
			return false
		elseif v16 == "broke" then
			ErrorMessages.add("You can't afford this upgrade yet.")
		elseif v16 == "maxlevel" then
			ErrorMessages.add("That upgrade is already at max level.")
		elseif v16 == "tutorial" then
			ErrorMessages.add("That upgrade is locked during the tutorial.")
		elseif v16 == "Not enough currency" then
			ErrorMessages.add("You can't afford this upgrade yet.")
		elseif v16 == "Upgrade cannot be purchased" then
			ErrorMessages.add("That upgrade can't be purchased.")
		elseif v16 == "Upgrade not found" then
			ErrorMessages.add("That upgrade is unavailable right now.")
		elseif v16 == "unknown" or v16 == "invalid" or v16 == "nodata" or v16 == "nocost" then
			-- Silent — server-side issue, nothing to show user
		else
			ErrorMessages.add(v16 or "Failed to unlock upgrade.")
		end

		if not t2[v16] then
			warn("Failed to unlock upgrade:", v16)
		end

		return false
	end

	SoundController:Play(Sounds.misc.upgradeUnlock)
	return true
end

function t1.ownsUpgrade(_, s2: string)
	local v19 = client:get("upgrades")
	return UpgradeServiceUtils.ownsUpgrade(s2, v19)
end

function t1.getUpgradeLevel(_, s3: string)
	local v22 = client:get("upgrades")
	return UpgradeServiceUtils.getUpgradeLevel(s3, v22)
end

return t1