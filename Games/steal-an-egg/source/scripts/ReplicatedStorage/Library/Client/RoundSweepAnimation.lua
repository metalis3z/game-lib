-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local RoundSweepComponent = require(script.Parent.RoundSweepComponent)
local v1 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local t = {}

t.__index = t

local function getTargetPart(p1) --[[ getTargetPart | Line: 71 ]]
	local Character = p1.Character

	if not Character then
		return nil
	end

	local v1 = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")

	if v1 and v1:IsA("BasePart") then
		return v1
	end

	local PrimaryPart = Character.PrimaryPart

	if PrimaryPart and PrimaryPart:IsA("BasePart") then
		return PrimaryPart
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		return Humanoid.RootPart
	end

	return nil
end

local function computeTargetOffset(p1) --[[ computeTargetOffset | Line: 91 ]]
	local v1 = (p1 - 1) * 1.7278759594743864
	local v2 = p1 % 3 * 0.08 + 0.65
	local v3 = math.cos(v1) * v2

	return Vector3.new(v3, 0, math.sin(v1) * v2)
end

local function computeStartSoundPlaybackSpeed(p1) --[[ computeStartSoundPlaybackSpeed | Line: 97 ]]
	return (p1 - 1) * 0.04 + 1
end

local function cleanupState(p1, p2) --[[ cleanupState | Line: 101 | Upvalues: RoundSweepComponent (copy) ]]
	local v1 = p1._statesBySpawnId[p2]

	if v1 then
		p1._statesBySpawnId[p2] = nil
		RoundSweepComponent.Destroy(v1.component)
	end
end

local function tweenFov(p1, p2) --[[ tweenFov | Line: 111 | Upvalues: Workspace (copy), TweenService (copy), v1 (copy) ]]
	if p1._fovTarget == p2 then
		return
	end

	p1._fovTarget = p2

	if p1._fovTween then
		p1._fovTween:Cancel()
		p1._fovTween = nil
	end

	local CurrentCamera = Workspace.CurrentCamera

	if CurrentCamera then
		local v12 = TweenService:Create(CurrentCamera, v1, {
			FieldOfView = p2
		})

		p1._fovTween = v12
		v12.Completed:Connect(function() --[[ Line: 130 | Upvalues: p1 (copy), v12 (copy) ]]
			if p1._fovTween ~= v12 then
				return
			end

			p1._fovTween = nil
		end)
		v12:Play()
	end
end

function t.new(p1) --[[ new | Line: 139 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._resolveEntry = p1.ResolveEntry
	v2._setEntrySweepActive = p1.SetEntrySweepActive
	v2._onEntryCompleted = p1.OnEntryCompleted
	v2._statesBySpawnId = {}
	v2._moveParts = {}
	v2._moveCFrames = {}
	v2._fovTween = nil
	v2._fovTarget = nil
	v2._cameraEffectsEnabled = false
	v2._targetUserId = nil

	return v2
end
function t.Start(p1, p2, p3) --[[ Start | Line: 154 | Upvalues: RoundSweepComponent (copy), tweenFov (copy) ]]
	p1._cameraEffectsEnabled = p3.EnableCameraEffects
	p1._targetUserId = p3.TargetUserId

	local v1 = false

	for i, v in ipairs(p2) do
		local v2 = p1._resolveEntry(v.spawnId)

		if v2 then
			local spawnId = v.spawnId
			local v3 = p1._statesBySpawnId[spawnId]

			if v3 then
				p1._statesBySpawnId[spawnId] = nil
				RoundSweepComponent.Destroy(v3.component)
			end

			p1._setEntrySweepActive(v2, true)

			local v4 = (i - 1) * 1.7278759594743864
			local v5 = i % 3 * 0.08 + 0.65
			local v8 = RoundSweepComponent.Create(v2, (i - 1) * 0.12, Vector3.new(math.cos(v4) * v5, 0, math.sin(v4) * v5), (i - 1) * 0.04 + 1)

			if v8 then
				p1._statesBySpawnId[v.spawnId] = {
					entry = v2,
					sweepEntry = v,
					component = v8,
					playCompletionEffects = p3.PlayCompletionEffects
				}
				v1 = true
			end
		end
	end

	if v1 and p1._cameraEffectsEnabled then
		tweenFov(p1, 120)

		return
	end

	if not p1._cameraEffectsEnabled or next(p1._statesBySpawnId) ~= nil then
		return
	end

	tweenFov(p1, 70)
	p1._cameraEffectsEnabled = false
end
function t.CleanupSpawn(p1, p2) --[[ CleanupSpawn | Line: 195 | Upvalues: RoundSweepComponent (copy), tweenFov (copy) ]]
	local v1 = p1._statesBySpawnId[p2]

	if v1 then
		p1._statesBySpawnId[p2] = nil
		RoundSweepComponent.Destroy(v1.component)
	end

	if not p1._cameraEffectsEnabled or next(p1._statesBySpawnId) ~= nil then
		return
	end

	tweenFov(p1, 70)
	p1._cameraEffectsEnabled = false
end
function t.Step(p1, p2) --[[ Step | Line: 203 | Upvalues: Players (copy), getTargetPart (copy), RoundSweepComponent (copy), Workspace (copy), tweenFov (copy) ]]
	if next(p1._statesBySpawnId) == nil then
		return
	end

	local _targetUserId = p1._targetUserId

	if not _targetUserId then
		return
	end

	local v1 = Players:GetPlayerByUserId(_targetUserId)

	if not v1 then
		return
	end

	local v2 = getTargetPart(v1)

	if not v2 then
		return
	end

	local count = 0

	for k, v in pairs(p1._statesBySpawnId) do
		local v3 = p1._resolveEntry(k)

		if v3 and (v3.model == v.entry.model and v.component.model.Parent) then
			local v4 = RoundSweepComponent.Step(v.component, p2, v2.Position)

			if v4 then
				count = count + 1
				p1._moveParts[count] = v.component.root
				p1._moveCFrames[count] = v4
			end

			if v.component.completed then
				p1._onEntryCompleted(v.sweepEntry, v.playCompletionEffects)
				p1._statesBySpawnId[k] = nil
			end

			continue
		end

		local v5 = p1._statesBySpawnId[k]

		if v5 then
			p1._statesBySpawnId[k] = nil
			RoundSweepComponent.Destroy(v5.component)
		end
	end

	for i = count + 1, #p1._moveParts do
		p1._moveParts[i] = nil
	end

	for j = count + 1, #p1._moveCFrames do
		p1._moveCFrames[j] = nil
	end

	if count > 0 then
		Workspace:BulkMoveTo(p1._moveParts, p1._moveCFrames, Enum.BulkMoveMode.FireCFrameChanged)
	end

	if p1._cameraEffectsEnabled and next(p1._statesBySpawnId) == nil then
		tweenFov(p1, 70)
		p1._cameraEffectsEnabled = false
	end

	if next(p1._statesBySpawnId) ~= nil then
		return
	end

	p1._targetUserId = nil
end
function t.Destroy(p1) --[[ Destroy | Line: 266 | Upvalues: RoundSweepComponent (copy), tweenFov (copy) ]]
	for k in pairs(p1._statesBySpawnId) do
		local v1 = p1._statesBySpawnId[k]

		if v1 then
			p1._statesBySpawnId[k] = nil
			RoundSweepComponent.Destroy(v1.component)
		end
	end

	if p1._cameraEffectsEnabled then
		tweenFov(p1, 70)
		p1._cameraEffectsEnabled = false
	end

	p1._targetUserId = nil
end

return t