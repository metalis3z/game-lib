-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new(1029410295159813)
local Lighting = game:GetService("Lighting")
local Dependencies = script.Parent.Parent:WaitForChild("Dependencies")

require(script.Parent:WaitForChild("Bone"))

local Config = require(Dependencies:WaitForChild("Config"))
local DefaultObjectSettings = require(Dependencies:WaitForChild("DefaultObjectSettings"))
local Gizmo = require(Dependencies:WaitForChild("Gizmo"))
local Utilities = require(Dependencies:WaitForChild("Utilities"))

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG then
	Gizmo.Init()
end

local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG

local function SafeUnit(p1) --[[ SafeUnit | Line: 54 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function map(p1, p2, p3, p4, p5, p6) --[[ map | Line: 63 ]]
	local v1 = (p1 - p2) / (p3 - p2) * (p5 - p4) + p4

	if not p6 then
		return v1
	end

	if p4 < p5 then
		return if p4 < (if v1 < p5 then v1 else p5) then if v1 < p5 then v1 else p5 or p4 else p4
	end

	return if p5 < (if v1 < p4 then v1 else p4) then if v1 < p4 then v1 else p4 or p5 else p5
end

local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 178 | Upvalues: v1 (copy), t (copy), DefaultObjectSettings (copy) ]]
	local t2 = {
		UpdateRate = 0,
		InView = true,
		AccumulatedDelta = 0,
		Destroyed = false,
		IsSkippingUpdates = false,
		InWorkspace = false,
		Force = Vector3.new(0, 0, 0),
		ObjectMove = Vector3.new(0, 0, 0),
		ObjectVelocity = Vector3.new(0, 0, 0),
		ObjectAcceleration = Vector3.new(0, 0, 0),
		WindOffset = v1:NextNumber(0, 1000000)
	}

	t2.Root = if p1:IsA("Bone") and p1 then p1 else nil
	t2.RootPart = p2
	t2.RootPartSize = p2.Size
	t2.Bones = {}
	t2.Settings = {}
	t2.BoundingBoxCFrame = p2.CFrame
	t2.BoundingBoxSize = p2.Size
	t2.ObjectPreviousPosition = p2.Position

	local v3 = setmetatable(t2, t)

	v3.InWorkspace = p2:IsDescendantOf(workspace)
	v3.DestroyConnection = p2.AncestryChanged:ConnectParallel(function() --[[ Line: 206 | Upvalues: p2 (copy), v3 (copy) ]]
		if not p2:IsDescendantOf(game) then
			v3.Destroyed = true
		end

		v3.InWorkspace = p2:IsDescendantOf(workspace)
	end)
	v3.AttributeConnection = p2.AttributeChanged:ConnectParallel(function(p1) --[[ Line: 214 | Upvalues: v3 (copy), p2 (copy), DefaultObjectSettings (ref) ]]
		v3.Settings[p1] = p2:GetAttribute(p1) or DefaultObjectSettings[p1]
	end)

	return v3
end
function t.UpdateBoundingBox(p1) --[[ UpdateBoundingBox | Line: 225 ]]
	if not p1.InView then
		p1.BoundingBoxCFrame = p1.RootPart.CFrame
		p1.BoundingBoxSize = p1.RootPart.Size

		return
	end

	local v1 = Vector3.new(inf, inf, inf)
	local v2 = Vector3.new(-inf, -inf, -inf)

	for v3, v4 in p1.Bones do
		local v6 = v4.Position + (v4.Position - v4.LastPosition)
		local v7 = v1:Min(v6)

		v1, v2 = v7, v2:Max(v6)
	end

	p1.BoundingBoxCFrame = CFrame.new((v1 + v2) * 0.5)
	p1.BoundingBoxSize = p1.RootPartSize:Max(v2 - v1)
