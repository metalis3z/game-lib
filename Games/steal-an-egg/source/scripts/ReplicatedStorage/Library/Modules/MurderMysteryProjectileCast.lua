-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local t = {}

local function buildDirection(p1) --[[ buildDirection | Line: 41 ]]
	local Magnitude = p1.Magnitude

	if Magnitude <= 0.00001 then
		return nil
	end

	return p1 / Magnitude
end

local function createNextCFrame(p1, p2, p3) --[[ createNextCFrame | Line: 50 ]]
	local v1 = p1.Position + p3

	return CFrame.lookAt(v1, v1 + p2)
end

local function computeDistanceAlongDirection(p1, p2, p3, p4) --[[ computeDistanceAlongDirection | Line: 55 ]]
	return math.clamp((p3 - p1):Dot(p2), 0, p4)
end

local function resolveCastHit(p1, p2, p3, p4, p5, p6, p7) --[[ resolveCastHit | Line: 64 ]]
	for i = 1, 16 do
		local v1 = workspace:Blockcast(p1, p2, p3, p4)

		if not v1 then
			break
		end

		local v2 = v1.Instance

		if not (v2 and v2:IsA("BasePart")) then
			return v1
		end

		if p6 and p6(v2, v1) then
			table.insert(p5, v2)
			p4.FilterDescendantsInstances = p5

			continue
		end

		if not p7 or p7(v2, v1) then
			return v1
		end

		table.insert(p5, v2)
		p4.FilterDescendantsInstances = p5
	end

	return nil
end

function t.Cast(p1) --[[ Cast | Line: 103 | Upvalues: RunService (copy), resolveCastHit (copy) ]]
	local Direction = p1.Direction
	local Magnitude = Direction.Magnitude
	local v1 = if Magnitude <= 0.00001 then nil else Direction / Magnitude

	if not v1 then
		return {
			DidImpact = false,
			ImpactResult = nil,
			ImpactType = nil,
			TraveledDistance = 0,
			EndCFrame = p1.StartCFrame
		}
	end

	if p1.Speed <= 0 or p1.MaxDistance <= 0 then
		return {
			DidImpact = false,
			ImpactResult = nil,
			ImpactType = nil,
			TraveledDistance = 0,
			EndCFrame = p1.StartCFrame
		}
	end

	local v2 = table.clone(p1.CastParams.FilterDescendantsInstances)
	local v3 = table.clone(v2)
	local v4 = table.clone(v2)
	local v5 = RaycastParams.new()

	v5.FilterType = p1.CastParams.FilterType
	v5.IgnoreWater = p1.CastParams.IgnoreWater
	v5.CollisionGroup = p1.CastParams.CollisionGroup
	v5.FilterDescendantsInstances = v3

	local v6 = RaycastParams.new()

	v6.FilterType = p1.CastParams.FilterType
	v6.IgnoreWater = p1.CastParams.IgnoreWater
	v6.CollisionGroup = p1.CastParams.CollisionGroup
	v6.FilterDescendantsInstances = v4

	local ShouldIgnoreHit = p1.ShouldIgnoreHit
	local ShouldStop = p1.ShouldStop
	local IsTargetHit = p1.IsTargetHit
	local OnStep = p1.OnStep
	local v7 = p1.StopHitboxSize or Vector3.new(0.15, 0.15, 0.15)
	local v8 = p1.TargetHitboxSize or p1.HitboxSize
	local StartCFrame = p1.StartCFrame
	local v9 = os.clock()
	local v10 = 0

	while v10 < p1.MaxDistance and not (ShouldStop and ShouldStop()) do
		local v11, v12
		local v13 = os.clock()
		local v17 = math.min(p1.Speed * math.max(v13 - v9, 0.004166666666666667), p1.MaxDistance - v10)

		if v17 <= 0 then
			RunService.Heartbeat:Wait()
			v9 = v13
		else
			local v18 = v1 * v17
			local v19 = resolveCastHit(StartCFrame, v7, v18, v5, v3, ShouldIgnoreHit, nil)
			local v20 = resolveCastHit(StartCFrame, v8, v18, v6, v4, ShouldIgnoreHit, IsTargetHit)

			if v19 or v20 then
				v11 = if v19 then math.clamp((v19.Position - StartCFrame.Position):Dot(v1), 0, v17) else (1 / 0)
				v12 = if v20 then math.clamp((v20.Position - StartCFrame.Position):Dot(v1), 0, v17) else (1 / 0)

				return {
					DidImpact = true,
					ImpactResult = if v12 <= v11 then v20 else v19,
					ImpactType = if v12 <= v11 then "Target" else "Stop",
					EndCFrame = StartCFrame,
					TraveledDistance = v10 + math.min(v11, v12)
				}
			end

			local v27 = StartCFrame.Position + v18
			local v28 = CFrame.lookAt(v27, v27 + v1)

			if OnStep then
				OnStep(StartCFrame, v28, v18, v10 + v17)
			end

			RunService.Heartbeat:Wait()
			StartCFrame, v9, v10 = v28, v13, v10 + v17
		end
	end

	return {
		DidImpact = false,
		ImpactResult = nil,
		ImpactType = nil,
		EndCFrame = StartCFrame,
		TraveledDistance = v10
	}
end
function t.GetDefaultStopHitboxSize() --[[ GetDefaultStopHitboxSize | Line: 236 ]]
	return Vector3.new(0.15, 0.15, 0.15)
end
function t.IsPlayerCharacterHit(p1) --[[ IsPlayerCharacterHit | Line: 240 | Upvalues: Players (copy) ]]
	local v1 = p1.Parent

	if not v1 then
		return false
	end

	local Humanoid = v1:FindFirstChildOfClass("Humanoid")

	if Humanoid and Humanoid.Parent then
		return Players:GetPlayerFromCharacter(Humanoid.Parent) ~= nil
	end

	local v3 = v1.Parent

	if not v3 then
		return false
	end

	local Humanoid2 = v3:FindFirstChildOfClass("Humanoid")

	if not (Humanoid2 and Humanoid2.Parent) then
		return false
	end

	return Players:GetPlayerFromCharacter(Humanoid2.Parent) ~= nil
end

return t