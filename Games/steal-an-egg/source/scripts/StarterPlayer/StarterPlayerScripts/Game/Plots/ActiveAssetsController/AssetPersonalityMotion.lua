-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Directory.Assets.Types.Personality)

local Player = require(ReplicatedStorage.Library.Player)
local AssetWanderArea = require(script.Parent.AssetWanderArea)
local t = {}

local function isolatedPointFromOwner(p1, p2, p3) --[[ isolatedPointFromOwner | Line: 22 | Upvalues: AssetWanderArea (copy) ]]
	local v1, v2 = AssetWanderArea.HalfExtents(p1)
	local v3 = p1.CFrame:PointToObjectSpace(p3)
	local v4 = if v3.X >= 0 then p2:NextNumber(-v1, 0) else p2:NextNumber(0, v1)

	return (p1.CFrame * CFrame.new(v4, 0, if v3.Z >= 0 then p2:NextNumber(-v2, 0) else p2:NextNumber(0, v2))).Position
end

function t.StepIdle(p1, p2, p3, p4, p5) --[[ StepIdle | Line: 35 ]]
	local v1 = math.max(p2 - p1, 0)
	local v2 = p3 + p1
	local v3

	if p5 == nil or not (v1 > 0) then
		v3 = p4
	else
		local v4 = v2 * p5.CyclesPerSecond * math.pi * 2
		local v5 = math.sin(v4) * p5.Amplitude

		v3 = p4 * CFrame.new(v5, 0, math.sin(v4 * 1.37 + 1.0471975511965976) * p5.Amplitude)
	end

	return v3, v1, v2, v1 <= 0
end
function t.ChooseDestination(p1, p2, p3, p4) --[[ ChooseDestination | Line: 55 | Upvalues: isolatedPointFromOwner (copy), AssetWanderArea (copy) ]]
	if p4 ~= nil and p2:NextNumber() < p3.IsolationPreference then
		return isolatedPointFromOwner(p1, p2, p4)
	end

	if p4 ~= nil and p2:NextNumber() < p3.NearOwnerPreference then
		return AssetWanderArea.ClampedPointToward(p1, p4)
	end

	return AssetWanderArea.RandomPoint(p1, p2)
end
function t.RandomOwnerOffset(p1, p2, p3) --[[ RandomOwnerOffset | Line: 71 ]]
	local v1 = p2:NextNumber(0, 6.283185307179586)

	return p1.CFrame:VectorToWorldSpace((Vector3.new(math.cos(v1) * p3, 0, math.sin(v1) * p3)))
end
function t.RollChance(p1, p2) --[[ RollChance | Line: 78 ]]
	if p2 <= 0 then
		return false
	end

	if p2 >= 1 then
		return true
	end

	return p1:NextNumber() <= p2
end
function t.RandomConfiguredText(p1, p2, p3, p4) --[[ RandomConfiguredText | Line: 89 ]]
	assert(if #p2 > 0 then true else false, (("Personality %* requires at least one %* text"):format(p3, p4)))

	return p2[p1:NextInteger(1, #p2)]
end
function t.OwnerRootPosition(p1) --[[ OwnerRootPosition | Line: 99 | Upvalues: Player (copy) ]]
	local v1 = Player.Optional.PrimaryPart(p1)

	if v1 == nil then
		return nil
	end

	return v1.Position
end
function t.DistanceFromPlayerToAreaCenter(p1, p2) --[[ DistanceFromPlayerToAreaCenter | Line: 104 | Upvalues: t (copy) ]]
	local v1 = t.OwnerRootPosition(p1)

	if v1 == nil then
		return nil
	end

	return (v1 - p2.Position).Magnitude
end
function t.ShouldStartAmbientJump(p1, p2, p3, p4) --[[ ShouldStartAmbientJump | Line: 109 ]]
	if p2 <= 0 or p4 then
		return false
	end

	return 1 - math.exp(-p2 * p3) >= p1:NextNumber()
end

return t