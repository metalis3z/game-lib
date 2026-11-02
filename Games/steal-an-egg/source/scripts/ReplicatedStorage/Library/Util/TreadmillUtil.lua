-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)

local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Trails = require(ReplicatedStorage.Directory.Trails)
local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
local t = {
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096
}
local t2 = {
	DEFAULT_BASE_SPEED_POWER = 10,
	DEFAULT_BASE_SPEED_POWER_PER_STEP = 1,
	DEFAULT_SPEED_STEP_MULTIPLIER = 1,
	TEMPORARY_SPEED_BOOST_MULTIPLIER = 2,
	TREADMILL_SPEED_GAIN_INTERVAL = 1,
	MAX_WALK_SPEED = 300,
	MAX_SPEED_BOOST_TIER_INDEX = #t
}

local function resolveCurveLevelFromCurveProgress(p1) --[[ resolveCurveLevelFromCurveProgress | Line: 52 ]]
	if p1 <= 0 then
		return 0
	end

	local v1 = p1 * 0.1499999999999999 / 100 + 1

	if v1 <= 1 then
		return 0
	end

	return math.log(v1) / 0.13976194237515863
end

local function resolveReferenceWalkSpeed(p1) --[[ resolveReferenceWalkSpeed | Line: 65 ]]
	if p1 <= 0 then
		return 10
	end

	return math.min(p1 * 2 + 10, 300)
end

local function resolveCurveProgress(p1) --[[ resolveCurveProgress | Line: 76 ]]
	return math.max(p1 - 10, 0)
end

local function resolveWalkSpeed(p1) --[[ resolveWalkSpeed | Line: 80 ]]
	if p1 <= 0 then
		return 10
	end

	local v1

	if p1 <= 0 then
		v1 = 0
	else
		local v2 = p1 * 0.1499999999999999 / 100 + 1

		v1 = if v2 <= 1 then 0 else math.log(v2) / 0.13976194237515863
	end

	if v1 <= 0 then
		return 10
	end

	return math.min(v1 * 2 + 10, 300)
end

local function remapProgressionWalkSpeedToAppliedWalkSpeed(p1) --[[ remapProgressionWalkSpeedToAppliedWalkSpeed | Line: 89 | Upvalues: BASE_WALK_SPEED (copy) ]]
	return BASE_WALK_SPEED + math.clamp((p1 - 10) / 290, 0, 1) * (300 - BASE_WALK_SPEED)
end

local function remapAppliedWalkSpeedToProgressionWalkSpeed(p1) --[[ remapAppliedWalkSpeedToProgressionWalkSpeed | Line: 101 | Upvalues: BASE_WALK_SPEED (copy) ]]
	return math.clamp((p1 - BASE_WALK_SPEED) / (300 - BASE_WALK_SPEED), 0, 1) * 290 + 10
end

