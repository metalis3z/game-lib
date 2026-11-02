-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
-- [[ Script name: TutorialServiceUtils ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local TutorialSteps = require(script.Parent.TutorialSteps)
local t1 = {}

local function normalizeEquipped(t_equipped: {[any]: any})
	local result = {}
	for k, v in pairs(t_equipped) do
		local uid = nil
		if type(k) == "number" and type(v) == "string" then
			uid = v -- array style: {[1]="uid"} from RollService
		elseif type(k) == "string" and v == true then
			uid = k -- dict style: {"uid"=true}
		end
		if uid then
			result[uid] = (result[uid] or 0) + 1
		end
	end
	return result
end

local function getSlotsOwned(t2: {[any]: any}, n1: number?)
	return InventoryServiceUtils.getOwnedSlotCount(t2, n1)
end

function t1.isTutorialComplete(t3: {[any]: any}?)
	return t3 ~= nil and t3.completed == true
end

function t1.isInTutorial(t4: {[any]: any}?)
	return not t1.isTutorialComplete(t4)
end

function t1.getCurrentStep(t5: {[any]: any}?)
	if t1.isTutorialComplete(t5) then
		return "complete"
	end
	if t5 == nil then
		return "init"
	end
	local step = t5.step
	if type(step) ~= "string" or TutorialSteps[step] == nil then
		return "init"
	end
	return step
end

function t1.getStepNumFromStep(s1: string?)
	local v23 = TutorialSteps[if type(s1) == "string" and TutorialSteps[s1] ~= nil then s1 else "init"]
	if v23 == nil then
		return nil
	end
	return v23.num
end

function t1.isValidStep(s2: string?)
	return type(s2) == "string" and TutorialSteps[s2] ~= nil
end

function t1.getNextStep(s3: string?)
	if not t1.isValidStep(s3) or not s3 then
		return nil
	end
	return TutorialSteps[s3].nextStep
end

function t1.canAdvanceStep(t6: {[any]: any}?, s4: string)
	if t1.isTutorialComplete(t6) then
		return false, nil
	end
	if s4 ~= t1.getCurrentStep(t6) then
		return false, nil
	end
	local v28 = t1.getNextStep(s4)
	if v28 == nil then
		return false, nil
	end
	return true, v28
end

function t1.shouldShowUpgradeButton(t7: {[any]: any}?, _: {[any]: any}?)
	if t1.isTutorialComplete(t7) then
		return true
	end
	return TutorialSteps[t1.getCurrentStep(t7)].num >= TutorialSteps.openUpgrades.num
end

function t1.shouldShowBackpackButton(t9: {[any]: any}?, t10: {[any]: any}?)
	if t1.isTutorialComplete(t9) then
		return true
	end
	if t10 ~= nil and t10.backpack == true then
		return true
	end
	local v33 = t1.getCurrentStep(t9)
	local num = TutorialSteps[(if type(v33) == "string" and TutorialSteps[v33] ~= nil then v33 else "init")].num
	return num >= TutorialSteps.openBackpack.num and num <= TutorialSteps.closeBackpack.num
end

function t1.canOpenMenu(t11: {[any]: any}?, s5: string?)
	if s5 == nil then
		return true
	end
	if t1.isTutorialComplete(t11) then
		return true
	end
	if s5 == "offlineEarningsMenu" or s5 == "Settings" or s5 == "Admin" then
		return true
	end
	local v37 = t1.getCurrentStep(t11)
	if TutorialSteps[(if type(v37) == "string" and TutorialSteps[v37] ~= nil then v37 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	if s5 == "Inventory" then
		return TutorialSteps[v37].num >= TutorialSteps.openBackpack.num
	end
	return false
end

function t1.canOpenUpgradeScreen(t12: {[any]: any}?)
	if t1.isTutorialComplete(t12) then
		return true
	end
	local v39 = t1.getCurrentStep(t12)
	if TutorialSteps[(if type(v39) == "string" and TutorialSteps[v39] ~= nil then v39 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	return TutorialSteps[v39].num >= TutorialSteps.openUpgrades.num
end

function t1.canOpenUpgradeTree(t13: {[any]: any}?)
	if t1.isTutorialComplete(t13) then
		return true
	end
	local v41 = t1.getCurrentStep(t13)
	return TutorialSteps[(if type(v41) == "string" and TutorialSteps[v41] ~= nil then v41 else "init")].num > TutorialSteps.equipBetterSlime.num
end

function t1.canRoll(t14: {[any]: any}?)
	if t1.isTutorialComplete(t14) then
		return true
	end
	local v43 = t1.getCurrentStep(t14)
	if TutorialSteps[(if type(v43) == "string" and TutorialSteps[v43] ~= nil then v43 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	return v43 == "init" or (v43 == "firstRoll" or (v43 == "secondRoll" or v43 == "thirdRoll"))
end

function t1.shouldSpawnEnemies(t15: {[any]: any}?)
	if t1.isTutorialComplete(t15) then
		return true
	end
	return TutorialSteps[t1.getCurrentStep(t15)].num >= TutorialSteps.rollCompleted.num
end

function t1.canUnlockUpgrade(t16: {[any]: any}?, s6: string)
	if t1.isTutorialComplete(t16) then
		return true
	end
	local v47 = t1.getCurrentStep(t16)
	if TutorialSteps[(if type(v47) == "string" and TutorialSteps[v47] ~= nil then v47 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	if v47 == "buyBackpackUpgrade" then
		return s6 == "backpack"
	end
	if v47 == "buyAutoUpgrade" then
		return s6 == "autoRoll"
	end
	return false
end

function t1.canPurchaseZone(t17: {[any]: any}?, n2: number)
	if t1.isTutorialComplete(t17) then
		return true
	end
	local v50 = t1.getCurrentStep(t17)
	if TutorialSteps[(if type(v50) == "string" and TutorialSteps[v50] ~= nil then v50 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	return t1.getCurrentStep(t17) == "unlockZone2" and n2 == 2
end

function t1.canUseInventoryItems(t18: {[any]: any}?)
	if t1.isTutorialComplete(t18) then
		return true
	end
	local v52 = t1.getCurrentStep(t18)
	return TutorialSteps[(if type(v52) == "string" and TutorialSteps[v52] ~= nil then v52 else "init")].num > TutorialSteps.equipBetterSlime.num
end

function t1.canEquipBest(t19: {[any]: any}?)
	if t1.isTutorialComplete(t19) then
		return true
	end
	local v54 = t1.getCurrentStep(t19)
	return TutorialSteps[(if type(v54) == "string" and TutorialSteps[v54] ~= nil then v54 else "init")].num > TutorialSteps.equipBetterSlime.num
end

function t1.canUnequipSlime(t20: {[any]: any}?)
	if t1.isTutorialComplete(t20) then
		return true
	end
	local v56 = t1.getCurrentStep(t20)
	return TutorialSteps[(if type(v56) == "string" and TutorialSteps[v56] ~= nil then v56 else "init")].num > TutorialSteps.equipBetterSlime.num
end

-- FIXED: normalizes both array-style {[1]="uid"} and dict-style {"uid"=true}
function t1.getRecommendedEquipUniqueId(t21: {[any]: any}, t22: {[any]: any}, t23: {[any]: any}, n3: number?)
	local v61 = InventoryServiceUtils.getBestEquippedUniqueIds(t21, getSlotsOwned(t23, n3))

	-- Normalize equipped table to a count map regardless of storage format
	local equippedCounts = normalizeEquipped(t22)

	for _, v66 in v61 do
		local v67 = equippedCounts[v66] or 0
		if v67 <= 0 then
			return v66
		end
		equippedCounts[v66] = v67 - 1
	end
	return nil
end

-- FIXED: isBestEquipSatisfied uses the fixed getRecommendedEquipUniqueId above
function t1.isBestEquipSatisfied(t25: {[any]: any}, t26: {[any]: any}, t27: {[any]: any}, n4: number?)
	return t1.getRecommendedEquipUniqueId(t25, t26, t27, n4) == nil
end

function t1.canEquipSlime(t28: {[any]: any}?, s7: string, t29: {[any]: any}, t30: {[any]: any}, t31: {[any]: any}, n5: number?)
	if t1.isTutorialComplete(t28) then
		return true
	end
	local v78 = t1.getCurrentStep(t28)
	if TutorialSteps[(if type(v78) == "string" and TutorialSteps[v78] ~= nil then v78 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	if v78 ~= "equipBetterSlime" then
		return false
	end
	return s7 == t1.getRecommendedEquipUniqueId(t29, t30, t31, n5)
end

function t1.canEquipSlimeIfSpace(t32: {[any]: any}?, s8: string, t33: {[any]: any}, t34: {[any]: any}, t35: {[any]: any}, n6: number?)
	if t1.isTutorialComplete(t32) then
		return true
	end
	local v85 = t1.getCurrentStep(t32)
	if TutorialSteps[(if type(v85) == "string" and TutorialSteps[v85] ~= nil then v85 else "init")].num > TutorialSteps.equipBetterSlime.num then
		return true
	end
	if TutorialSteps[v85].num <= TutorialSteps.thirdRollCompleted.num then
		return true
	end
	return t1.canEquipSlime(t32, s8, t33, t34, t35, n6)
end

function t1.completeTutorialInfo(_: {[any]: any}?)
	return {
		step = "complete",
		completed = true
	}
end

return t1