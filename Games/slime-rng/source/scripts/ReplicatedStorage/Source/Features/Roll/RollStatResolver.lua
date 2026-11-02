-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollStatResolver, time of decompilation: Sun May  3 10:11:45 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

local function getUpgradeModifiers(t1: {[any]: any}?) -- line: 59
	-- upvalues: UpgradeServiceUtils (copy)
	local t2 = {}
	local v11 = t1 or {}
	local v12 = UpgradeServiceUtils.getUpgradeLevel("luck", v11)
	local v13 = UpgradeServiceUtils.getUpgradeLevel("rollSpeed", v11)
	local v14 = UpgradeServiceUtils.getUpgradeLevel("cloverRolls", v11)
	local v15 = UpgradeServiceUtils.getUpgradeLevel("bonusRolls", v11)
	local t3 = {
		id = "upgrades.luck",
		stat = "luck",
		mode = "multiply",
		value = UpgradeServiceUtils.getUpgradeValue("luck", v12)
	}

	if t3 and (t3.mode ~= "multiply" or t3.value ~= 1) and (t3.mode ~= "add" or t3.value ~= 0) then
		table.insert(t2, t3)
	end

	local t4 = {
		id = "upgrades.rollSpeed",
		stat = "rollSpeed",
		mode = "multiply",
		value = UpgradeServiceUtils.getUpgradeValue("rollSpeed", v13)
	}

	if t4 and (t4.mode ~= "multiply" or t4.value ~= 1) and (t4.mode ~= "add" or t4.value ~= 0) then
		table.insert(t2, t4)
	end

	local t5 = {
		id = "upgrades.cloverRolls",
		stat = "luckRollChance",
		mode = "multiply",
		value = UpgradeServiceUtils.getUpgradeValue("cloverRolls", v14)
	}

	if t5 and (t5.mode ~= "multiply" or t5.value ~= 1) and (t5.mode ~= "add" or t5.value ~= 0) then
		table.insert(t2, t5)
	end

	local t6 = {
		id = "upgrades.bonusRolls",
		stat = "bonusRollChance",
		mode = "multiply",
		value = UpgradeServiceUtils.getUpgradeValue("bonusRolls", v15)
	}

	if not t6 then
		return t2
	end

	if t6.mode == "multiply" and t6.value == 1 then
		return t2
	end

	if t6.mode == "add" and t6.value == 0 then
		return t2
	end

	table.insert(t2, t6)

	return t2
end
local function getSpecialRollModifiers(n1: number?) -- line: 98
	local t7 = {}
	local v22 = n1 or 0

	if v22 > 0 then
		local t8 = {
			id = "specialRolls.luck",
			stat = "luck",
			mode = "multiply",
			value = 1 + v22
		}

		if not t8 then
			return t7
		end

		if t8.mode == "multiply" and t8.value == 1 then
			return t7
		end

		if t8.mode == "add" and t8.value == 0 then
			return t7
		end

		table.insert(t7, t8)
	end

	return t7
end
local function getZoneLuckModifiers(n2: number?) -- line: 112
	local t9 = {}
	local v26 = n2 or 0

	if v26 > 0 then
		local t10 = {
			id = "zones.luck",
			stat = "luck",
			mode = "add",
			value = v26
		}

		if not t10 then
			return t9
		end

		if t10.mode == "multiply" and t10.value == 1 then
			return t9
		end

		if t10.mode == "add" and t10.value == 0 then
			return t9
		end

		table.insert(t9, t10)
	end

	return t9
end

return {
	resolve = function(t11: {[any]: any}?) --[[ resolve ]] -- line: 136
		-- upvalues: getUpgradeModifiers (copy), getSpecialRollModifiers (copy), MonetizationServiceUtils (copy), getZoneLuckModifiers (copy)
		local t12 = {}

		for _, v33 in getUpgradeModifiers(if not t11 then nil else t11.upgradesOwned) do
			table.insert(t12, v33)
		end

		for _, v35 in getSpecialRollModifiers(if not t11 then nil else t11.specialLuckBonus) do
			table.insert(t12, v35)
		end

		for _, v37 in MonetizationServiceUtils.getRollStatModifiers(if not t11 then nil else t11.ownsProductKey) do
			if v37 and (v37.mode ~= "multiply" or v37.value ~= 1) and (v37.mode ~= "add" or v37.value ~= 0) then
				table.insert(t12, v37)
			end
		end

		if t11 and t11.modifiers then
			for _, v39 in t11.modifiers do
				if v39 and (v39.mode ~= "multiply" or v39.value ~= 1) and (v39.mode ~= "add" or v39.value ~= 0) then
					table.insert(t12, v39)
				end
			end
		end

		for _, v41 in getZoneLuckModifiers(if not t11 then nil else t11.zoneLuckBonus) do
			table.insert(t12, v41)
		end

		local n3 = 1
		local n4 = 1
		local n5 = 1
		local n6 = 0.18
		local n7 = 0.001

		for _, v48 in t12 do
			if v48.stat == "luck" then
				if v48.mode == "multiply" and (v48.applyToFinalLuck or v48.id == "rebirths.luck") then
					n4 *= v48.value
				else
					n3 = if v48.mode ~= "add" then n3 + (v48.value - 1) else n3 + v48.value
				end
			elseif v48.stat == "rollSpeed" then
				n5 = if v48.mode ~= "add" then n5 * v48.value else n5 + v48.value
			elseif v48.stat == "luckRollChance" then
				n6 = if v48.mode ~= "add" then n6 * v48.value else n6 + v48.value
			elseif v48.stat == "bonusRollChance" then
				n7 = if v48.mode ~= "add" then n7 * v48.value else n7 + v48.value
			end
		end

		local v49 = n3 * n4
		local v50 = v49
		local v51 = false

		if t11 and t11.luckOverrideEnabled == true and type(t11.luckOverrideValue) == "number" and t11.luckOverrideValue == t11.luckOverrideValue then
			local v52 = math.max(math.floor(v50), 1)

			v49 = math.clamp(math.floor(t11.luckOverrideValue), 1, v52)
			v51 = true
		end

		local v53 = math.max(n5, 0.05)
		local v54 = math.clamp(n6, 0, 1)
		local v55 = math.clamp(n7, 0, 1)

		return {
			luck = v49,
			maxLuck = v50,
			luckOverridden = v51,
			rollTime = math.max(3 / v53, 0.15),
			rollSpeedMultiplier = v53,
			luckRollChance = v54,
			jackpotChance = v55,
			modifiers = t12
		}
	end
}