local function formatDurationProductLabel(p1, p2) --[[ formatDurationProductLabel | Line: 113 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)
	Asserts.boolean(p2)

	local v2 = math.max(math.floor(p1), 0) // 60
	local v3 = if v2 == 1 then "Minute" else "Minutes"
	local v4

	if v2 >= 60 and v2 % 60 == 0 then
		v4 = v2 // 60
		v3 = if v4 == 1 then "Hour" else "Hours"
	else
		v4 = v2
	end

	return ("%* %*"):format(v4, if p2 then string.upper(v3) else v3)
end

function t2.NormalizeSpeedPower(p1) --[[ NormalizeSpeedPower | Line: 133 | Upvalues: t2 (copy), Asserts (copy) ]]
	if p1 == nil then
		return t2.DEFAULT_BASE_SPEED_POWER
	end

	Asserts.number(p1)

	return p1
end
function t2.SpeedPowerToWalkSpeed(p1) --[[ SpeedPowerToWalkSpeed | Line: 144 | Upvalues: t2 (copy), BASE_WALK_SPEED (copy) ]]
	return BASE_WALK_SPEED + math.clamp((t2.SpeedPowerToProgressionWalkSpeed(p1) - 10) / 290, 0, 1) * (300 - BASE_WALK_SPEED)
end
function t2.SpeedPowerToProgressionWalkSpeed(p1) --[[ SpeedPowerToProgressionWalkSpeed | Line: 149 | Upvalues: t2 (copy) ]]
	local v2 = math.max(t2.NormalizeSpeedPower(p1) - 10, 0)

	if v2 <= 0 then
		return 10
	end

	local v3

	if v2 <= 0 then
		v3 = 0
	else
		local v4 = v2 * 0.1499999999999999 / 100 + 1

		v3 = if v4 <= 1 then 0 else math.log(v4) / 0.13976194237515863
	end

	if v3 <= 0 then
		return 10
	end

	return math.min(v3 * 2 + 10, 300)
end
function t2.WalkSpeedToSpeedPower(p1) --[[ WalkSpeedToSpeedPower | Line: 155 | Upvalues: Asserts (copy), BASE_WALK_SPEED (copy) ]]
	Asserts.number(p1)

	return (1.15 ^ (math.max(math.clamp((p1 - BASE_WALK_SPEED) / (300 - BASE_WALK_SPEED), 0, 1) * 290 + 10 - 10, 0) / 2) - 1) * 100 / 0.1499999999999999 + 10
end
function t2.RoundSpeedPowerRequirement(p1) --[[ RoundSpeedPowerRequirement | Line: 165 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	if p1 <= 0 then
		return 0
	end

	local v2 = 10 ^ math.floor((math.log10(p1)))
	local v3 = p1 / v2
	local v4 = if v3 < 2 then 0.1 elseif v3 < 5 then 0.5 else 1

	return math.ceil(v3 / v4) * v4 * v2
end
function t2.FormatSpeedPower(p1) --[[ FormatSpeedPower | Line: 178 | Upvalues: Simple (copy), t2 (copy) ]]
	return Simple.FormatCompact(t2.NormalizeSpeedPower(p1), ".#")
end
function t2.FormatSpeedPowerPerStep(p1) --[[ FormatSpeedPowerPerStep | Line: 182 | Upvalues: Asserts (copy), Simple (copy) ]]
	Asserts.number(p1)

	return ("+%*/step"):format((Simple.FormatCompact(p1, ".#")))
end
function t2.ResolveEquippedTrailWalkSpeedMultiplier(p1)
	if p1 == nil or typeof(p1.TrailInventory) ~= "table" then
		return 1
	end

	local equippedTrail = p1.EquippedTrail
	if typeof(equippedTrail) ~= "string" or p1.TrailInventory[equippedTrail] ~= true then
		return 1
	end

	if Trails.Types.TrailNameExists(equippedTrail) then
		local multiplier = tonumber(Trails.Directory[equippedTrail].SpeedMultiplier) or 1
		if multiplier == multiplier and multiplier < math.huge then
			return math.max(multiplier, 1)
		end
	end

	return 1
end
function t2.ResolveFinalWalkSpeed(p1, p2) --[[ ResolveFinalWalkSpeed | Line: 205 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.optional.number(p1)
	Asserts.optional.number(p2)

	local v1 = p2 or 1

	Asserts.cond(if v1 > 0 then if v1 <= 1 then true else false else false)

	return t2.SpeedPowerToWalkSpeed(p1) * v1
end
function t2.ResolveEffectiveSpeedPower(p1, p2) --[[ ResolveEffectiveSpeedPower | Line: 214 | Upvalues: t2 (copy) ]]
	return t2.WalkSpeedToSpeedPower(t2.ResolveFinalWalkSpeed(p1, p2))
end
function t2.FormatSpeedMultiplierValue(p1) --[[ FormatSpeedMultiplierValue | Line: 218 | Upvalues: Asserts (copy), Simple (copy) ]]
	Asserts.number(p1)

	return ("x%*"):format((Simple.FormatCompact(p1, ".#")))
end
function t2.FormatSpeedMultiplier(p1) --[[ FormatSpeedMultiplier | Line: 223 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.number(p1)

	return ("%* Speed"):format((t2.FormatSpeedMultiplierValue(p1)))
end
function t2.FormatTemporarySpeedBoostProductDuration(p1) --[[ FormatTemporarySpeedBoostProductDuration | Line: 228 | Upvalues: formatDurationProductLabel (copy) ]]
	return formatDurationProductLabel(p1, true)
end
function t2.FormatTreadmillSpeedEquivalentDuration(p1) --[[ FormatTreadmillSpeedEquivalentDuration | Line: 232 | Upvalues: formatDurationProductLabel (copy) ]]
	return formatDurationProductLabel(p1, false)
end
function t2.GetSpeedBoostMultiplierForTierIndex(p1) --[[ GetSpeedBoostMultiplierForTierIndex | Line: 236 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)

	return t[p1] or 1
end
function t2.ResolveSpeedBoostTierIndex(p1) --[[ ResolveSpeedBoostTierIndex | Line: 242 | Upvalues: t2 (copy) ]]
	if p1 == nil then
		return 0
	end

	return math.clamp(math.floor(p1.SpeedBoostTierIndex), 0, t2.MAX_SPEED_BOOST_TIER_INDEX)
end
function t2.ResolveSpeedBoostSpeedStepMultiplier(p1) --[[ ResolveSpeedBoostSpeedStepMultiplier | Line: 250 | Upvalues: t2 (copy) ]]
	return t2.GetSpeedBoostMultiplierForTierIndex(t2.ResolveSpeedBoostTierIndex(p1))
end
function t2.ResolveTemporarySpeedBoostRemainingSeconds(p1, p2) --[[ ResolveTemporarySpeedBoostRemainingSeconds | Line: 254 | Upvalues: Asserts (copy) ]]
	Asserts.optional.number(p2)

	if p1 == nil then
		return 0
	end

	local sum = math.max(p1.TemporarySpeedBoostRemainingSeconds, 0)
	local TemporarySpeedBoostActiveStartedAt = p1.TemporarySpeedBoostActiveStartedAt

	if TemporarySpeedBoostActiveStartedAt > 0 then
		sum = sum - math.max((if p2 == nil then workspace:GetServerTimeNow() else p2) - TemporarySpeedBoostActiveStartedAt, 0)
	end

	return math.max(sum, 0)
end
function t2.ResolveTemporarySpeedBoostSpeedStepMultiplier(p1, p2) --[[ ResolveTemporarySpeedBoostSpeedStepMultiplier | Line: 271 | Upvalues: t2 (copy) ]]
	if t2.ResolveTemporarySpeedBoostRemainingSeconds(p1, p2) <= 0 then
		return 1
	end

	return 2
end
function t2.ResolveAdditiveSpeedStepMultiplier(p1, p2) --[[ ResolveAdditiveSpeedStepMultiplier | Line: 279 | Upvalues: Asserts (copy) ]]
	Asserts.optional.number(p1)
	Asserts.optional.number(p2)

	return math.max((if p1 == nil then 1 else p1) - 1, 0) + 1 + math.max((if p2 == nil then 1 else p2) - 1, 0)
end
function t2.ResolveTreadmillSpeedPowerDelta(p1, p2, p3, p4) --[[ ResolveTreadmillSpeedPowerDelta | Line: 298 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	Asserts.optional.number(p3)
	Asserts.optional.number(p4)

	local v1 = if p4 == nil then 1 else math.max(p4, 0)
	local v2 = t2.ResolveAdditiveSpeedStepMultiplier(p2, p3)

	return math.max(p1, 0) * v2 * v1
end
function t2.ResolveSpeedPowerPerStep(p1, p2, p3) --[[ ResolveSpeedPowerPerStep | Line: 315 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.optional.number(p2)
	Asserts.optional.number(p3)

	local v1 = t2.ResolveSpeedBoostSpeedStepMultiplier(p1)
	local v2 = t2.ResolveTemporarySpeedBoostSpeedStepMultiplier(p1, p3)
	local v3 = t2.ResolveTreadmillSpeedPowerDelta(1, p2 or 1, nil)

	return v3 * t2.ResolveAdditiveSpeedStepMultiplier(v1, v2)
end
function t2.ResolveSpeedPowerPerSecond(p1, p2, p3) --[[ ResolveSpeedPowerPerSecond | Line: 337 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.table(p1)
	Asserts.number(p2)
	Asserts.optional.number(p3)

	local v1 = t2.ResolveSpeedPowerPerStep(p1, p2, p3)

	return v1 / t2.ResolveWalkSpeedPowerAwardInterval((t2.SpeedPowerToProgressionWalkSpeed(p1.SpeedPower)))
end
function t2.ResolveTreadmillEquivalentSpeedPower(p1, p2, p3, p4) --[[ ResolveTreadmillEquivalentSpeedPower | Line: 348 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.table(p1)
	Asserts.number(p2)
	Asserts.number(p3)
	Asserts.optional.number(p4)
	assert(p3 > 0, "Treadmill equivalent duration must be positive")

	return t2.ResolveSpeedPowerPerSecond(p1, p2, p4) * p3
end
function t2.ResolveNextTreadmillSpeedGainAt(p1) --[[ ResolveNextTreadmillSpeedGainAt | Line: 363 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return p1 + 1
end
function t2.ResolveElapsedTreadmillSpeedGainTicks(p1, p2) --[[ ResolveElapsedTreadmillSpeedGainTicks | Line: 368 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)

	if p2 < p1 then
		return 0
	end

	return math.floor((p2 - p1) / 1) + 1
end
function t2.ResolveWalkSpeedPowerAwardInterval(p1) --[[ ResolveWalkSpeedPowerAwardInterval | Line: 379 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return 0.25 - math.clamp((p1 - 10) / 90, 0, 1) * 0.15
end

local function findOptionalPresentationPart(p1, p2) --[[ findOptionalPresentationPart | Line: 390 ]]
	local v1 = p1:FindFirstChild(p2, true)

	if v1 == nil then
		return nil
	end

	assert(v1:IsA("BasePart"), (("Treadmill \"%*\" %* must be a BasePart"):format(p1.Name, p2)))

	return v1
end

function t2.FindVideoFeedScreenPart(p1) --[[ FindVideoFeedScreenPart | Line: 399 | Upvalues: Asserts (copy) ]]
	Asserts.Tool(p1)

	local VideoFeedScreen = p1:FindFirstChild("VideoFeedScreen", true)

	if VideoFeedScreen == nil then
		return nil
	end

	assert(VideoFeedScreen:IsA("BasePart"), (("Treadmill \"%*\" VideoFeedScreen must be a BasePart"):format(p1.Name)))

	return VideoFeedScreen
end
function t2.FindVideoPresentationParts(p1) --[[ FindVideoPresentationParts | Line: 404 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.Tool(p1)

	local v1 = t2.FindVideoFeedScreenPart(p1)
	local SwapLeft = p1:FindFirstChild("SwapLeft", true)
	local v2

	if SwapLeft == nil then
		v2 = nil
	else
		local v3 = SwapLeft:IsA("BasePart")

		assert(v3, (("Treadmill \"%*\" SwapLeft must be a BasePart"):format(p1.Name)))
		v2 = SwapLeft
	end

	local SwapRight = p1:FindFirstChild("SwapRight", true)
	local v5

	if SwapRight == nil then
		v5 = nil
	else
		local v6 = SwapRight:IsA("BasePart")

		assert(v6, (("Treadmill \"%*\" SwapRight must be a BasePart"):format(p1.Name)))
		v5 = SwapRight
	end

	if v1 == nil or (v2 == nil or v5 == nil) then
		return nil, nil, nil
	end

	return v1, v2, v5
end
function t2.ResolveGroundedToolRootCFrameAtLocation(p1, p2) --[[ ResolveGroundedToolRootCFrameAtLocation | Line: 415 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Tool(p2)

	local Root = p2.Root

	assert(Root:IsA("BasePart"), (("Treadmill \"%*\" Root must be a BasePart"):format(p2.Name)))

	local BoundingBoxPart = p2.BoundingBoxPart

	assert(BoundingBoxPart:IsA("BasePart"), (("Treadmill \"%*\" BoundingBoxPart must be a BasePart"):format(p2.Name)))

	local v5 = Root.CFrame:PointToObjectSpace(BoundingBoxPart.CFrame.Position)
	local v8 = p1.Position + Vector3.new(0, BoundingBoxPart.Size.Y * 0.5 + (p2:GetAttribute("Offset") or 0), 0)

	return CFrame.new(v8) * p1.CFrame.Rotation * CFrame.new(-v5)
end

return t2