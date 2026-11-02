-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RareRollCutsceneUtils, time of decompilation: Sun May  3 10:11:42 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)

require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)

local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)
local RollStatResolver = require(ReplicatedStorage.Source.Features.Roll.RollStatResolver)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	[1] = 500,
	[2] = 500,
	[3] = 1000,
	[4] = 1000
}
local t2 = {}

local function getRarestQualifiedSlimeByBaseThreshold(t3: {[any]: any}, n1: number) -- line: 44
	-- upvalues: InventoryServiceUtils (copy)
	local v12 = nil
	local n2 = 0

	for _, v15 in t3 do
		local v16 = 1 / InventoryServiceUtils.getVisualOdds({
			level = 1,
			xp = 0,
			id = v15.id,
			mutations = v15.mutations
		})

		if not (v16 < n1) and n2 < v16 then
			n2 = v16
			v12 = table.clone(v15)
		end
	end

	return v12
end

function t2.getRebirthLuckMultiplier(n3: number?) -- line: 66
	-- upvalues: RebirthServiceUtils (copy)
	return RebirthServiceUtils.getLuckMultiplier(n3)
end
function t2.getPermanentLuck(t4: {[any]: any}?) -- line: 70
	-- upvalues: RebirthServiceUtils (copy), IndexServiceUtils (copy), RollStatResolver (copy)
	local v19 = t4 or {}
	local t5 = {}

	RebirthServiceUtils.addLuckModifier(t5, v19.rebirths)

	for _, v22 in IndexServiceUtils.getLuckModifiers(v19.indexData) do
		table.insert(t5, v22)
	end

	return RollStatResolver.resolve({
		upgradesOwned = v19.upgradesOwned or {},
		zoneLuckBonus = math.max((v19.furthestZone or 1) - 1, 0),
		modifiers = t5,
		ownsProductKey = v19.ownsProductKey
	}).luck
end
function t2.getBaseRarityDenominator(p1) -- line: 85
	-- upvalues: InventoryServiceUtils (copy)
	return 1 / InventoryServiceUtils.getVisualOdds({
		level = 1,
		xp = 0,
		id = p1.id,
		mutations = p1.mutations
	})
end
function t2.getEffectiveRarityDenominator(p2, n4: number) -- line: 89
	-- upvalues: t2 (copy)
	return t2.getBaseRarityDenominator(p2) / math.max(n4, 1)
end
function t2.getRequiredRarityDenominator(n5: number, n6: number) -- line: 93
	-- upvalues: t1 (copy)
	local v28 = t1[math.max(n5, 1)]

	if v28 ~= nil then
		return v28
	end

	return math.max(n6, 1) * 300
end
function t2.getFixedRequiredRarityDenominator(n7: number) -- line: 103
	-- upvalues: t1 (copy)
	return t1[math.max(n7, 1)]
end
function t2.isRareSlime(p3, n8: number, n9: number) -- line: 107
	-- upvalues: InventoryServiceUtils (copy), t2 (copy)
	return 1 / InventoryServiceUtils.getVisualOdds({
		level = 1,
		xp = 0,
		id = p3.id,
		mutations = p3.mutations
	}) >= t2.getRequiredRarityDenominator(n8, n9)
end
function t2.getAnnouncementScope(p4, n10: number) -- line: 116
	-- upvalues: t2 (copy)
	local v35 = t2.getBaseRarityDenominator(p4)
	local v36 = t2.getEffectiveRarityDenominator(p4, n10)

	if v36 >= 4000000 then
		return "global"
	end

	if v35 >= 500000 and v36 >= 50000 then
		return "server"
	end

	return nil
end
function t2.getRarestQualifiedSlime(p5, n11: number, n12: number) -- line: 135
	-- upvalues: t2 (copy)
	local t6 = {}

	for _, v42 in p5 do
		local v43 = v42[#v42]

		if type(v43) == "table" and v43.id ~= nil then
			table.insert(t6, v43)
		end
	end

	return t2.getRarestQualifiedSlimeFromList(t6, n11, n12)
end
function t2.getRarestQualifiedSlimeByThreshold(p6, n13: number, n14: number) -- line: 154
	-- upvalues: t2 (copy)
	local t7 = {}

	for _, v49 in p6 do
		local v50 = v49[#v49]

		if type(v50) == "table" and v50.id ~= nil then
			table.insert(t7, v50)
		end
	end

	return t2.getRarestQualifiedSlimeFromListByThreshold(t7, n13, n14)
end
function t2.getRarestAnnouncableSlime(p7, n15: number) -- line: 177
	-- upvalues: t2 (copy)
	local t8 = {}

	for _, v55 in p7 do
		local v56 = v55[#v55]

		if type(v56) == "table" and v56.id ~= nil then
			table.insert(t8, v56)
		end
	end

	return t2.getRarestAnnouncableSlimeFromList(t8, n15)
end
function t2.getRarestQualifiedSlimeFromList(t9: {[any]: any}, n16: number, n17: number) -- line: 192
	-- upvalues: getRarestQualifiedSlimeByBaseThreshold (copy), t2 (copy)
	return (getRarestQualifiedSlimeByBaseThreshold(t9, t2.getRequiredRarityDenominator(n16, n17)))
end
function t2.getRarestQualifiedSlimeFromListByThreshold(t10: {[any]: any}, n18: number, n19: number) -- line: 203
	-- upvalues: t2 (copy), InventoryServiceUtils (copy)
	local v63 = nil
	local n20 = 0

	for _, v66 in t10 do
		if not (n19 > t2.getEffectiveRarityDenominator(v66, n18)) then
			local v67 = 1 / InventoryServiceUtils.getVisualOdds({
				level = 1,
				xp = 0,
				id = v66.id,
				mutations = v66.mutations
			})

			if n20 < v67 then
				n20 = v67
				v63 = table.clone(v66)
			end
		end
	end

	return v63
end
function t2.getRarestAnnouncableSlimeFromList(t11: {[any]: any}, n21: number) -- line: 227
	-- upvalues: t2 (copy), InventoryServiceUtils (copy)
	local v70 = nil
	local n22 = 0

	for _, v73 in t11 do
		if t2.getAnnouncementScope(v73, n21) ~= nil then
			local v74 = 1 / InventoryServiceUtils.getVisualOdds({
				level = 1,
				xp = 0,
				id = v73.id,
				mutations = v73.mutations
			})

			if n22 < v74 then
				n22 = v74
				v70 = table.clone(v73)
			end
		end
	end

	return v70
end

return t2
