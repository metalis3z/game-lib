-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Areas = require(ReplicatedStorage.Directory.Areas)
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local AssetRollUtil = require(ReplicatedStorage.Library.Util.AssetRollUtil)
local RecoveryEvent = require(ReplicatedStorage.Directory.RecoveryEvent)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local Commas = require(ReplicatedStorage.Library.Functions.Commas)
local PackCFrame = require(ReplicatedStorage.Library.Functions.PackCFrame)
local UnpackCFrame = require(ReplicatedStorage.Library.Functions.UnpackCFrame)
local WeightedScaleRollUtil = require(ReplicatedStorage.Library.Util.WeightedScaleRollUtil)
local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local AssetGenderUtil = require(ReplicatedStorage.Library.Util.AssetGenderUtil)
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local GetPriceValueForItem = require(ReplicatedStorage.Library.Util.GetPriceValueForItem)
local t = {
	{
		min = 0.85,
		max = 1.05,
		weight = 2000
	},
	{
		min = 1.45,
		max = 1.55,
		weight = 250
	},
	{
		min = 1.9,
		max = 2.1,
		weight = 125
	},
	{
		min = 2.85,
		max = 3.15,
		weight = 62.5
	},
	{
		min = 3.8,
		max = 4.2,
		weight = 31.25
	},
	{
		min = 0.3,
		max = 0.45,
		weight = 18
	},
	{
		min = 0.1,
		max = 0.2,
		weight = 5
	},
	{
		min = 5.8,
		max = 6.2,
		weight = 15.625
	},
	{
		min = 9.5,
		max = 12.5,
		weight = 3
	},
	{
		min = 12,
		max = 17,
		weight = 0.05
	},
	{
		min = 20,
		max = 35,
		weight = 0.0001
	}
}
local v1 = Random.new()
local t2 = {}

local function getSizeGrowthMultiplier(p1) --[[ getSizeGrowthMultiplier | Line: 104 ]]
	if p1 <= 2 then
		return 1
	end

	if p1 <= 6 then
		return (p1 / 2) ^ 1.389
	end

	return math.min((p1 / 6) ^ 0.72 * 4.6, 20)
end

function t2.RollAssetScale(p1, p2) --[[ RollAssetScale | Line: 118 | Upvalues: WeightedScaleRollUtil (copy), t (copy) ]]
	return WeightedScaleRollUtil.RollScale(t, p1, 150, 0.01, p2)
end
function t2.NormalizeSavedEgg(p1) --[[ NormalizeSavedEgg | Line: 128 | Upvalues: AssetColorUtil (copy) ]]
	local v1 = AssetColorUtil.ResolveFields(p1.AssetCategory, p1.AssetEyeColor, p1.AssetColorSeed, p1.AssetColorIndex)
	local v2 = table.clone(p1)

	v2.AssetEyeColor = v1.EyeColor
	v2.AssetColorSeed = v1.ColorSeed
	v2.AssetColorIndex = v1.ColorIndex

	return v2
end
function t2.SerializePlacement(p1) --[[ SerializePlacement | Line: 142 | Upvalues: UnpackCFrame (copy) ]]
	return {
		LocalCFrame = UnpackCFrame(p1.LocalCFrame),
		PlacedAt = p1.PlacedAt,
		GrowthDuration = p1.GrowthDuration,
		GrowthCreditSeconds = p1.GrowthCreditSeconds,
		NightGrowthPeriodIndex = p1.NightGrowthPeriodIndex,
		NightGrowthCreditSeconds = p1.NightGrowthCreditSeconds,
		ReadyAt = p1.ReadyAt
	}
end
function t2.DeserializePlacement(p1) --[[ DeserializePlacement | Line: 154 | Upvalues: PackCFrame (copy) ]]
	return {
		LocalCFrame = PackCFrame(p1.LocalCFrame),
		PlacedAt = p1.PlacedAt,
		GrowthDuration = p1.GrowthDuration,
		GrowthCreditSeconds = p1.GrowthCreditSeconds,
		NightGrowthPeriodIndex = p1.NightGrowthPeriodIndex,
		NightGrowthCreditSeconds = p1.NightGrowthCreditSeconds,
		ReadyAt = p1.ReadyAt
	}
