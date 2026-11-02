-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferServiceUtils, time of decompilation: Sun May  3 10:12:36 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	XP_TRANSFER_MACHINE_UNLOCK_KEY = "xpTransferMachine",
	XP_TRANSFER_MACHINE_UNLOCK_PRICE = 1000000,
	XP_TRANSFER_MACHINE_USE_RADIUS = 10,
	XP_TRANSFER_RATE = 0.75
}

local function buildInventoryEntries(t2: {[any]: any}, b1: boolean?) -- line: 22
	-- upvalues: InventoryServiceUtils (copy)
	local t3 = {}

	for v8, v9 in t2 do
		local v10 = InventoryServiceUtils.getSlimeData(v8, v9)

		table.insert(t3, {
			uniqueId = v8,
			ownedAmount = type(v9) ~= "number" and 1 or InventoryServiceUtils.toNonNegativeInteger(v9, 0),
			slimeData = v10,
			stackable = type(v9) == "number",
			accumulatedXp = InventoryServiceUtils.getAccumulatedXp(v10)
		})
	end

	table.sort(t3, function(t4: {[any]: any}, t5: {[any]: any}) -- line: 36
		-- upvalues: b1 (copy), InventoryServiceUtils (copy)
		if b1 and t4.accumulatedXp ~= t5.accumulatedXp then
			return t4.accumulatedXp > t5.accumulatedXp
		end

		if b1 and t4.stackable ~= t5.stackable then
			return not t4.stackable
		end

		local v44 = InventoryServiceUtils.getLayoutOrder(t4.slimeData)
		local v45 = InventoryServiceUtils.getLayoutOrder(t5.slimeData)

		if v44 ~= v45 then
			return v44 < v45
		end

		return t4.uniqueId < t5.uniqueId
	end)

	return t3
end

function t1.isMachineUnlocked(t6: {[any]: any}?) -- line: 55
	-- upvalues: t1 (copy)
	return t6 ~= nil and t6[t1.XP_TRANSFER_MACHINE_UNLOCK_KEY] == true
end
function t1.hasTransferableXp(p1) -- line: 59
	-- upvalues: InventoryServiceUtils (copy)
	return InventoryServiceUtils.getAccumulatedXp(p1) > 0
end
function t1.getTransferInputEntries(t7: {[any]: any}?, s1: string?) -- line: 63
	-- upvalues: buildInventoryEntries (copy)
	local t8 = {}

	for _, v17 in buildInventoryEntries(t7 or {}, true) do
		if s1 ~= v17.uniqueId and not v17.stackable and not (v17.ownedAmount <= 0) and not (v17.accumulatedXp <= 0) then
			table.insert(t8, v17)
		end
	end

	return t8
end
function t1.getTransferOutputEntries(t9: {[any]: any}?, t10: {[any]: any}?) -- line: 88
	-- upvalues: buildInventoryEntries (copy)
	local t11 = {}

	for _, v22 in t10 or {} do
		if type(v22) == "string" then
			t11[v22] = true
		end
	end

	local t12 = {}

	for _, v25 in buildInventoryEntries(t9 or {}, false) do
		if not t11[v25.uniqueId] and not (v25.ownedAmount <= 0) then
			table.insert(t12, v25)
		end
	end

	return t12
end
function t1.getSelectedInputSlimeDatas(t13: {[any]: any}?, t14: {[any]: any}?) -- line: 114
	-- upvalues: InventoryServiceUtils (copy)
	local t15 = {}
	local v29 = t13 or {}

	for _, v31 in t14 or {} do
		if type(v31) == "string" and v31 ~= "" then
			local v32 = v29[v31]

			if type(v32) == "table" then
				table.insert(t15, InventoryServiceUtils.getSlimeData(v31, v32))
			end
		end
	end

	return t15
end
function t1.getTransferableXp(p2) -- line: 137
	-- upvalues: InventoryServiceUtils (copy), t1 (copy)
	local v34 = InventoryServiceUtils.getAccumulatedXp(p2) * t1.XP_TRANSFER_RATE

	return InventoryServiceUtils.toNonNegativeInteger(v34, 0)
end
function t1.getTotalTransferXp(t16: {[any]: any}) -- line: 142
	-- upvalues: t1 (copy), InventoryServiceUtils (copy)
	local n1 = 0

	for _, v38 in t16 do
		n1 += t1.getTransferableXp(v38)
	end

	return InventoryServiceUtils.toNonNegativeInteger(n1, 0)
end
function t1.getOutputPreview(p3, n2: number) -- line: 151
	-- upvalues: InventoryServiceUtils (copy)
	if p3 == nil then
		return nil
	end

	if not InventoryServiceUtils.isFiniteNumber(n2) or n2 <= 0 then
		return InventoryServiceUtils.reconcileSlimeData(p3)
	end

	return InventoryServiceUtils.getPreviewAfterXp(p3, n2)
end
function t1.getDrainedInputPreview(p4) -- line: 162
	-- upvalues: InventoryServiceUtils (copy)
	if p4 == nil then
		return nil
	end

	return InventoryServiceUtils.reconcileSlimeData({
		level = 1,
		xp = 0,
		id = p4.id,
		mutations = p4.mutations
	})
end

return t1
