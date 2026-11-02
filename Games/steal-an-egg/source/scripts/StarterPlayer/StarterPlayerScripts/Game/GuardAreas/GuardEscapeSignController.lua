-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Areas = require(ReplicatedStorage.Directory.Areas)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Guards = require(ReplicatedStorage.Directory.Guards)
local GuardChasePolicy = require(ReplicatedStorage.Library.Modules.GuardAreas.GuardChasePolicy)
local GuardEscapePrediction = require(ReplicatedStorage.Library.Modules.GuardAreas.GuardEscapePrediction)
local ResolveGuardSpeedRequirement = require(ReplicatedStorage.Library.Functions.ResolveGuardSpeedRequirement)

require(script.Parent.Parent.Parent.GUI.GuardAreas.RequiredSpeedSign)

local SpeedPowerProjection = require(ReplicatedStorage.Library.Client.SpeedPowerProjection)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local t = {}

local function resolvePlayerWalkSpeed(speedPower)
	local trailMultiplier = math.max(1, tonumber(LocalPlayer:GetAttribute("TrailSpeedMultiplier")) or 1)
	return TreadmillUtil.SpeedPowerToWalkSpeed(speedPower) * trailMultiplier
end

t.__index = t
t.__class = "GuardEscapeSignController"

local SeparationLine = Workspace.__OBJECTS.Areas.SeparationLine

assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
function t.new(p1, p2, p3) --[[ new | Line: 52 | Upvalues: Asserts (copy), Areas (copy), Guards (copy), t (copy), SeparationLine (copy), TreadmillUtil (copy), SpeedPowerProjection (copy), GuardChasePolicy (copy), GuardEscapePrediction (copy), Trove (copy), ResolveGuardSpeedRequirement (copy) ]]
	Asserts.Model(p1)
	Asserts.Vector3(p2)
	Asserts.table(p3)

	local v2 = Guards.Directory[Areas.Directory[p1.Name].GuardId]
	local Bounds = p1.Bounds
	local ClosestExitPoint = p1.ClosestExitPoint
	local v3 = Bounds:IsA("BasePart")

	assert(v3, (("%*.Bounds must be a BasePart"):format((p1:GetFullName()))))

	local v5 = ClosestExitPoint:IsA("BasePart")

	assert(v5, (("%*.ClosestExitPoint must be a BasePart"):format((p1:GetFullName()))))

	local v8 = setmetatable({}, t)
	local v9 = -SeparationLine.CFrame.LookVector

	v8._playerWalkSpeed = resolvePlayerWalkSpeed(SpeedPowerProjection.GetSpeedPower())
	v8._guardWalkSpeed = v2.WalkSpeed
	v8._flatRadius = v2.FlatRadius
	v8._guardHitDistance = GuardChasePolicy.ResolveHitDistance(v2.HitDistance)
	v8._exitDistance = GuardEscapePrediction.ResolveExitDistance(Bounds.CFrame, Bounds.Size, ClosestExitPoint.Position, v9)

	local t2 = {
		BaseGuardWalkSpeed = v8._guardWalkSpeed,
		ExitDirection = v9,
		ExitDistance = v8._exitDistance,
		FlatRadius = v8._flatRadius,
		GuardStartPosition = p2,
		HitDistance = v8._guardHitDistance,
		PlayerStartPosition = ClosestExitPoint.Position
	}

	v8._minimumEscapeWalkSpeed = GuardEscapePrediction.ResolvePlayerWalkSpeedRequirement(t2, 1)
	v8._requiredSpeedSign = p3
	v8._trove = Trove.new()
	v8._requiredSpeedSign:SetSpeedPowerRequirement(ResolveGuardSpeedRequirement(t2))
	v8._trove:Add(SpeedPowerProjection.Changed:Connect(function(p1)
		v8._playerWalkSpeed = resolvePlayerWalkSpeed(p1)
		v8:_render()
	end))
	v8._trove:Add(LocalPlayer:GetAttributeChangedSignal("TrailSpeedMultiplier"):Connect(function()
		v8._playerWalkSpeed = resolvePlayerWalkSpeed(SpeedPowerProjection.GetSpeedPower())
		v8:_render()
	end))
	v8:_render()

	return v8
end
function t._render(p1) --[[ _render | Line: 100 | Upvalues: GuardEscapePrediction (copy) ]]
	p1._requiredSpeedSign:SetSlowdownTolerance((GuardEscapePrediction.ResolveSlowdownTolerance(p1._minimumEscapeWalkSpeed, p1._playerWalkSpeed)))
end
function t.Destroy(p1) --[[ Destroy | Line: 110 ]]
	p1._trove:Destroy()
end

return t