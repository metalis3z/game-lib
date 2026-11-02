-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexServiceClient, time of decompilation: Sun May  3 10:12:32 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local t1 = {}
local t2 = {
	["Invalid index category"] = true,
	["No reward available"] = true,
	["Reward not unlocked"] = true,
	["Already claiming reward"] = true
}

function t1.init(p1) -- line: 31
	-- upvalues: Networker (copy)
	p1.networker = Networker.client.new("IndexService", p1)
end
function t1.requestClaimReward(p2, s1: string) -- line: 35
	-- upvalues: ErrorMessages (copy), t2 (copy), SoundController (copy), Sounds (copy)
	local v12, v13 = p2.networker:fetch("requestClaimReward", s1)

	if not v12 then
		if v13 == "Reward not unlocked" then
			ErrorMessages.add("You haven't unlocked that reward yet.")
		elseif v13 == "No reward available" then
			ErrorMessages.add("There isn't an index reward ready to claim.")
		else
			ErrorMessages.add(v13 or "That reward couldn't be claimed.")
		end

		if not t2[v13] then
			warn("Failed to claim index reward:", v13)

			return v12, v13
		end
	else
		SoundController:Play(Sounds.misc.indexReward)
	end

	return v12, v13
end

return t1
