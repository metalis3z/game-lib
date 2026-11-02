-- InventoryServiceClient (Client ModuleScript) - PATCHED
-- Place: ReplicatedStorage > Source > Features > Inventory > InventoryServiceClient
-- FIXES:
--   1. newSlimeAcquired: reads p3.id and p3.mutations (already at top level from fixed RollService)
--   2. equipSlimeIfSpace: passes uniqueId string correctly to server
--   3. unequipSlime: sends slot number (server handles both number and string)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoostServiceClient = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceClient)
local Networker = require(ReplicatedStorage.Packages.Networker)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local InventoryItemUtils = require(script.Parent.InventoryItemUtils)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {}
local t2 = {
	["Tutorial locked"] = true,
	["Slime not found in inventory"] = true,
	["No available slime copies to equip"] = true,
	["No slime equipped to replace"] = true,
	["Invalid slot"] = true,
	["No slime equipped in that slot"] = true,
	["Unknown item"] = true,
	["Item cannot be used"] = true,
	["No jackpot spins available"] = true,
	["No special dice available"] = true,
	["No armed special dice"] = true,
	["Request in progress"] = true,
	["Invalid food"] = true,
	["Invalid food amount"] = true,
	["Invalid slime"] = true,
	["No food available"] = true,
	["Not enough food available"] = true,
	["No empty slime slot available"] = true,
}

local function showInventoryError(s1: string?, s2: string?)
	if s1 == "Tutorial locked" then
		ErrorMessages.add(s2 or "That action is locked during the tutorial.")
		return
	end
	if s1 == "No available slime copies to equip" then
		ErrorMessages.add("That slime is already fully equipped.")
		return
	end
	if s1 == "No slime equipped to replace" then
		ErrorMessages.add("You need an open slot or a weaker slime to replace.")
		return
	end
	if s1 == "No slime equipped in that slot" then
		ErrorMessages.add("There's no slime equipped in that slot.")
		return
	end
	if s1 == "No food available" then
		ErrorMessages.add("You don't have any of that food left.")
		return
	end
	if s1 == "Invalid food amount" then
		ErrorMessages.add("That feed amount isn't valid.")
		return
	end
	if s1 == "Not enough food available" then
		ErrorMessages.add("You don't have enough food for that feed.")
		return
	end
	if s1 == "Item cannot be used" then
		ErrorMessages.add("That item can't be used right now.")
		return
	end
	if s1 == "No jackpot spins available" then
		ErrorMessages.add("You don't have any jackpot spins left.")
		return
	end
	if s1 == "No special dice available" then
		ErrorMessages.add("You don't have any of those dice left.")
		return
	end
	if s1 == "No armed special dice" then
		ErrorMessages.add("That dice is no longer armed.")
		return
	end
	if s1 == "Request in progress" then
		return
	end
	ErrorMessages.add(s1 or (s2 or "That action couldn't be completed."))
end

function t1.init(p1)
	p1.networker = Networker.client.new("InventoryService", p1)
end

-- FIXED: p3 now has id/mutations at top level (from fixed RollService)
function t1.newSlimeAcquired(_, p3)
	if type(p3) ~= "table" then
		warn("[InventoryServiceClient] newSlimeAcquired: invalid entry", p3)
		return
	end

	-- Support both top-level id and nested slimeData.id
	local slimeId = p3.id or (p3.slimeData and p3.slimeData.id)
	local mutations = p3.mutations or (p3.slimeData and p3.slimeData.mutations)

	if type(slimeId) ~= "string" then
		warn("[InventoryServiceClient] newSlimeAcquired: missing id in entry")
		return
	end

	RollSlice.actions.setNewSlimeQueue({{
		id        = slimeId,
		mutations = mutations,
		uniqueId  = p3.uniqueId,
	}})
	RollSlice.actions.markNewSlimePopupReady()
end

function t1.equipSlime(p4, s3: string)
	-- Only block during the specific equipBetterSlime window
	if not TutorialServiceClient:hasCompletedTutorial() then
		local currentStep = TutorialServiceClient:getStep()
		if currentStep == "equipBetterSlime" then
			if not TutorialServiceClient:canEquipSlime(s3) then
				ErrorMessages.add("Follow the tutorial prompt to equip that slime.")
				return
			end
		end
	end

	local v18, v19 = p4.networker:fetch("requestEquip", s3)
	if not v18 then
		showInventoryError(v19)
		if not t2[v19] then
			warn("Failed to equip slime:", v19)
		end
	end
end

