-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: InventoryServiceUtils, time of decompilation: Sun May  3 10:11:27 2026 ]]
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local t1 = {
	isFiniteNumber = function(p1) --[[ isFiniteNumber ]] -- line: 19
		return type(p1) == "number" and (p1 == p1 and (p1 > -1e999 and p1 < 1e999))
	end
}

function t1.toNonNegativeInteger(p2, n1: number?) -- line: 23
	-- upvalues: t1 (copy)
	if not t1.isFiniteNumber(p2) then
		return n1 or 0
	end

	return (math.max(math.floor(p2), 0))
end
function t1.toPositiveInteger(p3, n2: number?) -- line: 31
	-- upvalues: t1 (copy)
	if not t1.isFiniteNumber(p3) then
		return n2 or 1
	end

	return (math.max(math.floor(p3), 1))
end

local function getLevelProgressFromAccumulatedXp(p4) -- line: 55
	-- upvalues: t1 (copy)
	local v20 = t1.toNonNegativeInteger(p4, 0)

	if v20 <= 0 then
		return 1, 0
	end

	local v21 = 1 + 8 * v20 / 100

	if not t1.isFiniteNumber(v21) then
		return 1, 0
	end

	local v22 = math.max(math.floor((math.sqrt(v21) + 1) / 2), 1)
	local v23 = t1.toPositiveInteger(v22, 1)
	local v24 = v23 - 1
	local n3

	if v24 <= 0 then
		n3 = 0
	else
		local v26 = v23 - 1
		local v27 = 100 * v24 * (1 + v26) / 2

		n3 = if t1.isFiniteNumber(v27) then v27 else 0
	end

	if v22 > 1 and n3 <= 0 then
		return 1, 0
	end

	if v20 < n3 then
		v22 = 1
		n3 = 0
	end

	local v28 = v20 - n3
	local v29 = v22 * 100

	if v29 <= v28 then
		v22 += 1
		v28 -= v29
	end

	return v22, t1.toNonNegativeInteger(v28, 0)
end

function t1.getOwnedSlotCount(t2: {[any]: any}?, n4: number?) -- line: 86
	-- upvalues: UpgradeServiceUtils (copy), t1 (copy)
	local v32 = UpgradeServiceUtils.getUpgradeLevel("slots", t2 or {})

	return (math.max(UpgradeServiceUtils.getUpgradeValue("slots", v32) + t1.toNonNegativeInteger(n4, 0), 0))
end
function t1.getMutationKey(p5) -- line: 92
	-- upvalues: Mutations (copy)
	if not p5 then
		return ""
	end

	local s1 = ""

	for _, v36 in Mutations.sortedMutations do
		if p5[v36] then
			s1 ..= v36 .. "_"
		end
	end

	return s1
end
function t1.getMutationsFromKey(s2: string) -- line: 106
	if s2 == "" then
		return {}
	end

	local t3 = {}

	for _, v40 in (string.split(s2, "_")) do
		if v40 ~= "" then
			t3[v40] = true
		end
	end

	return t3
end
function t1.genKey(p6) -- line: 121
	-- upvalues: HttpService (copy), t1 (copy)
	if p6.level then
		return "." .. HttpService:GenerateGUID(false)
	end

	return t1.getMutationKey(p6.mutations) .. "-" .. p6.id
end
function t1.getXpRequiredForLevel(n5: number) -- line: 130
	-- upvalues: t1 (copy)
	return 100 * t1.toPositiveInteger(n5, 1)
end
function t1.getAccumulatedXp(p7) -- line: 134
	-- upvalues: t1 (copy)
	local v44 = t1.reconcileSlimeData(p7)
	local level = v44.level
	local v46 = t1.toPositiveInteger(level, 1)
	local v47 = v46 - 1
	local n6

	if v47 <= 0 then
		n6 = 0
	else
		local v49 = v46 - 1
		local v50 = 100 * v47 * (1 + v49) / 2

		n6 = if t1.isFiniteNumber(v50) then v50 else 0
	end

	local v51 = n6 + v44.xp

	if not t1.isFiniteNumber(v51) then
		return 0
	end

	return v51