end
function t.UpdateThrottling(p1, p2) --[[ UpdateThrottling | Line: 268 ]]
	local Settings = p1.Settings
	local Magnitude = (p2 - workspace.CurrentCamera.CFrame.Position).Magnitude

	if Settings.ActivationDistance < Magnitude then
		p1.UpdateRate = 0

		return
	end

	local ThrottleDistance = Settings.ThrottleDistance
	local v1 = (Magnitude - ThrottleDistance) / (Settings.ActivationDistance - ThrottleDistance) * 1 + 0

	p1.UpdateRate = Settings.UpdateRate * (1 - (if (if v1 < 1 then v1 else 1) > 0 then if v1 < 1 then v1 else 1 else 0))
end
function t.PreUpdate(p1, p2) --[[ PreUpdate | Line: 292 ]]
	local Position = p1.RootPart.CFrame.Position
	local ObjectVelocity = p1.ObjectVelocity

	p1.ObjectMove = Position - p1.ObjectPreviousPosition
	p1.ObjectVelocity = p1.ObjectMove
	p1.ObjectAcceleration = ObjectVelocity - p1.ObjectVelocity
	p1.ObjectPreviousPosition = Position
	p1.RootPartSize = p1.RootPart.Size
	p1:UpdateThrottling(Position)
	p1:UpdateBoundingBox()

	for v1, v2 in p1.Bones do
		v2:PreUpdate(p1)
	end
end
function t.StepPhysics(p1, p2) --[[ StepPhysics | Line: 319 | Upvalues: Lighting (copy), DefaultObjectSettings (copy) ]]
	local Settings = p1.Settings
	local v1 = (Settings.Gravity + Settings.Force) * p2

	if Settings.MatchWorkspaceWind == true then
		local GlobalWind = workspace.GlobalWind

		Settings.WindDirection = if GlobalWind.Magnitude == 0 then Vector3.new(0, 0, 0) else GlobalWind.Unit
		Settings.WindSpeed = GlobalWind.Magnitude
	else
		local v3 = Lighting:GetAttribute("WindDirection") or DefaultObjectSettings.WindDirection
		local v4 = Lighting:GetAttribute("WindSpeed") or DefaultObjectSettings.WindSpeed

		Settings.WindDirection = if v3.Magnitude == 0 then Vector3.new(0, 0, 0) else v3.Unit
		Settings.WindSpeed = v4
	end

	Settings.WindStrength = Lighting:GetAttribute("WindStrength") or DefaultObjectSettings.WindStrength

	for v7, v8 in p1.Bones do
		v8:StepPhysics(p1, v1, p2)
	end
end
function t.Constrain(p1, p2, p3) --[[ Constrain | Line: 351 ]]
	for v1, v2 in p1.Bones do
		v2:Constrain(p1, p2, p3)
	end
end
function t.SkipUpdate(p1) --[[ SkipUpdate | Line: 363 ]]
	for v1, v2 in p1.Bones do
		v2:SkipUpdate()
	end

	p1.IsSkippingUpdates = true
end
function t.SolveTransform(p1, p2) --[[ SolveTransform | Line: 377 ]]
	for v1, v2 in p1.Bones do
		v2:SolveTransform(p1, p2)
	end

	p1.IsSkippingUpdates = false
end
function t.ApplyTransform(p1) --[[ ApplyTransform | Line: 391 ]]
	for v1, v2 in p1.Bones do
		v2:ApplyTransform(p1)
	end
