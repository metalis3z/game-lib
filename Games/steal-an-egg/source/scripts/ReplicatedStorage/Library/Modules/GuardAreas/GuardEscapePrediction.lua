-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)

require(script.Parent.Types.Interface)

local t = {}

local function resolveHorizontalDirection(p1) --[[ resolveHorizontalDirection | Line: 24 | Upvalues: Asserts (copy) ]]
	local v1 = Vector3.new(p1.X, 0, p1.Z)

	Asserts.cond(v1.Magnitude > 1e-6)

	return v1.Unit
end

local function resolveAtSpeed(p1, p2) --[[ resolveAtSpeed | Line: 30 | Upvalues: GuardChasePolicy (copy), Asserts (copy) ]]
	if p2 == 0 then
		return {
			ExitTime = (1 / 0),
			Outcome = "Caught",
			CatchTime = GuardChasePolicy.GetWakingDuration()
		}
	end

	local v1 = p1.ExitDistance / p2
	local v2 = GuardChasePolicy.GetWakingDuration()

	if v1 <= v2 then
		return {
			CatchTime = nil,
			Outcome = "EscapedSafely",
			ExitTime = v1
		}
	end

	local ExitDirection = p1.ExitDirection
	local v3 = Vector3.new(ExitDirection.X, 0, ExitDirection.Z)

	Asserts.cond(v3.Magnitude > 1e-6)

	local v5 = (p1.PlayerStartPosition - p1.GuardStartPosition):Dot(v3.Unit) + p2 * v2

	if v5 <= p1.HitDistance then
		return {
			Outcome = "Caught",
			CatchTime = v2,
			ExitTime = v1
		}
	end

	local v6 = GuardChasePolicy.ResolveCatchDuration(p1.BaseGuardWalkSpeed, p1.FlatRadius, p1.HitDistance, v5, p2)
	local v7 = if v6 == nil then nil else v2 + v6
	local t = {
		CatchTime = v7,
		ExitTime = v1
	}

	t.Outcome = if if v7 == nil then false elseif v7 < v1 then true else false then "Caught" else "EscapedSafely"

	return t
end

function t.ResolveExitDistance(p1, p2, p3, p4) --[[ ResolveExitDistance | Line: 85 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p1)
	Asserts.Vector3(p2)
	Asserts.Vector3(p3)
	Asserts.Vector3(p4)

	local v1 = Vector3.new(p4.X, 0, p4.Z)

	Asserts.cond(v1.Magnitude > 1e-6)

	local v3 = p1:PointToObjectSpace(p3)
	local v4 = p1:VectorToObjectSpace(v1.Unit)
	local v5 = p2 * 0.5

	Asserts.cond(math.abs(v3.X) <= v5.X + 1e-6)
	Asserts.cond(if math.abs(v3.Z) <= v5.Z + 1e-6 then true else false)

	local v12 = math.min(if math.abs(v4.X) > 1e-6 then ((if v4.X > 0 then v5.X else -v5.X) - v3.X) / v4.X else (1 / 0), if math.abs(v4.Z) > 1e-6 then ((if v4.Z > 0 then v5.Z else -v5.Z) - v3.Z) / v4.Z else (1 / 0))

	Asserts.cond(if v12 >= 0 then if v12 < (1 / 0) then true else false else false)

	return v12
end
function t.ResolvePlayerWalkSpeedRequirement(p1, p2) --[[ ResolvePlayerWalkSpeedRequirement | Line: 121 | Upvalues: Asserts (copy), GuardChasePolicy (copy), resolveAtSpeed (copy) ]]
	Asserts.table(p1)
	Asserts.number(p2)
	Asserts.number(p1.BaseGuardWalkSpeed)
	Asserts.Vector3(p1.ExitDirection)
	Asserts.number(p1.ExitDistance)
	Asserts.number(p1.FlatRadius)
	Asserts.Vector3(p1.GuardStartPosition)
	Asserts.number(p1.HitDistance)
	Asserts.Vector3(p1.PlayerStartPosition)
	Asserts.cond(p1.BaseGuardWalkSpeed > 0)
	Asserts.cond(if p1.ExitDistance >= 0 then true else false)
	Asserts.cond(if p1.FlatRadius > 0 then true else false)
	Asserts.cond(if p1.HitDistance > 0 then true else false)
	Asserts.cond(if p2 > 0 then if p2 <= 1 then true else false else false)

	if p1.ExitDistance == 0 then
		return 0
	end

	local v7 = p1.ExitDistance / GuardChasePolicy.GetWakingDuration() / p2
	local v8 = 0

	for i = 1, 48 do
		local v9 = (v8 + v7) * 0.5

		if resolveAtSpeed(p1, v9 * p2).Outcome == "Caught" then
			v8 = v9

			continue
		end

		v7 = v9
	end

	return v7
end
function t.ResolveGreenPlayerWalkSpeedRequirement(p1) --[[ ResolveGreenPlayerWalkSpeedRequirement | Line: 159 | Upvalues: t (copy) ]]
	return t.ResolvePlayerWalkSpeedRequirement(p1, 0.6)
end
function t.ResolveSlowdownTolerance(p1, p2) --[[ ResolveSlowdownTolerance | Line: 165 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	Asserts.cond(p1 >= 0)
	Asserts.cond(if p2 >= 0 then true else false)

	if p1 == 0 then
		return 1
	end

	if p2 == 0 then
		return -1
	end

	return 1 - p1 / p2
end
function t.Resolve(p1) --[[ Resolve | Line: 180 | Upvalues: Asserts (copy), resolveAtSpeed (copy) ]]
	Asserts.table(p1)
	Asserts.number(p1.BaseGuardWalkSpeed)
	Asserts.Vector3(p1.ExitDirection)
	Asserts.number(p1.ExitDistance)
	Asserts.number(p1.FlatRadius)
	Asserts.Vector3(p1.GuardStartPosition)
	Asserts.number(p1.HitDistance)
	Asserts.number(p1.PlayerWalkSpeed)
	Asserts.Vector3(p1.PlayerStartPosition)
	Asserts.cond(p1.BaseGuardWalkSpeed > 0)
	Asserts.cond(p1.ExitDistance >= 0)
	Asserts.cond(p1.FlatRadius > 0)
	Asserts.cond(p1.HitDistance > 0)
	Asserts.cond(p1.PlayerWalkSpeed >= 0)

	local v6 = resolveAtSpeed(p1, p1.PlayerWalkSpeed)

	if v6.Outcome == "Caught" then
		return v6
	end

	local v7 = resolveAtSpeed(p1, p1.PlayerWalkSpeed * 0.6)
	local t = {
		CatchTime = v6.CatchTime,
		ExitTime = v6.ExitTime
	}

	t.Outcome = if v7.Outcome == "Caught" then "EscapedAtRisk" else "EscapedSafely"

	return t
end

return t