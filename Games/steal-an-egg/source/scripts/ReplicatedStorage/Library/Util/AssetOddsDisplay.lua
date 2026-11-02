-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local t = {}

local function truncateToSignificantDigits(p1) --[[ truncateToSignificantDigits | Line: 31 ]]
	local v2 = 10 ^ (math.floor((math.log10(p1))) - 3 + 1)

	return math.floor(p1 / v2) * v2
end

local function getCompactSkeleton(p1) --[[ getCompactSkeleton | Line: 38 ]]
	if p1 < 1000 then
		return "."
	end

	local v2 = p1 / 1000 ^ math.floor(math.log10(p1) / 3)

	if v2 < 10 then
		return ".##"
	end

	if v2 < 100 then
		return ".#"
	end

	return "."
end

local function formatOddsDenominator(p1) --[[ formatOddsDenominator | Line: 57 | Upvalues: Simple (copy) ]]
	local v1 = math.max(1, p1)
	local v3 = 10 ^ (math.floor((math.log10(v1))) - 3 + 1)
	local v4 = math.floor(v1 / v3) * v3
	local lower = string.lower
	local v5

	if v4 < 1000 then
		v5 = "."
	else
		local v7 = v4 / 1000 ^ math.floor(math.log10(v4) / 3)

		v5 = if v7 < 10 then ".##" elseif v7 < 100 then ".#" else "."
	end

	return lower(Simple.FormatCompact(v4, v5))
end

local function resolveVisualOdds(p1) --[[ resolveVisualOdds | Line: 62 ]]
	local VisualOdds = p1.VisualOdds

	if typeof(VisualOdds) == "number" and VisualOdds > 0 then
		return VisualOdds
	end

	local DropWeight = p1.DropWeight

	if typeof(DropWeight) == "number" and DropWeight > 0 then
		return 1 / DropWeight
	end

	return nil
end

function t.FormatDenominator(p1) --[[ FormatDenominator | Line: 80 | Upvalues: Asserts (copy), formatOddsDenominator (copy) ]]
	Asserts.finite(p1)

	return formatOddsDenominator(p1)
end
function t.GetDenominator(p1, p2) --[[ GetDenominator | Line: 86 | Upvalues: Asserts (copy), Mutations (copy) ]]
	Asserts.table(p1)

	local VisualOdds = p1.VisualOdds
	local v1

	if typeof(VisualOdds) == "number" and VisualOdds > 0 then
		v1 = VisualOdds
	else
		local DropWeight = p1.DropWeight

		v1 = if typeof(DropWeight) == "number" and DropWeight > 0 then 1 / DropWeight else nil
	end

	if v1 == nil then
		return nil
	end

	return v1 * (if p2 == nil then 1 else Mutations.GetVisualOddsMultiplier(p2.Mutations, p2.BaseMutation))
end
function t.GetDisplay(p1, p2, p3) --[[ GetDisplay | Line: 100 | Upvalues: Asserts (copy), t (copy), Simple (copy) ]]
	Asserts.table(p1)

	local v1 = t.GetDenominator(p1, p3)

	if v1 == nil then
		return "1/?"
	end

	local v4 = math.max(1, v1)
	local v6 = 10 ^ (math.floor((math.log10(v4))) - 3 + 1)
	local v7 = math.floor(v4 / v6) * v6
	local lower = string.lower
	local v8

	if v7 < 1000 then
		v8 = "."
	else
		local v10 = v7 / 1000 ^ math.floor(math.log10(v7) / 3)

		v8 = if v10 < 10 then ".##" elseif v10 < 100 then ".#" else "."
	end

	return ("%*%*"):format(if p2 then "1 in " else "1/", (lower(Simple.FormatCompact(v7, v8))))
end
function t.GetDisplayForItemData(p1, p2, p3) --[[ GetDisplayForItemData | Line: 115 | Upvalues: AssetItem (copy), t (copy) ]]
	assert(AssetItem.AssetItemData(p2))

	return t.GetDisplay(p1, p3, {
		Mutations = p2.Mutations,
		BaseMutation = p2.BaseMutation
	})
end

return t