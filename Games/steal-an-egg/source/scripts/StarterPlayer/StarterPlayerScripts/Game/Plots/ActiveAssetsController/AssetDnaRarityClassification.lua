-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local AssetSizeClassification = require(ReplicatedStorage.Library.Util.AssetSizeClassification)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local v1 = table.freeze({
	{
		MinimumScore = 6,
		Suffix = "Impossibly Rare",
		Color = Color3.fromRGB(255, 59, 127)
	},
	{
		MinimumScore = 5,
		Suffix = "Mega Rare",
		Color = Color3.fromRGB(255, 138, 0)
	},
	{
		MinimumScore = 4,
		Suffix = "Giga Rare",
		Color = Color3.fromRGB(255, 215, 0)
	},
	{
		MinimumScore = 3,
		Suffix = "Ultra Rare",
		Color = Color3.fromRGB(155, 81, 224)
	},
	{
		MinimumScore = 2,
		Suffix = "Super Rare",
		Color = Color3.fromRGB(47, 128, 237)
	},
	{
		MinimumScore = 0,
		Suffix = "Rare",
		Color = Color3.fromRGB(52, 199, 89)
	}
})
local t = {}

local function getBaseScore(p1) --[[ getBaseScore | Line: 49 ]]
	if p1 >= 10 then
		return 6
	end

	if p1 >= 9 then
		return 3
	end

	if p1 >= 8 then
		return 2
	end

	if p1 >= 7 then
		return 1
	end

	if p1 >= 6 then
		return 0.5
	end

	return 0
end

local function getPersonalityScore(p1) --[[ getPersonalityScore | Line: 65 | Upvalues: Personalities (copy) ]]
	local RollWeight = Personalities.GetConfig(p1.Personality).RollWeight

	if RollWeight <= 1.5 then
		return 1
	end

	if RollWeight <= 2.5 then
		return 0.75
	end

	if RollWeight <= 3.5 then
		return 0.5
	end

	if RollWeight <= 7 then
		return 0.25
	end

	return 0
end

local function getMutationQualityScore(p1) --[[ getMutationQualityScore | Line: 80 | Upvalues: Mutations (copy) ]]
	local v3 = assert(Mutations.GetMutation(p1), (("Unknown mutation \"%*\""):format(p1)))
	local Odds = v3.Odds

	if Odds and Odds > 0 then
		if Odds <= 0.01 then
			return 0.5
		end

		if Odds <= 0.04 then
			return 0.35
		end

		if Odds <= 0.07 then
			return 0.25
		end

		return 0.1
	end

	local DropWeight = v3.DropWeight

	if not (DropWeight > 0) then
		return 0.25
	end

	if DropWeight <= 1 then
		return 0.5
	end

	if DropWeight <= 4 then
		return 0.35
	end

	if DropWeight <= 7 then
		return 0.25
	end

	return 0.1
end

local function getMutationScore(p1, p2) --[[ getMutationScore | Line: 111 | Upvalues: getMutationQualityScore (copy) ]]
	local t = {}
	local count = 0
	local v1 = 0

	local function includeMutation(p1) --[[ includeMutation | Line: 116 | Upvalues: t (copy), count (ref), v1 (ref), getMutationQualityScore (ref) ]]
		if p1 ~= nil and (p1 ~= "" and (p1 ~= "None" and not t[p1])) then
			t[p1] = true
			count = count + 1
			v1 = math.max(v1, (getMutationQualityScore(p1)))
		end
	end

	local BaseMutation = p1.BaseMutation

	if BaseMutation ~= nil and (BaseMutation ~= "" and (BaseMutation ~= "None" and not t[BaseMutation])) then
		t[BaseMutation] = true
		count = count + 1
		v1 = math.max(v1, (getMutationQualityScore(BaseMutation)))
	end

	for i, v in ipairs(p1.Mutations) do
		if v ~= nil and (v ~= "" and v ~= "None") and not t[v] then
			t[v] = true
			count = count + 1
			v1 = math.max(v1, (getMutationQualityScore(v)))
		end
	end

	local v5 = math.min(count * 0.5, 2)
	local v6 = if p2 >= 9 and count >= 4 then 0.5 else 0

	return v5 + v1 + v6
end

local function resolveSuffixTier(p1) --[[ resolveSuffixTier | Line: 139 | Upvalues: v1 (copy) ]]
	for i, v in ipairs(v1) do
		if v.MinimumScore <= p1 then
			return v
		end
	end

	error("DNA rarity suffix tiers must include a zero-score tier")
end

function t.Resolve(p1, p2) --[[ Resolve | Line: 153 | Upvalues: AssetItem (copy), Asserts (copy), Personalities (copy), getMutationScore (copy), v1 (copy), AssetSizeClassification (copy) ]]
	assert(AssetItem.AssetItemData(p1))
	Asserts.number(p2)

	local RollWeight = Personalities.GetConfig(p1.Personality).RollWeight
	local v3 = (if p2 >= 10 then 6 elseif p2 >= 9 then 3 elseif p2 >= 8 then 2 elseif p2 >= 7 then 1 elseif p2 >= 6 then 0.5 else 0) + (if RollWeight <= 1.5 then 1 elseif RollWeight <= 2.5 then 0.75 elseif RollWeight <= 3.5 then 0.5 elseif RollWeight <= 7 then 0.25 else 0) + getMutationScore(p1, p2)
	local v4

	do
		local __inline_returned = false

		for i, v in ipairs(v1) do
			if v.MinimumScore <= v3 then
				v4 = v
				__inline_returned = true

				break
			end
		end

		if not __inline_returned then
			error("DNA rarity suffix tiers must include a zero-score tier")
		end
	end

	local v5 = AssetSizeClassification.Resolve(p1.Scale)
	local v6 = if v5 then ("%* %*"):format(v5.Prefix, v4.Suffix) else v4.Suffix
	local v7 = if v5 then v5.Color else v4.Color
	local v8 = if v5 == nil and (v4.Suffix == "Ultra Rare" or v4.Suffix == "Impossibly Rare") then "an" else "a"
	local t = {
		Article = v8,
		Descriptor = v6,
		RichText = ("<font color=\"#%*\">%*</font>"):format(v7:ToHex(), v6),
		Score = v3
	}

	t.SizePrefix = if v5 then v5.Prefix else nil
	t.SizeRichText = if v5 then v5.RichText else nil

	return t
end

return t