end
function t.DrawDebug(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ DrawDebug | Line: 411 | Upvalues: Gizmo (copy) ]]
	local v1 = Color3.fromRGB(248, 168, 20)
	local v2 = Color3.fromRGB(76, 208, 223)
	local v3 = Color3.fromRGB(255, 89, 89)
	local v4 = Color3.new(255/255, 0/255, 0/255)
	local v5 = Color3.new(0/255, 255/255, 0/255)
	local v6 = Color3.new(0/255, 0/255, 255/255)

	if p9 then
		local v8 = p1.RootPart.Position + Vector3.new(0, p1.RootPart.Size.Y * 0.5 + 1, 0)

		Gizmo.SetStyle(v4, 0, true)
		Gizmo.Arrow:Draw(v8, v8 + p1.ObjectMove, 0.025, 0.1, 6)
		Gizmo.SetStyle(v5, 0, true)
		Gizmo.Arrow:Draw(v8, v8 + p1.ObjectVelocity, 0.025, 0.1, 6)
		Gizmo.SetStyle(v6, 0, true)
		Gizmo.Arrow:Draw(v8, v8 + p1.ObjectAcceleration, 0.025, 0.1, 6)
	end

	Gizmo.PushProperty("AlwaysOnTop", false)

	if p7 then
		Gizmo.PushProperty("Color3", v2)
		Gizmo.Box:Draw(p1.BoundingBoxCFrame, p1.BoundingBoxSize, true)
	end

	if p6 then
		Gizmo.PushProperty("Color3", v2)
		Gizmo.Box:Draw(p1.RootPart.CFrame, p1.RootPart.Size, true)
		Gizmo.SetStyle(v3, 0.75, false)
		Gizmo.VolumeBox:Draw(p1.RootPart.CFrame, p1.RootPart.Size)
		Gizmo.PushProperty("Transparency", 0)
	end

	for v9, v10 in p1.Bones do
		local Position = v10.Bone.TransformedWorldCFrame.Position
		local v11 = p1.Bones[v10.ParentIndex]

		v10:DrawDebug(p1, p2, p3, p4, p5, p8)

		if p3 and v9 ~= 1 then
			Gizmo.PushProperty("Color3", v1)
			Gizmo.Ray:Draw(v11.Bone.TransformedWorldCFrame.Position, Position)
		end
	end
end
function t.DrawOverlay(p1, p2) --[[ DrawOverlay | Line: 478 | Upvalues: Config (copy) ]]
	if Config.DEBUG_OVERLAY_TREE_INFO or Config.DEBUG_OVERLAY_TREE_OBJECTS then
		p2.Text((("Root Part: %*"):format(p1.RootPart.Name)))
		p2.Text((("Root Bone: %*"):format(p1.Root.Name)))
		p2.Text((("Root Part Size: %*"):format((string.format("%.3f, %.3f, %.3f", p1.RootPart.Size.X, p1.RootPart.Size.Y, p1.RootPart.Size.Z)))))
	end

	if Config.DEBUG_OVERLAY_TREE_INFO or Config.DEBUG_OVERLAY_TREE_NUMERICS then
		p2.Text((("Update Rate: %*"):format((string.format("%.3f", p1.UpdateRate)))))
		p2.Text((("In View: %*"):format(p1.InView)))
		p2.Text((("Accumulated Delta: %*"):format((string.format("%.3f", p1.AccumulatedDelta)))))
		p2.Text((("Force: %*"):format((string.format("%.3f, %.3f, %.3f", p1.Force.X, p1.Force.Y, p1.Force.Z)))))
	end

	local v1 = Color3.new(0.486275, 0.431373, 1)
	local v2 = Color3.new(255/255, 255/255, 255/255)

	if not Config.DEBUG_OVERLAY_BONE then
		return
	end

	for v3, v4 in p1.Bones do
		if Config.DEBUG_OVERLAY_MAX_BONES > 0 and Config.DEBUG_OVERLAY_BONE_OFFSET + Config.DEBUG_OVERLAY_MAX_BONES <= v3 then
			break
		end

		if not (v3 < Config.DEBUG_OVERLAY_BONE_OFFSET) then
			p2.Begin(("Bone %*"):format(v3), v1, v2)
			v4:DrawOverlay(p2)
			p2.End()
		end
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 521 | Upvalues: SB_VERBOSE_LOG (copy) ]]
	SB_VERBOSE_LOG("Destroy BoneTree")
	task.synchronize()
	p1.DestroyConnection:Disconnect()
	p1.AttributeConnection:Disconnect()

	for v1, v2 in p1.Bones do
		v2:Destroy()
	end

	setmetatable(p1, nil)
	task.desynchronize()
end

return t