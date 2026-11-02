-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferServiceClient, time of decompilation: Sun May  3 10:12:35 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)
local Signal = require(ReplicatedStorage.Packages.Signal)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local TextNotifications = require(ReplicatedStorage.Source.Features.Notifications.UI.TextNotifications)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	transferred = Signal.new()
}
local t2 = {
	["Profile unavailable"] = true,
	["Not enough coins"] = true,
	["XP transfer machine already unlocked"] = true,
	["XP transfer machine locked"] = true,
	["Invalid transfer"] = true,
	["Missing input slime"] = true,
	["Missing output slime"] = true,
	["Input slime has no XP"] = true,
	["Output cannot be an input"] = true
}

local function showXpTransferError(s1: string?) -- line: 29
	-- upvalues: ErrorMessages (copy)
	if s1 == "Profile unavailable" then
		ErrorMessages.add("Your data is still loading. Try again in a moment.")

		return
	end

	if s1 == "Not enough coins" then
		ErrorMessages.add("You need more coins for the XP transfer machine.")

		return
	end

	if s1 == "XP transfer machine already unlocked" then
		ErrorMessages.add("You already unlocked the XP transfer machine.")

		return
	end

	if s1 == "XP transfer machine locked" then
		ErrorMessages.add("Unlock the XP transfer machine first.")

		return
	end

	if s1 == "Invalid transfer" then
		ErrorMessages.add("Choose XP slimes and an output slime first.")

		return
	end

	if s1 == "Missing input slime" then
		ErrorMessages.add("One of those input slimes is no longer available.")

		return
	end

	if s1 == "Missing output slime" then
		ErrorMessages.add("That output slime is no longer available.")

		return
	end

	if s1 == "Input slime has no XP" then
		ErrorMessages.add("Only slimes with XP can be transferred.")

		return
	end

	if s1 == "Output cannot be an input" then
		ErrorMessages.add("The output slime can't also be an input.")

		return
	end

	ErrorMessages.add(s1 or "That XP transfer couldn't be completed.")
end

function t1.init(p1) -- line: 70
	-- upvalues: Networker (copy)
	p1.networker = Networker.client.new("XpTransferService", p1)
end
function t1.unlockMachine(p2) -- line: 74
	-- upvalues: showXpTransferError (copy), t2 (copy), SoundController (copy), Sounds (copy), TextNotifications (copy)
	local v14, v15 = p2.networker:fetch("requestUnlockMachine")

	if not v14 then
		showXpTransferError(v15)

		if not t2[v15] then
			warn("Failed to unlock XP transfer machine:", v15)

			return v14
		end
	else
		SoundController:Play(Sounds.misc.upgradeUnlock)
		TextNotifications.add("XP transfer machine unlocked!", {
			Duration = 4,
			Confetti = true,
			Color = Color3.fromRGB(132, 255, 153),
			StrokeColor = Color3.fromRGB(18, 74, 24)
		})
	end

	return v14
end
function t1.transferXp(p3, s2: string, s3: string) -- line: 94
	-- upvalues: showXpTransferError (copy), t2 (copy), SoundController (copy), Sounds (copy)
	local v19, v20, v21 = p3.networker:fetch("requestTransferXp", s2, s3)

	if not v19 then
		showXpTransferError(v20)

		if not t2[v20] then
			warn("Failed to transfer slime XP:", v20)

			return v19
		end
	elseif v21 ~= nil then
		SoundController:Play(Sounds.misc.upgradeUnlock)
		p3.transferred:Fire(s2, s3, v21)
	end

	return v19
end

return t1
