-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local AssetGenderUtil = require(ReplicatedStorage.Library.Util.AssetGenderUtil)

require(ReplicatedStorage.Library.Types.AssetItem)

local t = {}

local function sanitizeMutations(p1) --[[ sanitizeMutations | Line: 23 ]]
	local t = {}

	for i, v in ipairs(p1) do
		if typeof(v) == "string" and (v ~= "" and v ~= "None") then
			table.insert(t, v)
		end
	end

	return t
end

local function resolveGender(p1, p2) --[[ resolveGender | Line: 35 | Upvalues: AssetGenderUtil (copy) ]]
	if AssetGenderUtil.ResolveForCategory(p1, p2) == "Male" then
		return "Male"
	end

	return "Female"
end

function t.Serialize(p1) --[[ Serialize | Line: 48 | Upvalues: sanitizeMutations (copy), AssetColorUtil (copy), AssetGenderUtil (copy) ]]
	local v1 = sanitizeMutations(p1.Mutations)
	local BaseMutation = p1.BaseMutation

	if typeof(BaseMutation) ~= "string" or (BaseMutation == "" or BaseMutation == "None") then
		BaseMutation = v1[1]
	end

	local v2 = AssetColorUtil.ResolveFields(p1.Category, p1.EyeColor, p1.ColorSeed, p1.ColorIndex)

	return {
		Category = p1.Category,
		Mutations = v1,
		BaseMutation = BaseMutation,
		Scale = p1.Scale,
		Gender = if AssetGenderUtil.ResolveForCategory(p1.Category, p1.Gender) == "Male" then "Male" else "Female",
		EyeColor = v2.EyeColor,
		ColorSeed = v2.ColorSeed,
		ColorIndex = v2.ColorIndex,
		IsFavorite = p1.IsFavorite,
		GeneratedMoney = p1.GeneratedMoney,
		LastTick = p1.LastTick,
		PendingEggName = p1.PendingEggName,
		Claimed = p1.Claimed,
		LuckyBlockUnlockTimestamp = p1.LuckyBlockUnlockTimestamp,
		LuckyBlockUnlockDuration = p1.LuckyBlockUnlockDuration,
		LuckyBlockInstantUnlock = p1.LuckyBlockInstantUnlock,
		InFuse = p1.InFuse or false,
		SpecialLuckyBlockColumn = p1.SpecialLuckyBlockColumn,
		SpecialLuckyBlockCapturedAt = p1.SpecialLuckyBlockCapturedAt,
		Personality = p1.Personality,
		HasBeenFirstPlaced = p1.HasBeenFirstPlaced,
		IsStolenDNA = p1.IsStolenDNA
	}
end
function t.Deserialize(p1) --[[ Deserialize | Line: 84 | Upvalues: sanitizeMutations (copy), AssetColorUtil (copy), AssetGenderUtil (copy) ]]
	local v1 = sanitizeMutations(p1.Mutations)
	local BaseMutation = p1.BaseMutation

	if typeof(BaseMutation) ~= "string" or (BaseMutation == "" or BaseMutation == "None") then
		BaseMutation = v1[1]
	end

	local v2 = AssetColorUtil.ResolveFields(p1.Category, p1.EyeColor, p1.ColorSeed, p1.ColorIndex)

	return {
		Category = p1.Category,
		Mutations = v1,
		BaseMutation = BaseMutation,
		Scale = p1.Scale,
		Gender = if AssetGenderUtil.ResolveForCategory(p1.Category, p1.Gender) == "Male" then "Male" else "Female",
		EyeColor = v2.EyeColor,
		ColorSeed = v2.ColorSeed,
		ColorIndex = v2.ColorIndex,
		IsFavorite = p1.IsFavorite,
		GeneratedMoney = p1.GeneratedMoney,
		LastTick = p1.LastTick,
		PendingEggName = p1.PendingEggName,
		Claimed = p1.Claimed,
		LuckyBlockUnlockTimestamp = p1.LuckyBlockUnlockTimestamp,
		LuckyBlockUnlockDuration = p1.LuckyBlockUnlockDuration,
		LuckyBlockInstantUnlock = p1.LuckyBlockInstantUnlock,
		InFuse = p1.InFuse or false,
		SpecialLuckyBlockColumn = p1.SpecialLuckyBlockColumn,
		SpecialLuckyBlockCapturedAt = p1.SpecialLuckyBlockCapturedAt,
		Personality = p1.Personality,
		HasBeenFirstPlaced = p1.HasBeenFirstPlaced,
		IsStolenDNA = p1.IsStolenDNA
	}
end

return t