-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local LotteryCustom = require(ReplicatedStorage.Library.Functions.LotteryCustom)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = t.Random
local t2 = {}

local function isEyePart(p1) --[[ isEyePart | Line: 47 ]]
	return if p1:GetAttribute("IsEye") == true then true else string.find(string.lower(p1.Name), "eye", 1, true) ~= nil
end

local function hueDistance(p1, p2) --[[ hueDistance | Line: 51 ]]
	local v1 = math.abs(p1 - p2)

	return math.min(v1, 1 - v1)
end

local function shouldColorPart(p1, p2) --[[ shouldColorPart | Line: 56 ]]
	local v1, v2, v3 = p1:ToHSV()
	local v4, v5, v6 = p2:ToHSV()

	if v5 < 0.16 then
		if v2 >= 0.16 then
			return false
		end

		if v6 < 0.08 then
			return v3 <= 0.08
		end

		return math.abs(v3 - v6) <= 0.18
	end

	if v2 < 0.16 then
		return false
	end

	local v9 = math.abs(v1 - v4)

	if math.min(v9, 1 - v9) > 0.08 then
		return false
	end

	local v10 = v3 / math.max(v6, 0.001)

	return if v10 >= 0.08 then v10 <= 1.6 else false
end

local function getPartVariance(p1, p2) --[[ getPartVariance | Line: 80 ]]
	return Random.new(p1 + 7919 + p2):NextNumber(0.8333333333333334, 1.2)
end

local function shouldApplyEyeColor(p1) --[[ shouldApplyEyeColor | Line: 85 ]]
	return Random.new(p1):NextNumber() < 0.5
end

local function recolorPart(p1, p2, p3, p4, p5) --[[ recolorPart | Line: 90 ]]
	local _, _2, v1 = p1.Color:ToHSV()
	local _3, _4, v2 = p2:ToHSV()
	local v3, v4, v5 = p3:ToHSV()
	local v6 = if v2 < 0.08 then v5 else v5 * (v1 / math.max(v2, 0.001))

	p1.Color = Color3.fromHSV(v3, v4, (math.clamp(v6 * Random.new(p4 + 7919 + p5):NextNumber(0.8333333333333334, 1.2), 0, 1)))

	if not p1:IsA("UnionOperation") then
		return
	end

	p1.UsePartColor = true
end

local function resolveColorIndex(p1, p2) --[[ resolveColorIndex | Line: 111 | Upvalues: Assets (copy), Constants (copy), Asserts (copy) ]]
	local v1 = Assets.Directory[p1]

	assert(if v1 == nil then false else true, (("Missing asset config for category %*"):format(p1)))

	if #v1.PossibleModelColors == 0 or p2 <= 0 then
		return nil
	end

	if Constants.IS_STUDIO then
		assert(v1.PossibleModelColors[p2], (("Asset %* missing PossibleModelColors[%*]"):format(p1, p2)))
	end

	local v7 = v1.PossibleModelColors[(p2 - 1) % #v1.PossibleModelColors + 1][1]

	Asserts.Color3(v7)

	return v7
end

function t2.RollEyeColorHex(p1) --[[ RollEyeColorHex | Line: 130 | Upvalues: v1 (copy) ]]
	assert(v1(p1), "Expected Random for RollEyeColorHex")

	local v2 = p1:NextNumber()
	local v3 = p1:NextNumber(0.35, 0.85)

	return Color3.fromHSV(v2, v3, (p1:NextNumber(0.35, 0.9))):ToHex()
end
function t2.RollColorSeed(p1) --[[ RollColorSeed | Line: 139 | Upvalues: v1 (copy) ]]
	assert(v1(p1), "Expected Random for RollColorSeed")

	return p1:NextInteger(1, 2147483647)
end
function t2.RollColorIndex(p1, p2) --[[ RollColorIndex | Line: 145 | Upvalues: Asserts (copy), v1 (copy), Assets (copy), LotteryCustom (copy) ]]
	Asserts.string(p1)
	assert(v1(p2), "Expected Random for RollColorIndex")

	local v2 = Assets.Directory[p1]

	assert(v2 ~= nil, (("Missing asset config for category %*"):format(p1)))

	local _, _2, _3, v5 = LotteryCustom(p2, v2.PossibleModelColors)

	return v5
end
function t2.RollFields(p1, p2) --[[ RollFields | Line: 155 | Upvalues: Asserts (copy), v1 (copy), t2 (copy) ]]
	Asserts.string(p1)
	assert(v1(p2), "Expected Random for RollFields")

	return {
		EyeColor = t2.RollEyeColorHex(p2),
		ColorSeed = t2.RollColorSeed(p2),
		ColorIndex = t2.RollColorIndex(p1, p2)
	}
end
function t2.ResolveFields(p1, p2, p3, p4) --[[ ResolveFields | Line: 166 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.string(p1)
	Asserts.optional.string(p2)
	Asserts.optional.number(p3)
	Asserts.optional.number(p4)

	local v1 = if p3 == nil then 1 else p3
	local t = {}

	t.EyeColor = if p2 == nil or p2 == "" then t2.RollEyeColorHex(Random.new(v1)) else p2
	t.ColorSeed = v1
	t.ColorIndex = if p4 == nil then 1 else p4

	return t
end
function t2.ResolveModelColor(p1, p2) --[[ ResolveModelColor | Line: 187 | Upvalues: Asserts (copy), resolveColorIndex (copy) ]]
	Asserts.string(p1)
	Asserts.number(p2)

	return resolveColorIndex(p1, p2)
end
function t2.Apply(p1, p2, p3, p4, p5) --[[ Apply | Line: 194 | Upvalues: Asserts (copy), Assets (copy), t2 (copy), shouldColorPart (copy), recolorPart (copy) ]]
	Asserts.Model(p1)
	Asserts.string(p2)
	Asserts.string(p3)
	Asserts.number(p4)
	Asserts.number(p5)

	local v1 = Assets.Directory[p2]

	assert(v1 ~= nil, (("Missing asset config for category %*"):format(p2)))

	local v4 = Color3.fromHex(p3)
	local v5 = t2.ResolveModelColor(p2, p5)
	local v6 = if Random.new(p4):NextNumber() < 0.5 then true else false
	local count = 0

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and not (v:GetAttribute("DontModify") or v.Transparency >= 1) then
			count = count + 1

			if if v:GetAttribute("IsEye") == true then true elseif string.find(string.lower(v.Name), "eye", 1, true) == nil then false else true then
				if v6 then
					v.Color = v4
				end

				continue
			end

			if v5 ~= nil then
				if v5 == Color3.fromRGB(255, 255, 255) and v1.AlbinosColorFullWhite then
					v.Color = v5

					continue
				end

				if shouldColorPart(v.Color, v1.BaseModelColor) then
					recolorPart(v, v1.BaseModelColor, v5, p4, count)
				end
			end
		end
	end
end

return t2