end
function t1.getSlimeDataFromAccumulatedXp(s3: string, n7: number, p8) -- line: 144
	-- upvalues: getLevelProgressFromAccumulatedXp (copy), t1 (copy)
	local v55, v56 = getLevelProgressFromAccumulatedXp(n7)

	return t1.reconcileSlimeData({
		id = s3,
		level = v55,
		xp = v56,
		mutations = p8
	})
end
function t1.reconcileSlimeData(p9) -- line: 158
	-- upvalues: t1 (copy), getLevelProgressFromAccumulatedXp (copy)
	local v58 = t1.toPositiveInteger(p9.level, 1)
	local v59 = t1.toNonNegativeInteger(p9.xp, 0)
	local v60 = getLevelProgressFromAccumulatedXp
	local v61 = t1.toPositiveInteger(v58, 1)
	local v62 = v61 - 1
	local n8

	if v62 <= 0 then
		n8 = 0
	else
		local v64 = v61 - 1
		local v65 = 100 * v62 * (1 + v64) / 2

		n8 = if t1.isFiniteNumber(v65) then v65 else 0
	end

	local v66, v67 = v60(n8 + v59)

	return {
		id = p9.id,
		level = v66,
		xp = v67,
		mutations = p9.mutations
	}
end
function t1.getSlimeData(s4: string, p10) -- line: 171
	-- upvalues: t1 (copy)
	if type(p10) == "table" then
		return t1.reconcileSlimeData(p10)
	end

	local parts = string.split(s4, "-")
	local v71 = parts[1] or ""
	local v72 = parts[2] or s4

	return t1.reconcileSlimeData({
		level = 1,
		xp = 0,
		id = v72,
		mutations = t1.getMutationsFromKey(v71)
	})
end
function t1.getLayoutOrder(p11) -- line: 187
	-- upvalues: t1 (copy)
	local v74 = t1.reconcileSlimeData(p11)
	local v75 = t1.getVisualOdds(v74)

	if v75 <= 0 then
		return 0
	end

	local v76 = -math.log10(v75)
	local v77 = math.max(math.floor(v76), 0)
	local v78 = math.clamp(math.floor(10 ^ (v76 - v77) * 100 + 1E-06), 0, 999)

	return -(tonumber(string.format("%d%03d%03d", v77, v78, v74.level)) or 0)
end
function t1.getBaseOdds(p12) -- line: 205
	-- upvalues: Slimes (copy)
	return Slimes.getSlime(p12.id).odds
end
function t1.getActualOdds(p13) -- line: 210
	-- upvalues: t1 (copy), Mutations (copy)
	return t1.getBaseOdds(p13) / Mutations.getVisualOddsMultiplier(p13.mutations)
end
function t1.getVisualOdds(p14) -- line: 216
	-- upvalues: t1 (copy)
	return t1.getActualOdds(p14)
end
function t1.getRarity(p15) -- line: 220
	-- upvalues: t1 (copy)
	local v83 = t1.getActualOdds(p15)

	if v83 <= 0 then
		return 1e999
	end

	return 1 / v83
end
function t1.getEquippedAmount(t4: {[any]: any}, s5: string) -- line: 233
	local n9 = 0

	for _, v89 in t4 do
		if v89 == s5 then
			n9 += 1
		end
	end

	return n9
end
function t1.getAvailableAmount(s6: string, p16, t5: {[any]: any}) -- line: 243
	-- upvalues: t1 (copy)
	return (math.max((type(p16) ~= "number" and 1 or t1.toNonNegativeInteger(p16, 0)) - t1.getEquippedAmount(t5, s6), 0))
end

local function getLowestDamageSlot(t6: {[any]: any}, t7: {[any]: any}, s7: string?) -- line: 252
	-- upvalues: t1 (copy)
	local v96 = nil
	local n10 = 1e999

	for v98, v99 in t7 do
		if v99 == s7 then
			continue
		end

		local v100 = t6[v99]

		if v100 == nil then
			return v98
		end

		local v101 = t1.getSlimeData(v99, v100)
		local damage = t1.getSlimeStatsFromData(v101).damage
		local v103 = t1.getLayoutOrder(v101)

		if v96 == nil or damage < n10 then
			v96 = v98
			n10 = damage
		elseif damage == n10 and v96 ~= nil then
			local v104 = t7[v96]
			local v105 = t6[v104]

			if v105 == nil then
				v96 = v98
				n10 = damage
			else
				local v106 = t1.getSlimeData(v104, v105)

				if v103 > t1.getLayoutOrder(v106) then
					v96 = v98
					n10 = damage
				end
			end
		end
	end

	return v96
