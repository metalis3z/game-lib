-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingServiceClient, time of decompilation: Sun May  3 10:12:23 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local Signal = require(ReplicatedStorage.Packages.Signal)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local TextNotifications = require(ReplicatedStorage.Source.Features.Notifications.UI.TextNotifications)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	crafted = Signal.new()
}

local function playRecipeUnlockedFeedback() -- line: 22
	-- upvalues: SoundController (copy), Sounds (copy), TextNotifications (copy)
	SoundController:Play(Sounds.misc.upgradeUnlock)
	TextNotifications.add("New recipe unlocked!", {
		Duration = 4,
		Confetti = true,
		Color = Color3.fromRGB(132, 255, 153),
		StrokeColor = Color3.fromRGB(18, 74, 24)
	})
end

local t2 = {
	["Profile unavailable"] = true,
	["Recipe not found"] = true,
	["Recipe already unlocked"] = true,
	["Recipe cannot be purchased"] = true,
	["Not enough coins"] = true,
	["Crafting machine already unlocked"] = true,
	["Crafting machine locked"] = true,
	["Crafting machine not found"] = true,
	["Crafting machine too far"] = true,
	["Crafting machine busy"] = true,
	["Recipe locked"] = true,
	["Missing ingredients"] = true,
	["Invalid auto craft amount"] = true,
	["Recipe instance not found"] = true,
	["Recipe instance key mismatch"] = true,
	["Recipe claim too far"] = true,
	["Recipe zone locked"] = true
}

local function showCraftingError(s1: string?) -- line: 52
	-- upvalues: ErrorMessages (copy)
	if s1 == "Profile unavailable" then
		ErrorMessages.add("Your data is still loading. Try crafting again in a moment.")

		return
	end

	if s1 == "Recipe already unlocked" then
		ErrorMessages.add("You already own that recipe.")

		return
	end

	if s1 == "Recipe cannot be purchased" then
		ErrorMessages.add("That recipe can't be purchased.")

		return
	end

	if s1 == "Not enough coins" then
		ErrorMessages.add("You need more coins for that recipe.")

		return
	end

	if s1 == "Crafting machine already unlocked" then
		ErrorMessages.add("You already unlocked the crafting machine.")

		return
	end

	if s1 == "Crafting machine locked" then
		ErrorMessages.add("Unlock the crafting machine before crafting.")

		return
	end

	if s1 == "Crafting machine not found" then
		ErrorMessages.add("Move closer to a crafting machine before autocrafting.")

		return
	end

	if s1 == "Crafting machine too far" then
		ErrorMessages.add("Move closer to that crafting machine before autocrafting.")

		return
	end

	if s1 == "Crafting machine busy" then
		ErrorMessages.add("That crafting machine is already autocrafting.")

		return
	end

	if s1 == "Recipe locked" then
		ErrorMessages.add("Unlock that recipe before crafting it.")

		return
	end

	if s1 == "Missing ingredients" then
		ErrorMessages.add("You don't have the slimes needed for that craft.")

		return
	end

	if s1 == "Invalid auto craft amount" then
		ErrorMessages.add("Choose a valid autocraft amount.")

		return
	end

	if s1 == "Recipe instance not found" then
		ErrorMessages.add("That recipe can't be claimed right now.")

		return
	end

	if s1 == "Recipe instance key mismatch" then
		ErrorMessages.add("That recipe can't be claimed right now.")

		return
	end

	if s1 == "Recipe claim too far" then
		ErrorMessages.add("Move closer to the recipe before claiming it.")

		return
	end

	if s1 == "Recipe zone locked" then
		ErrorMessages.add("Unlock this zone before claiming that recipe.")

		return
	end

	ErrorMessages.add(s1 or "That crafting action couldn't be completed.")
end

function t1.init(p1) -- line: 121
	-- upvalues: Networker (copy)
	p1.networker = Networker.client.new("CraftingService", p1)
end
function t1.unlockRecipe(p2, s2: string) -- line: 125
	-- upvalues: showCraftingError (copy), t2 (copy), playRecipeUnlockedFeedback (copy)
	local v20, v21 = p2.networker:fetch("requestUnlockRecipe", s2)

	if not v20 then
		showCraftingError(v21)

		if not t2[v21] then
			warn("Failed to unlock crafting recipe:", v21)
		end
	end

	if v20 then
		playRecipeUnlockedFeedback()
	end

	return v20
end
function t1.unlockMachine(p3) -- line: 141
	-- upvalues: showCraftingError (copy), t2 (copy)
	local v23, v24 = p3.networker:fetch("requestUnlockMachine")

	if not v23 then
		showCraftingError(v24)

		if not t2[v24] then
			warn("Failed to unlock crafting machine:", v24)
		end
	end

	return v23
end
function t1.claimRecipe(p4, s3: string, p5) -- line: 153
	-- upvalues: showCraftingError (copy), t2 (copy), playRecipeUnlockedFeedback (copy)
	local v28, v29 = p4.networker:fetch("requestClaimRecipe", s3, p5)

	if not v28 then
		showCraftingError(v29)

		if not t2[v29] then
			warn("Failed to claim crafting recipe:", v29)

			return v28
		end
	else
		playRecipeUnlockedFeedback()
	end

	return v28
end
function t1.craftRecipe(p6, s4: string, t3: {[any]: any}, s5: string?) -- line: 171
	-- upvalues: CraftingServiceUtils (copy), client (copy), IndexServiceUtils (copy), showCraftingError (copy), t2 (copy), RollSlice (copy)
	local v34 = CraftingServiceUtils.getSelectedSlimeDatas(client:get("inventory") or {}, t3)
	local v35 = CraftingServiceUtils.getRecipe(s4)
	local v36 = v35 == nil or IndexServiceUtils.isUnlocked(client:get("index"), "basic", v35.outputId)
	local v37, v38, v39 = p6.networker:fetch("requestCraftRecipe", s4, t3, s5)

	if not v37 then
		showCraftingError(v38)

		if not t2[v38] then
			warn("Failed to craft recipe:", v38)

			return v37
		end
	elseif v39 ~= nil then
		if not v36 then
			RollSlice.actions.setNewSlimeQueue({ v39 })
			RollSlice.actions.markNewSlimePopupReady()
		end

		p6.crafted:Fire(s4, v34, v39, s5, false)
	end

	return v37
end
function t1.startAutoCraft(p7, s6: string, t4: {[any]: any}, n1: number, s7: string?) -- line: 200
	-- upvalues: showCraftingError (copy), t2 (copy)
	local v45, v46 = p7.networker:fetch("requestStartAutoCraft", s6, t4, n1, s7)

	if not v45 then
		showCraftingError(v46)

		if not t2[v46] then
			warn("Failed to start auto craft:", v46)
		end
	end

	return v45
end
function t1.stopAutoCraft(p8, s8: string) -- line: 219
	-- upvalues: showCraftingError (copy), t2 (copy)
	local v49, v50 = p8.networker:fetch("requestStopAutoCraft", s8)

	if not v49 then
		showCraftingError(v50)

		if not t2[v50] then
			warn("Failed to stop auto craft:", v50)
		end
	end

	return v49
end
function t1.autoCraftCompleted(p9, s9: string, s10: string, t5: {[any]: any}, p10) -- line: 231
	if type(s9) ~= "string" or type(s10) ~= "string" or type(p10) ~= "table" then
		return
	end

	p9.crafted:Fire(s9, t5 or {}, p10, s10, true)
end

return t1