function t1.equipSlimeIfSpace(p5, s4: string)
	-- FIXED: s4 must be a uniqueId string
	if type(s4) ~= "string" then
		warn("[InventoryServiceClient] equipSlimeIfSpace: invalid uniqueId", s4)
		return false, "Invalid slot"
	end

	-- Tutorial complete → always allow
	if TutorialServiceClient:hasCompletedTutorial() then
		local v22, v23 = p5.networker:fetch("requestEquipIfSpace", s4)
		if not v22 and v23 ~= "No empty slime slot available" and v23 ~= "No available slime copies to equip" then
			warn("Failed to auto-equip slime:", v23)
		end
		return v22, v23
	end

	-- If best equip already satisfied → allow freely
	if TutorialServiceClient:isBestEquipSatisfied() then
		local v22, v23 = p5.networker:fetch("requestEquipIfSpace", s4)
		if not v22 and v23 ~= "No empty slime slot available" and v23 ~= "No available slime copies to equip" then
			warn("Failed to auto-equip slime:", v23)
		end
		return v22, v23
	end

	-- Enforce tutorial lock only during the equip window
	if not TutorialServiceClient:canEquipSlimeIfSpace(s4) then
		return false, "Tutorial locked"
	end

	local v22, v23 = p5.networker:fetch("requestEquipIfSpace", s4)
	if not v22 and v23 ~= "No empty slime slot available" and v23 ~= "No available slime copies to equip" then
		warn("Failed to auto-equip slime:", v23)
	end
	return v22, v23
end

function t1.equipBest(p6)
	if not TutorialServiceClient:canEquipBest() then
		ErrorMessages.add("Equip best is locked during the tutorial.")
		return false, "Tutorial locked"
	end
	local v25, v26 = p6.networker:fetch("requestEquipBest")
	if not v25 then
		showInventoryError(v26)
		if not t2[v26] then
			warn("Failed to equip best slimes:", v26)
		end
	end
	return v25, v26
end

-- FIXED: unequipSlime sends slot number — server handles both slot number and uniqueId string
function t1.unequipSlime(p7, n1: number)
	-- Only block unequip if on openBackpack or equipBetterSlime step
	if not TutorialServiceClient:hasCompletedTutorial() then
		local currentStep = TutorialServiceClient:getStep()
		local blockedSteps = {
			openBackpack     = true,
			equipBetterSlime = true,
		}
		if blockedSteps[currentStep] then
			ErrorMessages.add("Unequipping is locked during the tutorial.")
			return
		end
	end

	local v29, v30 = p7.networker:fetch("requestUnequip", n1)
	if not v29 then
		showInventoryError(v30)
		if not t2[v30] then
			warn("Failed to unequip slime at slot:", n1, "-", v30)
		end
	end
end

function t1.useItem(p8, s5: string)
	if not TutorialServiceClient:canUseInventoryItems() then
		ErrorMessages.add("Items are locked during the tutorial.")
		return false, "Tutorial locked"
	end
	local v33 = InventoryItemUtils.getDefinition(s5)
	if not v33 then
		ErrorMessages.add("Unknown item")
		warn("Failed to use item: unknown item", s5)
		return false, "Unknown item"
	end
	if v33.kind == "boost" then
		return BoostServiceClient:requestUseBoost(v33.boostKind)
	end
	if v33.kind == "specialDice" then
		local v34, v35 = p8.networker:fetch("requestUseItem", s5)
		if not v34 then
			showInventoryError(v35)
			if not t2[v35] then
				warn("Failed to use item:", v35)
			end
		end
		return v34, v35
	end
	ErrorMessages.add("That item can't be used right now.")
	return false, "Item cannot be used"
end

function t1.unarmSpecialDice(p9, s6: string)
	local v38, v39 = p9.networker:fetch("requestUnarmSpecialDice", s6)
	if not v38 then
		showInventoryError(v39)
		if not t2[v39] then
			warn("Failed to unarm special dice:", v39)
		end
	end
	return v38, v39
end

function t1.useFood(p10, s7: string, s8: string, n2: number?)
	if not TutorialServiceClient:canUseInventoryItems() then
		ErrorMessages.add("Items are locked during the tutorial.")
		return false, "Tutorial locked", nil
	end
	local v44, v45, v46 = p10.networker:fetch("requestUseFood", s7, s8, n2)
	if not v44 then
		showInventoryError(v45)
		if not t2[v45] then
			warn("Failed to use food:", v45)
		end
	end
	return v44, v45, v46
end

return t1