end

function t1.getLeastRareEquippedSlot(t8: {[any]: any}, t9: {[any]: any}, s8: string?) -- line: 297
	-- upvalues: getLowestDamageSlot (copy)
	return getLowestDamageSlot(t8, t9, s8) or getLowestDamageSlot(t8, t9, nil)
end
function t1.getBestEquippedUniqueIds(t10: {[any]: any}, n11: number) -- line: 305
	-- upvalues: t1 (copy)
	local v112 = t1.toNonNegativeInteger(n11, 0)

	if v112 <= 0 then
		return {}
	end

	local t11 = {}

	for v114, v115 in t10 do
		local v116 = t1.getSlimeData(v114, v115)
		local v117 = type(v115) ~= "number" and 1 or t1.toNonNegativeInteger(v115, 0)
		local damage = t1.getSlimeStatsFromData(v116).damage
		local v119 = t1.getLayoutOrder(v116)

		for _ = 1, v117 do
			table.insert(t11, {
				uniqueId = v114,
				damage = damage,
				layoutOrder = v119
			})
		end
	end

	table.sort(t11, function(p17, p18) -- line: 329
		if p17.damage == p18.damage then
			if p17.layoutOrder == p18.layoutOrder then
				return p17.uniqueId < p18.uniqueId
			end

			return p17.layoutOrder < p18.layoutOrder
		end

		return p17.damage > p18.damage
	end)

	local t12 = {}

	for i = 1, math.min(v112, #t11) do
		table.insert(t12, t11[i].uniqueId)
	end

	return t12
end
function t1.getLevelProgress(p19) -- line: 349
	-- upvalues: t1 (copy)
	local v124 = t1.reconcileSlimeData(p19)
	local v125 = t1.getXpRequiredForLevel(v124.level)

	return {
		level = v124.level,
		xp = v124.xp,
		xpRequired = v125,
		progress = math.clamp(v124.xp / v125, 0, 1),
		showBar = v124.level > 1 or v124.xp ~= 0
	}
end
function t1.addXp(p20, n12: number) -- line: 361
	-- upvalues: t1 (copy)
	local v128 = t1.reconcileSlimeData(p20)
	local v129 = t1.toNonNegativeInteger(n12, 0)

	if v129 <= 0 then
		return v128
	end

	v128.xp = v128.xp + v129

	return t1.reconcileSlimeData(v128)
end
function t1.getPreviewAfterXp(p21, n13: number) -- line: 372
	-- upvalues: t1 (copy)
	return t1.addXp(p21, n13)
end
function t1.getSlimeStatsFromData(p22) -- line: 393
	-- upvalues: t1 (copy), Slimes (copy), Mutations (copy)
	local v139 = t1.reconcileSlimeData(p22)
	local v140 = Slimes.getSlime(v139.id)
	local mutations = v139.mutations
	local v142 = Mutations.getStatBonus(mutations, "health")
	local v143 = Mutations.getStatBonus(mutations, "damage")
	local health = v140.health
	local level = v139.level
	local v146 = math.max(math.round(((if not (level <= 1) then math.max(math.round(health * ((level - 1) * 0.1 + 1)), 1) else health)) * v142), 1)
	local t13 = {
		speed = 30,
		attackSpeed = 1,
		health = v146,
		maxHealth = v146
	}
	local damage = v140.damage
	local level2 = v139.level

	t13.damage = math.max(math.round(((if not (level2 <= 1) then math.max(math.round(damage * ((level2 - 1) * 0.1 + 1)), 1) else damage)) * v143), 1)

	return t13
end
function t1.getDpsFromStats(p23) -- line: 409
	return p23.damage / math.max(p23.attackSpeed, 0.01)
end
function t1.getDpsFromData(p24) -- line: 413
	-- upvalues: t1 (copy)
	return t1.getDpsFromStats(t1.getSlimeStatsFromData(p24))
end
function t1.getSlimeStats(s9: string, p25) -- line: 417
	-- upvalues: t1 (copy)
	return t1.getSlimeStatsFromData(t1.getSlimeData(s9, p25))
end

return t1
