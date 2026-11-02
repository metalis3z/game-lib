-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Asserts = require(script.Parent.Parent.Parent.Asserts)
local TutorialBeam = require(script.Parent.TutorialBeam)
local Trove = require(script.Parent.Parent.Parent.Modules.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local t = {}

local function getRootPart(p1) --[[ getRootPart | Line: 44 ]]
	local Character = p1.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart
	end

	return nil
end

local function resolveNearestTarget(p1) --[[ resolveNearestTarget | Line: 58 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1

	if Character then
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart else nil
	else
		v1 = nil
	end

	if not v1 then
		return nil
	end

	local v2 = nil
	local v3 = nil

	for i, v in ipairs(p1._getCandidates()) do
		local v4

		if v ~= LocalPlayer then
			local Character2 = v.Character

			if Character2 then
				local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart")

				v4 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart else nil
			else
				v4 = nil
			end

			if v4 then
				local Magnitude = (v4.Position - v1.Position).Magnitude

				if v2 == nil or Magnitude < v2 then
					v2 = Magnitude
					v3 = v4
				end
			end
		end
	end

	return v3
end

local function updateBeam(p1) --[[ updateBeam | Line: 82 | Upvalues: resolveNearestTarget (copy), TutorialBeam (copy) ]]
	local v1 = resolveNearestTarget(p1)
	local isNot_currentTarget = v1 ~= p1._currentTarget

	if isNot_currentTarget then
		p1._currentTarget = v1

		local _onTargetChanged = p1._onTargetChanged

		if _onTargetChanged then
			_onTargetChanged(v1)
		end
	end

	if v1 then
		local _beamState = p1._beamState

		if not _beamState then
			p1._beamState = TutorialBeam.Create(v1, p1._beamOptions)

			return
		end

		if not isNot_currentTarget then
			return
		end

		TutorialBeam.UpdateTarget(_beamState, v1)
	else
		local _beamState = p1._beamState

		if not _beamState then
			return
		end

		TutorialBeam.Destroy(_beamState)
		p1._beamState = nil
	end
end

function t.Create(p1) --[[ Create | Line: 114 | Upvalues: Asserts (copy), Trove (copy), RunService (copy), updateBeam (copy) ]]
	Asserts.table(p1)
	assert(type(p1.GetCandidates) == "function", "NearestPlayerBeam requires a GetCandidates function")

	local v2 = p1.UpdateInterval or 0.16666666666666666

	assert(v2 > 0, "NearestPlayerBeam update interval must be positive")

	local v4 = Trove.new()
	local t = {
		_beamState = nil,
		_currentTarget = nil,
		_trove = v4,
		_beamOptions = p1.Beam,
		_getCandidates = p1.GetCandidates,
		_updateInterval = v2,
		_elapsed = v2,
		_onTargetChanged = p1.OnTargetChanged
	}

	v4:Connect(RunService.Heartbeat, function(p1) --[[ Line: 133 | Upvalues: t (copy), updateBeam (ref) ]]
		local v1 = t

		v1._elapsed = v1._elapsed + p1

		if not (t._elapsed < t._updateInterval) then
			t._elapsed = 0
			updateBeam(t)
		end
	end)
	updateBeam(t)

	return t
end
function t.Destroy(p1) --[[ Destroy | Line: 147 | Upvalues: Asserts (copy), TutorialBeam (copy) ]]
	Asserts.table(p1)

	local _beamState = p1._beamState

	if _beamState then
		TutorialBeam.Destroy(_beamState)
		p1._beamState = nil
	end

	p1._currentTarget = nil

	local _onTargetChanged = p1._onTargetChanged

	if _onTargetChanged then
		_onTargetChanged(nil)
	end

	p1._trove:Destroy()
end

return t