end
function t2.GetGrowthDuration(p1) --[[ GetGrowthDuration | Line: 166 | Upvalues: Eggs (copy), Asserts (copy), Assets (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	local v2 = assert(p1.Placement, "Egg growth duration requires a placed egg")

	if v2.GrowthDuration ~= nil then
		return v2.GrowthDuration
	end

	Asserts.finite(p1.AssetScale)
	assert(p1.AssetScale > 0, "Egg growth scale must be positive")

	local v4 = Assets.Directory[p1.AssetCategory]

	assert(v4 ~= nil, (("Missing asset config %*"):format(p1.AssetCategory)))

	local AssetScale = p1.AssetScale

	return v4.Egg.GrowthTime * (if AssetScale <= 2 then 1 elseif AssetScale <= 6 then (AssetScale / 2) ^ 1.389 else math.min((AssetScale / 6) ^ 0.72 * 4.6, 20))
end
function t2.GetGrowthSpeedMultiplier(p1) --[[ GetGrowthSpeedMultiplier | Line: 182 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p1)

	if p1 then
		return 2
	end

	return 1
end
function t2.GetRemainingGrowthWallSeconds(p1, p2, p3, p4) --[[ GetRemainingGrowthWallSeconds | Line: 187 | Upvalues: t2 (copy), RecoveryEvent (copy) ]]
	local sum = t2.GetRemainingGrowthSeconds(p1, p2, p3, p4)

	if sum <= 0 then
		return 0
	end

	local v1, sum2 = p2, 0

	while sum > 0 do
		local v2 = RecoveryEvent.GetEventAtOrAfter(v1)

		if v2 == nil then
			return sum2 + sum / p3
		end

		if v1 < v2.StartsAt then
			local v3 = v2.StartsAt - v1
			local v4 = v3 * p3

			if sum <= v4 then
				return sum2 + sum / p3
			end

			v1 = v2.StartsAt
			sum = sum - v4
			sum2 = sum2 + v3
		end

		local v5 = p3 + v2.EggGrowthMultiplier - 1
		local v6 = v2.EndsAt - v1
		local v7 = v6 * v5

		if sum <= v7 then
			return sum2 + sum / v5
		end

		v1 = v2.EndsAt
		sum = sum - v7
		sum2 = sum2 + v6
	end

	return sum2
end
function t2.GetGrowthCreditSeconds(p1) --[[ GetGrowthCreditSeconds | Line: 234 | Upvalues: Asserts (copy) ]]
	local Placement = p1.Placement

	if Placement == nil then
		return 0
	end

	local v1 = Placement.GrowthCreditSeconds or 0

	Asserts.finiteNonNegative(v1)

	return v1
end
function t2.GetCommittedNightGrowthCreditSeconds(p1, p2) --[[ GetCommittedNightGrowthCreditSeconds | Line: 245 | Upvalues: Asserts (copy) ]]
	Asserts.integerNonNegative(p2)

	local Placement = p1.Placement

	if Placement == nil then
		return 0
	end

	Asserts.optional.integerNonNegative(Placement.NightGrowthPeriodIndex)

	if Placement.NightGrowthPeriodIndex == p2 then
		local v1 = Placement.NightGrowthCreditSeconds or 0

		Asserts.finiteNonNegative(v1)

		return v1
	end

	return 0
end
function t2.GetNightGrowthCreditSecondsAt(p1, p2, p3, p4, p5) --[[ GetNightGrowthCreditSecondsAt | Line: 261 | Upvalues: Asserts (copy), t2 (copy), AreaEggResetTimeUtil (copy) ]]
	Asserts.finite(p2)
	Asserts.finite(p3)
	Asserts.finite(p4)
	Asserts.integerNonNegative(p5)
	assert(if p3 > 0 then true else false, "Egg growth speed multiplier must be positive")

	local Placement = p1.Placement

	if Placement == nil or (Placement.ReadyAt ~= nil or p4 < Placement.PlacedAt) then
		return 0
	end

	local v2 = t2.GetCommittedNightGrowthCreditSeconds(p1, p5)
	local v3 = t2.GetRemainingGrowthSeconds(p1, p4, p3) + v2

	return math.max(0, math.min(AreaEggResetTimeUtil.GetNightGrowthSecondsAt(p2, p4), v3) - v2)
end
function t2.GetCurrentNightGrowthCreditSeconds(p1, p2, p3) --[[ GetCurrentNightGrowthCreditSeconds | Line: 287 | Upvalues: AreaEggResetTimeUtil (copy), t2 (copy) ]]
	if AreaEggResetTimeUtil.IsNight(p2) then
		local v1 = AreaEggResetTimeUtil.GetNightStartsAt(p2)

		return t2.GetNightGrowthCreditSecondsAt(p1, p2, p3, v1, AreaEggResetTimeUtil.GetPeriodIndex(v1 + AreaEggResetTimeUtil.NightDurationSeconds))
	end

	return 0
end
function t2.GetGrowthAlpha(p1, p2, p3, p4) --[[ GetGrowthAlpha | Line: 307 | Upvalues: Asserts (copy), t2 (copy), RecoveryEvent (copy) ]]
	Asserts.finite(p2)
	Asserts.finite(p3)
	Asserts.optional.finiteNonNegative(p4)
	assert(if p3 > 0 then true else false, "Egg growth speed multiplier must be positive")

	local Placement = p1.Placement

	if Placement == nil then
		return 0
	end

	if Placement.ReadyAt ~= nil then
		return 1
	end

	local v2 = t2.GetGrowthDuration(p1)

	if v2 <= 0 then
		return 1
	end

	return math.clamp(((p2 - Placement.PlacedAt) * p3 + (t2.GetGrowthCreditSeconds(p1) + (p4 or 0) + RecoveryEvent.GetGrowthBonusSeconds(Placement.PlacedAt, p2))) / v2, 0, 1)
end
function t2.GetRemainingGrowthSeconds(p1, p2, p3, p4) --[[ GetRemainingGrowthSeconds | Line: 341 | Upvalues: Asserts (copy), t2 (copy), RecoveryEvent (copy) ]]
	Asserts.finite(p2)
	Asserts.finite(p3)
	Asserts.optional.finiteNonNegative(p4)
	assert(if p3 > 0 then true else false, "Egg growth speed multiplier must be positive")

	local v2 = assert(p1.Placement, "Egg remaining growth time requires a placed egg")

	if v2.ReadyAt == nil then
		local v3 = t2.GetGrowthCreditSeconds(p1) + (p4 or 0) + RecoveryEvent.GetGrowthBonusSeconds(v2.PlacedAt, p2)

		return math.max(0, t2.GetGrowthDuration(p1) - (p2 - v2.PlacedAt) * p3 - v3)
	end

	return 0
end
function t2.IsGrowthReady(p1, p2, p3, p4) --[[ IsGrowthReady | Line: 368 | Upvalues: t2 (copy) ]]
	return t2.GetGrowthAlpha(p1, p2, p3, p4) >= 1
end
function t2.SerializeSavedEgg(p1) --[[ SerializeSavedEgg | Line: 377 | Upvalues: t2 (copy) ]]
	local v1 = t2.NormalizeSavedEgg(p1)
	local Placement = v1.Placement
	local t = {
		AssetCategory = v1.AssetCategory,
		AssetScale = v1.AssetScale,
		AssetEyeColor = v1.AssetEyeColor,
		AssetColorSeed = v1.AssetColorSeed,
		AssetColorIndex = v1.AssetColorIndex
	}

	t.Mutations = if v1.Mutations then table.clone(v1.Mutations) else nil
	t.BaseMutation = v1.BaseMutation
	t.AssetGender = v1.AssetGender
	t.AssetPersonality = v1.AssetPersonality
	t.IsStolenDNA = v1.IsStolenDNA
	t.Placement = if Placement then t2.SerializePlacement(Placement) else nil

	return t
end
function t2.DeserializeSavedEgg(p1) --[[ DeserializeSavedEgg | Line: 395 | Upvalues: t2 (copy) ]]
	local Placement = p1.Placement
	local t = {
		AssetCategory = p1.AssetCategory,
		AssetScale = p1.AssetScale,
		AssetEyeColor = p1.AssetEyeColor,
		AssetColorSeed = p1.AssetColorSeed,
		AssetColorIndex = p1.AssetColorIndex
	}

	t.Mutations = if p1.Mutations then table.clone(p1.Mutations) else nil
	t.BaseMutation = p1.BaseMutation
	t.AssetGender = p1.AssetGender
	t.AssetPersonality = p1.AssetPersonality
	t.IsStolenDNA = p1.IsStolenDNA
	t.Placement = if Placement then t2.DeserializePlacement(Placement) else nil

	return t2.NormalizeSavedEgg(t)
end
function t2.BuildSavedEgg(p1, p2) --[[ BuildSavedEgg | Line: 412 | Upvalues: Asserts (copy), v1 (copy), AssetRollUtil (copy), AssetColorUtil (copy), t2 (copy), Eggs (copy) ]]
	Asserts.string(p1)

	local v12 = if p2 then p2 else v1
	local v2 = AssetRollUtil.ChooseMutations(nil, nil, v12)
	local v3 = AssetColorUtil.RollFields(p1, v12)
	local t = {
		AssetCategory = p1,
		AssetScale = t2.RollAssetScale(v12),
		AssetEyeColor = v3.EyeColor,
		AssetColorSeed = v3.ColorSeed,
		AssetColorIndex = v3.ColorIndex,
		Mutations = v2,
		BaseMutation = v2[1]
	}
	local v4, v5 = Eggs.SchemaValidation.SavedEgg(t)

	assert(v4, v5)

	return t
end
function t2.BuildStolenDnaEgg(p1) --[[ BuildStolenDnaEgg | Line: 434 | Upvalues: AssetItem (copy), AssetGenderUtil (copy), Eggs (copy) ]]
	assert(AssetItem.AssetItemData(p1))

	local t = {
		IsStolenDNA = true,
		AssetCategory = p1.Category,
		AssetScale = p1.Scale
	}

	t.AssetEyeColor = assert(p1.EyeColor, "Asset DNA requires a resolved eye color")
	t.AssetColorSeed = assert(p1.ColorSeed, "Asset DNA requires a resolved color seed")
	t.AssetColorIndex = assert(p1.ColorIndex, "Asset DNA requires a resolved color index")
	t.Mutations = table.clone(p1.Mutations)
	t.BaseMutation = p1.BaseMutation
	t.AssetGender = AssetGenderUtil.ResolveForCategory(p1.Category, p1.Gender)
	t.AssetPersonality = p1.Personality

	local v1, v2 = Eggs.SchemaValidation.SavedEgg(t)

	assert(v1, v2)

	return t
end
function t2.BuildAssetItemData(p1) --[[ BuildAssetItemData | Line: 455 | Upvalues: Eggs (copy), Personalities (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	local t = {
		Category = p1.AssetCategory,
		Scale = p1.AssetScale,
		EyeColor = p1.AssetEyeColor,
		ColorSeed = p1.AssetColorSeed,
		ColorIndex = p1.AssetColorIndex
	}

	t.Mutations = p1.Mutations or {}
	t.BaseMutation = p1.BaseMutation
	t.Gender = p1.AssetGender
	t.IsStolenDNA = p1.IsStolenDNA

	return Personalities.CreateNewItemData(t, nil, p1.AssetPersonality)
end
function t2.GetSellPrice(p1) --[[ GetSellPrice | Line: 475 | Upvalues: Eggs (copy), t2 (copy), GetPriceValueForItem (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	local v2 = table.clone(t2.BuildAssetItemData(p1))

	v2.Mutations = {}
	v2.BaseMutation = nil

	return GetPriceValueForItem(v2) * 0.8
end
function t2.GetWeightKgForScale(p1, p2) --[[ GetWeightKgForScale | Line: 485 | Upvalues: Asserts (copy), AssetItemUtil (copy) ]]
	Asserts.string(p1)
	Asserts.finite(p2)

	return AssetItemUtil.GetVisualWeightKg({
		Category = p1,
		Scale = p2,
		Mutations = {}
	})
end
function t2.GetWeightKg(p1) --[[ GetWeightKg | Line: 496 | Upvalues: Eggs (copy), t2 (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	return t2.GetWeightKgForScale(p1.AssetCategory, p1.AssetScale)
end
function t2.GetWeightKgDisplay(p1) --[[ GetWeightKgDisplay | Line: 502 | Upvalues: Commas (copy), t2 (copy) ]]
	return ("%*Kg"):format((Commas(t2.GetWeightKg(p1))))
end
function t2.GetDisplayName(p1) --[[ GetDisplayName | Line: 506 | Upvalues: Eggs (copy), Assets (copy), Areas (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	local v2 = Assets.Directory[p1.AssetCategory]

	assert(v2 ~= nil, (("Missing asset config %*"):format(p1.AssetCategory)))

	local _id = v2.Rarity._id

	for k, v in pairs(Areas.Directory) do
		for i, v5 in ipairs(v.DropTable) do
			local v52 = v5[1]

			if v52 == p1.AssetCategory or v52 == _id then
				return ("%* Egg"):format(v.DisplayName)
			end
		end
	end

	return "Egg"
end
function t2.GetDisplayNameWithWeight(p1) --[[ GetDisplayNameWithWeight | Line: 524 | Upvalues: t2 (copy) ]]
	return ("%* (%*)"):format(t2.GetDisplayName(p1), (t2.GetWeightKgDisplay(p1)))
end

return t2