-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Directory = require(ReplicatedStorage.Directory.Assets).Directory
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)

require(ReplicatedStorage.Library.Modules.Packages.Log).new()

local t = {}

local function getAverageScale(p1) --[[ getAverageScale | Line: 31 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	assert(#p1 == 3, "Fused scale roll requires exactly three input scales")

	local sum = 0

	for i, v in ipairs(p1) do
		Asserts.finite(v)
		assert(if v > 0 then true else false, "Fuse input scale must be positive")
		sum = sum + v
	end

	return sum / #p1
end

function t.CanSelectPet(p1, p2, p3, p4) --[[ CanSelectPet | Line: 49 | Upvalues: Asserts (copy), AssetItem (copy), Directory (copy) ]]
	Asserts.string(p1)
	assert(AssetItem.SerializedAssetItemData(p2))
	Asserts.optional.string(p3)
	Asserts.boolean(p4)

	local v1 = Directory[p2.Category]

	if v1 == nil or v1.CannotFuse == true then
		return false, "That pet cannot be fused"
	end

	if p2.IsFavorite == true then
		return false, "Favorite pets cannot be fused"
	end

	if p4 then
		if p2.InFuse ~= true then
			return false, "That pet is not in this fuse machine"
		end
	elseif p2.InFuse == true then
		return false, "That pet is already in a fuse machine"
	end

	if p3 == nil or p2.Category == p3 then
		return true, nil
	end

	return false, "All three pets must be the same category"
end
function t.GetScaleTierWeightMultiplier(p1, p2, p3) --[[ GetScaleTierWeightMultiplier | Line: 81 | Upvalues: Asserts (copy), getAverageScale (copy) ]]
	Asserts.finite(p2)
	Asserts.finite(p3)
	assert(if p2 > 0 then true else false, "Scale tier minimum must be positive")
	assert(if p2 <= p3 then true else false, "Scale tier maximum must be greater than or equal to its minimum")

	local v3 = getAverageScale(p1)

	return math.exp(math.log(v3) / 0.6931471805599453 * (math.log((p2 + p3) / 2) / 0.6931471805599453) * 0.6)
end
function t.RollFusedAssetScale(p1, p2) --[[ RollFusedAssetScale | Line: 96 | Upvalues: getAverageScale (copy), EggItemUtil (copy), t (copy) ]]
	getAverageScale(p1)

	return EggItemUtil.RollAssetScale(p2, function(p12, p2) --[[ Line: 99 | Upvalues: t (ref), p1 (copy) ]]
		return t.GetScaleTierWeightMultiplier(p1, p12, p2)
	end)
end
function t.CalculateFusePrice(p1) --[[ CalculateFusePrice | Line: 104 | Upvalues: AssetItem (copy), AssetGenerationUtil (copy) ]]
	assert(AssetItem.AssetItemDataArray(p1))
	assert(#p1 == 3, "Fuse price requires exactly three pets")

	local sum = 0
	local v2 = 0

	for i, v in ipairs(p1) do
		sum = sum + AssetGenerationUtil.GetRateWithoutRebirth(v) * 3 * 60
		v2 = math.max(v2, #v.Mutations)
	end

	local v5 = 1

	if v2 == 1 then
		v5 = 2
	elseif v2 >= 2 then
		v5 = 3
	end

	return math.floor(math.floor(sum) * v5)
end

return t