-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Dependencies = script.Parent.Parent:WaitForChild("Dependencies")
local Config = require(Dependencies:WaitForChild("Config"))
local Gizmo = require(Dependencies:WaitForChild("Gizmo"))
local Utilities = require(Dependencies:WaitForChild("Utilities"))

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG then
	Gizmo.Init()
end

local Constraints = script.Parent:WaitForChild("Constraints")
local AxisConstraint = require(Constraints:WaitForChild("AxisConstraint"))
local CollisionConstraint = require(Constraints:WaitForChild("CollisionConstraint"))
local DistanceConstraint = require(Constraints:WaitForChild("DistanceConstraint"))
local FrictionConstraint = require(Constraints:WaitForChild("FrictionConstraint"))
local RopeConstraint = require(Constraints:WaitForChild("RopeConstraint"))
local RotationConstraint = require(Constraints:WaitForChild("RotationConstraint"))
local SpringConstraint = require(Constraints:WaitForChild("SpringConstraint"))
local SB_ASSERT_CB = Utilities.SB_ASSERT_CB

local function SafeUnit(p1) --[[ SafeUnit | Line: 25 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function IsNaN(p1) --[[ IsNaN | Line: 86 ]]
	return p1 ~= p1
end

local t = {}

local function v1(p1) --[[ QueryTransformedWorldCFrameNonSmartbone | Line: 97 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t[p1]

	if v12 and v12.Frame == shared.FrameCounter then
		return v12.CFrame
	end

	local v2 = p1.Parent
	local v5 = (if v2:IsA("Bone") then v1(v2) else v2.CFrame) * p1.TransformedCFrame

	t[p1] = {
		Frame = shared.FrameCounter,
		CFrame = v5
	}

	return v5
end

local function v2(p1, p2) --[[ QueryTransformedWorldCFrame | Line: 126 | Upvalues: v1 (copy), v2 (copy) ]]
	p2.SolvedAnimatedCFrame = true

	local ParentIndex = p2.ParentIndex
	local Bone = p2.Bone

	if ParentIndex < 1 then
		return v1(Bone)
	end

	local v12 = p1.Bones[ParentIndex]

	if not v12.SolvedAnimatedCFrame then
		v12.AnimatedWorldCFrame = v2(p1, v12)
	end

	return v12.AnimatedWorldCFrame * Bone.TransformedCFrame
end

local function ClipVector(p1, p2, p3) --[[ ClipVector | Line: 151 ]]
	return p1 * (Vector3.new(1, 1, 1) - p3) + p2 * p3
end

local function GetFriction(p1, p2) --[[ GetFriction | Line: 157 ]]
	local CurrentPhysicalProperties = p1.CurrentPhysicalProperties
	local CurrentPhysicalProperties2 = p2.CurrentPhysicalProperties
	local FrictionWeight = CurrentPhysicalProperties.FrictionWeight
	local FrictionWeight2 = CurrentPhysicalProperties2.FrictionWeight

	return (CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties2.Friction * FrictionWeight2) / (FrictionWeight + FrictionWeight2)
end

local function SolveWind(p1, p2, p3) --[[ SolveWind | Line: 170 ]]
	local Settings = p2.Settings
	local WindType = Settings.WindType

	if WindType ~= "Sine" and (WindType ~= "Noise" and WindType ~= "Hybrid") then
		return Vector3.new(0, 0, 0)
	end

	local v1 = p2.WindOffset + (os.clock() - p1.HeirarchyLength * 0.2 + (p1.TransformOffset.Position - p2.Root.WorldPosition).Magnitude * 0.2) * Settings.WindInfluence
	local WindSpeed = Settings.WindSpeed
	local WindStrength = Settings.WindStrength

	if WindSpeed == Vector3.new(0, 0, 0) or WindStrength == 0 then
		return Vector3.new(0, 0, 0)
	end

	local WindDirection = Settings.WindDirection
	local v2 = if p3.Magnitude == 0 then Vector3.new(0, 0, 0) else p3.Unit
	local v4 = 1 - math.abs((v2:Dot(WindDirection)))

	if WindSpeed > 0 then
		v4 = if v2:Dot(WindDirection) > 0 then v4 * math.abs(1 - p3.Magnitude / WindSpeed) else v4 * (1 + p3.Magnitude / WindSpeed)
	end

	local v6 = WindSpeed * v4

	local function EaseInExpo(p1) --[[ EaseInExpo | Line: 225 ]]
		if p1 == 0 then
			return 0
		end

		return 2 ^ (p1 * 10 - 10)
	end

	local v7 = p3.Magnitude < 100 and p3.Magnitude or 100
	local v8 = if v7 == 0 then 0 else 2 ^ (v7 * 10 - 10)
	local v9 = v1 * math.max(v8, 1)
	local v10

	if v6 < 1 then
		v10 = v6 * v8
	else
		local v11 = v8 / 2

		v10 = v6 * (if v11 > 1 then v11 else 1)
	end

	local v13 = nil

	local function GetNoise(p1, p2, p3, p4) --[[ GetNoise | Line: 242 ]]
		local v2 = math.clamp(math.noise(p1, p2, p3), -1, 1)

		return if p4 then v2 ^ 2 else v2
	end

	local function SampleGust() --[[ SampleGust | Line: 256 | Upvalues: v9 (ref) ]]
		return math.sin(v9 * 1) * 0.3 + 0.7
	end

	local function SampleSin() --[[ SampleSin | Line: 262 | Upvalues: WindStrength (copy), v10 (ref), v9 (ref), WindDirection (copy) ]]
		local v1 = WindStrength ^ 0.8
		local v2 = v10 * 2
		local v7 = (math.sin(v9 * v1) + math.cos(v9 / 10 * v1) + math.sin(v9 * 2 * v1) + math.cos(v9 * 3 * v1)) / 4
		local v92 = v7 * v2
		local v102 = (v7 * 0.5 + 0.5) * v2

		return WindDirection * (if v92 < v102 then if v102 then v102 else v92 else v92)
	end

	local function SampleNoise(p1, p22) --[[ SampleNoise | Line: 282 | Upvalues: WindStrength (copy), v10 (ref), p2 (copy), WindDirection (copy) ]]
		local v1 = p1 or 0
		local v2 = WindStrength ^ 0.8
		local v3 = v10 * 2
		local WindOffset = p2.WindOffset
		local v5 = math.clamp(math.noise(v2, 0, WindOffset), -1, 1)
		local v9 = math.clamp(math.noise(0, v2, WindOffset), -1, 1)
		local v13 = math.clamp(math.noise(WindOffset, 0, v2), -1, 1)

		return WindDirection * Vector3.new((if p22 then v5 ^ 2 else v5) * (v3 + v1), (if p22 then v9 ^ 2 else v9) * (v3 + v1), (if p22 then v13 ^ 2 else v13) * (v3 + v1))
	end

	if Settings.WindType == "Sine" then
		v13 = SampleSin() * (math.sin(v9 * 1) * 0.3 + 0.7)
	elseif Settings.WindType == "Noise" then
		v13 = SampleNoise(0, true) * (math.sin(v9 * 1) * 0.3 + 0.7)
	elseif Settings.WindType == "Hybrid" then
		v13 = (SampleSin() * (math.sin(v9 * 1) * 0.3 + 0.7) + SampleNoise(0.5, true) * (math.sin(v9 * 1) * 0.3 + 0.7)) * 0.5
	end

	local v18 = if p1.FreeLength < 0.01 then 0.01 else p1.FreeLength

	return v13 / v18 * (Settings.WindInfluence * (WindStrength * 0.01) * (math.clamp(p1.HeirarchyLength, 1, 10) * 0.1)) * p1.Weight
end

local t2 = {}

t2.__index = t2
function t2.new(p1, p2, p3) --[[ new | Line: 469 | Upvalues: t2 (copy), Utilities (copy) ]]
	local v1 = p1.Parent:IsA("Bone") and p1.Parent.TransformedWorldCFrame or p3.CFrame
	local v3 = setmetatable({
		Bone = p1,
		FreeLength = -1,
		Weight = 0.7,
		ParentIndex = -1,
		HeirarchyLength = 0,
		Transform = p1.TransformedWorldCFrame:ToObjectSpace(v1):Inverse(),
		LocalTransform = p1.TransformedCFrame:ToObjectSpace(p2.TransformedCFrame):Inverse(),
		RootPart = p3,
		RootBone = p2,
		Radius = 0,
		Friction = 0,
		RotationLimit = 0,
		Force = nil,
		Gravity = nil,
		SolvedAnimatedCFrame = false,
		HasChild = false,
		AnimatedWorldCFrame = p1.TransformedWorldCFrame,
		StartingCFrame = p1.TransformedCFrame,
		TransformOffset = CFrame.identity,
		LocalTransformOffset = CFrame.identity,
		RestPosition = Vector3.new(0, 0, 0),
		CalculatedWorldCFrame = p1.TransformedWorldCFrame,
		Position = p1.TransformedWorldCFrame.Position,
		LastPosition = p1.TransformedWorldCFrame.Position,
		WeldPosition = Vector3.new(0, 0, 0),
		WeldCFrame = CFrame.identity,
		ActiveWeld = false,
		RigidWeld = false,
		Anchored = false,
		AxisLocked = { false, false, false },
		XAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
		YAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
		ZAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
		IsSkippingUpdates = false,
		CollisionHits = {},
		CollisionsData = {}
	}, t2)

	v3.AttributeConnection = p1.AttributeChanged:Connect(function(p12) --[[ Line: 522 | Upvalues: Utilities (ref), p1 (copy), v3 (copy) ]]
		for v1, v2 in Utilities.GatherBoneSettings(p1) do
			v3[v1] = if v2 == "\194\172" or not v2 then nil else v2
		end
	end)

	return v3
end
function t2.ClipVelocity(p1, p2, p3) --[[ ClipVelocity | Line: 539 ]]
	p1.LastPosition = p1.LastPosition * (Vector3.new(1, 1, 1) - p3) + p2 * p3
end
function t2.PreUpdate(p1, p2) --[[ PreUpdate | Line: 545 | Upvalues: v1 (copy), v2 (copy) ]]
	local v22 = p2.Bones[p1.ParentIndex]

	p1.SolvedAnimatedCFrame = true

	local ParentIndex = p1.ParentIndex
	local Bone = p1.Bone
	local v3

	if ParentIndex < 1 then
		v3 = v1(Bone)
	else
		local v5 = p2.Bones[ParentIndex]

		if not v5.SolvedAnimatedCFrame then
			v5.AnimatedWorldCFrame = v2(p2, v5)
		end

		v3 = v5.AnimatedWorldCFrame * Bone.TransformedCFrame
	end

	p1.AnimatedWorldCFrame = v3

	local SmartWeld = p1.Bone:FindFirstChild("SmartWeld")

	p1.ActiveWeld = false

	if SmartWeld and SmartWeld:IsA("ObjectValue") then
		local v6 = SmartWeld.Value

		p1.RigidWeld = SmartWeld:GetAttribute("Rigid") == true

		if v6 and v6:IsA("Attachment") then
			p1.WeldPosition = v6.WorldPosition
			p1.WeldCFrame = v6.WorldCFrame
			p1.ActiveWeld = true
		elseif v6 and v6:IsA("BasePart") then
			p1.WeldPosition = v6.Position
			p1.WeldCFrame = v6.CFrame
			p1.ActiveWeld = true
		end
	end

	if p1.ParentIndex < 1 then
		p1.Anchored = true
	end

	if p1.Bone == p1.RootBone then
		p1.TransformOffset = (if p1.Bone.Parent:IsA("Bone") then v1(p1.Bone.Parent) else p1.RootPart.CFrame) * p1.Transform
	else
		p1.TransformOffset = v22.AnimatedWorldCFrame * p1.Transform
	end

	p1.LocalTransformOffset = p2.Bones[1].Bone.CFrame * p1.LocalTransform
end
function t2.StepPhysics(p1, p2, p3, p4) --[[ StepPhysics | Line: 606 | Upvalues: SolveWind (copy) ]]
	if p1.Anchored then
		p1.LastPosition = p1.AnimatedWorldCFrame.Position
		p1.Position = p1.AnimatedWorldCFrame.Position

		return
	end

	if p1.Force or p1.Gravity then
		p3 = ((p1.Gravity or p2.Settings.Gravity) + (p1.Force or p2.Settings.Force)) * p4
	end

	local Settings = p2.Settings
	local v3 = p1.Position - p1.LastPosition
	local v5 = SolveWind(p1, p2, v3)

	p1.LastPosition = p1.Position
	p1.Position = p1.Position + (v3 * (1 - Settings.Damping) + p3 + p2.ObjectAcceleration * Settings.Inertia + v5)
end
function t2.Constrain(p1, p2, p3, p4) --[[ Constrain | Line: 649 | Upvalues: FrictionConstraint (copy), CollisionConstraint (copy), SpringConstraint (copy), DistanceConstraint (copy), RopeConstraint (copy), AxisConstraint (copy), RotationConstraint (copy) ]]
	if p1.Anchored then
		return
	end

	local v2 = FrictionConstraint(p1, p1.Position, p1.LastPosition)
	local v3 = if #p3 == 0 then v2 else CollisionConstraint(p1, v2, p3)
	local v9 = RotationConstraint(p1, AxisConstraint(p1, if p2.Settings.Constraint == "Spring" then SpringConstraint(p1, v3, nil, p2, p4) elseif p2.Settings.Constraint == "Distance" then DistanceConstraint(p1, v3, p2) elseif p2.Settings.Constraint == "Rope" then RopeConstraint(p1, v3, p2) else p1.AnimatedWorldCFrame.Position, p1.LastPosition, p1.RootPart.CFrame), p2)
	local v10 = if p1.ActiveWeld then if p1.RigidWeld then p1.WeldPosition else SpringConstraint(p1, v9, p1.WeldPosition, p2, p4) else v9

	p1.Friction = 0

	for v12, v13 in p1.CollisionHits do
		local CurrentPhysicalProperties = p1.RootPart.CurrentPhysicalProperties
		local CurrentPhysicalProperties2 = v13.CurrentPhysicalProperties
		local FrictionWeight = CurrentPhysicalProperties.FrictionWeight
		local FrictionWeight2 = CurrentPhysicalProperties2.FrictionWeight
		local v14 = (CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties2.Friction * FrictionWeight2) / (FrictionWeight + FrictionWeight2)

		p1.Friction = v14 < p1.Friction and p1.Friction or v14
	end

	p1.Position = v10
end
function t2.SkipUpdate(p1) --[[ SkipUpdate | Line: 707 | Upvalues: Config (copy) ]]
	if p1.IsSkippingUpdates == false and Config.RESET_TRANSFORM_ON_SKIP then
		p1.CalculatedWorldCFrame = p1.AnimatedWorldCFrame
		p1.IsSkippingUpdates = true
	end

	p1.LastPosition = p1.AnimatedWorldCFrame.Position + (p1.LastPosition - p1.Position)
	p1.Position = p1.AnimatedWorldCFrame.Position
end
function t2.SolveTransform(p1, p2, p3) --[[ SolveTransform | Line: 722 | Upvalues: Utilities (copy), SB_ASSERT_CB (copy) ]]
	if p1.ParentIndex < 1 then
		return
	end

	p1.IsSkippingUpdates = false

	local v1 = p2.Bones[p1.ParentIndex]
	local Bone = v1.Bone

	if not (v1 and Bone) then
		return
	end

	local TransformOffset = v1.TransformOffset
	local v3 = Utilities.GetRotationBetween(TransformOffset.UpVector, p1.Position - v1.Position).Rotation * TransformOffset.Rotation
	local v4 = math.min(1 - 0.00001 ^ p3, 1)

	if v1.ActiveWeld and v1.RigidWeld then
		v1.CalculatedWorldCFrame = v1.WeldCFrame
	else
		v1.CalculatedWorldCFrame = Bone.WorldCFrame:Lerp(CFrame.new(v1.Position) * v3, v4)
	end

	local Position = v1.CalculatedWorldCFrame.Position

	SB_ASSERT_CB(not (Position ~= Position), warn, "If you see this report this as a bug, (NaN Calc world cframe)")
end
function t2.ApplyTransform(p1, p2) --[[ ApplyTransform | Line: 769 ]]
	p1.SolvedAnimatedCFrame = false

	if p1.ParentIndex < 1 then
		return
	end

	local v1 = p2.Bones[p1.ParentIndex]
	local Bone = v1.Bone

	if not (v1 and Bone) then
		return
	end

	if v1.Anchored and p2.Settings.AnchorsRotate == false then
		Bone.WorldCFrame = v1.TransformOffset

		return
	end

	Bone.WorldCFrame = v1.CalculatedWorldCFrame
end
function t2.DrawDebug(p1, p2, p3, p4, p5, p6, p7) --[[ DrawDebug | Line: 813 | Upvalues: Gizmo (copy) ]]
	local v1 = Color3.fromRGB(255, 0, 0)
	local v2 = Color3.fromRGB(255, 94, 0)
	local v3 = Color3.fromRGB(234, 1, 255)
	local v4 = Color3.fromRGB(0, 255, 255)
	local v5 = Color3.fromRGB(255, 0, 0)
	local v6 = Color3.fromRGB(0, 255, 0)
	local v7 = Color3.fromRGB(0, 0, 255)
	local v8 = Color3.fromRGB(0, 183, 255)
	local v9 = Color3.fromRGB(255, 0, 0)
	local v10 = Color3.fromRGB(0, 255, 0)
	local v11 = Color3.fromRGB(0, 0, 255)
	local v12 = Color3.fromRGB(28, 41, 224)
	local v13 = Color3.fromRGB(255, 27, 27)
	local v14 = 1
	local AnimatedWorldCFrame = p1.AnimatedWorldCFrame
	local Position = AnimatedWorldCFrame.Position
	local v15 = CFrame.new(p1.Position)
	local v16 = CFrame.new(p1.LastPosition)

	if p5 then
		Gizmo.PushProperty("AlwaysOnTop", false)
		Gizmo.PushProperty("Color3", v1)
		Gizmo.Sphere:Draw(v15, p1.Radius, 10, 360)
		Gizmo.PushProperty("Color3", v2)
		Gizmo.Sphere:Draw(v16, p1.Radius, 10, 360)
		Gizmo.PushProperty("Color3", v3)
		Gizmo.Ray:Draw(p1.Position, p1.LastPosition)
	end

	if p6 and not p1.Anchored then
		local RootPart = p1.RootPart
		local v20 = RootPart.CFrame:PointToObjectSpace(Position)
		local RightVector = RootPart.CFrame.RightVector
		local UpVector = RootPart.CFrame.UpVector
		local LookVector = RootPart.CFrame.LookVector

		if not p1.AxisLocked[1] then
			Gizmo.PushProperty("Color3", v9)
			Gizmo.Arrow:Draw(Position - RightVector * 2, Position + RightVector * 2, 0.05, 0.15, 9)
			Gizmo.Plane:Draw(Position + RightVector * (p1.XAxisLimits.Min - v20.X), RightVector, Vector3.new(5, 5, 0))
			Gizmo.Plane:Draw(Position + RightVector * (p1.XAxisLimits.Max - v20.X), RightVector, Vector3.new(5, 5, 0))
		end

		if not p1.AxisLocked[2] then
			Gizmo.PushProperty("Color3", v10)
			Gizmo.Arrow:Draw(Position - UpVector * 2, Position + UpVector * 2, 0.05, 0.15, 9)
			Gizmo.Plane:Draw(Position + UpVector * (p1.YAxisLimits.Min - v20.Y), UpVector, Vector3.new(5, 5, 0))
			Gizmo.Plane:Draw(Position + UpVector * (p1.YAxisLimits.Max - v20.Y), UpVector, Vector3.new(5, 5, 0))
		end

		if not p1.AxisLocked[3] then
			Gizmo.PushProperty("Color3", v11)
			Gizmo.Arrow:Draw(Position - LookVector * 2, Position + LookVector * 2, 0.05, 0.15, 9)
			Gizmo.Plane:Draw(Position - LookVector * (p1.ZAxisLimits.Min - v20.Z), LookVector, Vector3.new(5, 5, 0))
			Gizmo.Plane:Draw(Position - LookVector * (p1.ZAxisLimits.Max - v20.Z), LookVector, Vector3.new(5, 5, 0))
		end
	end

	if p4 then
		Gizmo.PushProperty("Color3", v4)
		Gizmo.Sphere:Draw(AnimatedWorldCFrame, 0.08, 5, 360)
		Gizmo.PushProperty("Color3", v5)
		Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.LookVector * 0.25, 0.005, 0.015, 0.05, true)
		Gizmo.PushProperty("Color3", v6)
		Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.UpVector * 0.25, 0.005, 0.015, 0.05, true)
		Gizmo.PushProperty("Color3", v7)
		Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.RightVector * 0.25, 0.005, 0.015, 0.05, true)
	end

	if p3 and not p1.Anchored then
		for v27, v28 in p1.CollisionsData do
			Gizmo.PushProperty("Color3", v12)
			Gizmo.Sphere:Draw(CFrame.new(v28.ClosestPoint), 0.08, 5, 360)
			Gizmo.PushProperty("Color3", v13)
			Gizmo.Arrow:Draw(v28.ClosestPoint, v28.ClosestPoint + v28.Normal * 0.5, 0.05, 0.15, 9)
		end
	end

	if not (p7 and (p1.RotationLimit < 180 and (p1.RotationLimit > 0 and (p1.ParentIndex > 0 and p1.HasChild)))) then
		return
	end

	local v29 = 1
	local v30

	if p1.RotationLimit < 89.5 then
		v30 = v14 * math.tan((math.rad(p1.RotationLimit)))
	elseif p1.RotationLimit > 90 then
		v30 = v14 * math.tan((math.rad(180 - p1.RotationLimit)))
		v29 = -1
	else
		v30 = 5
		v14 = 0
	end

	local v34 = math.min(v30, 5)

	if v34 == 5 then
		v14 = 0
	end

	local v35 = (p1.Position - p2.Bones[p1.ParentIndex].Position).Unit * v29
	local v36 = CFrame.lookAt(Position + v35 * (v14 * 0.5), Position + -v35 * 500, AnimatedWorldCFrame.LookVector)

	Gizmo.PushProperty("Color3", v8)
	Gizmo.Cone:Draw(v36, v34, v14, 8 + v34 * 2)
end
function t2.DrawOverlay(p1, p2) --[[ DrawOverlay | Line: 1039 | Upvalues: Config (copy) ]]
	p2.Text((("Bone: %*"):format(p1.Bone.Name)))

	if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_NUMERICS then
		p2.Text((("Free Length: %*"):format(p1.FreeLength)))
		p2.Text((("Weight: %*"):format(p1.Weight)))
		p2.Text((("Parent Index: %*"):format(p1.ParentIndex)))
		p2.Text((("Heirarchy Length: %*"):format(p1.HeirarchyLength)))
		p2.Text((("Radius: %*"):format(p1.Radius)))
		p2.Text((("Friction: %*"):format(p1.Friction)))
		p2.Text((("Rotation Limit: %*"):format(p1.RotationLimit)))
	end

	if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_CONSTRAIN then
		p2.Text((("Anchored: %*"):format(p1.Anchored)))
		p2.Text((("Axis Locked: %*, %*, %*"):format(p1.AxisLocked[1], p1.AxisLocked[2], p1.AxisLocked[3])))
		p2.Text((("X Axis Limit: %*"):format(p1.XAxisLimits)))
		p2.Text((("Y Axis Limit: %*"):format(p1.YAxisLimits)))
		p2.Text((("Z Axis Limit: %*"):format(p1.ZAxisLimits)))
	end

	if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_WELD then
		p2.Text((("Active Weld: %*"):format(p1.ActiveWeld)))
		p2.Text((("Rigid Weld: %*"):format(p1.RigidWeld)))
		p2.Text((("Weld Position: %*"):format((string.format("%.3f, %.3f, %.3f", p1.WeldPosition.X, p1.WeldPosition.Y, p1.WeldPosition.Z)))))
	end

	if not (Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_FORCES) then
		return
	end

	local v1 = p1.Force and string.format("%.3f, %.3f, %.3f", p1.Force.X, p1.Force.Y, p1.Force.Z) or "-, -, -"
	local v2 = p1.Gravity and string.format("%.3f, %.3f, %.3f", p1.Gravity.X, p1.Gravity.Y, p1.Gravity.Z) or "-, -, -"

	p2.Text((("Force: %*"):format(v1)))
	p2.Text((("Gravity: %*"):format(v2)))
end
function t2.Destroy(p1) --[[ Destroy | Line: 1085 | Upvalues: Config (copy) ]]
	if Config.RESET_BONE_ON_DESTROY then
		task.synchronize()
		p1.Bone.CFrame = p1.StartingCFrame
	end

	p1.AttributeConnection:Disconnect()
	setmetatable(p1, nil)
end

return t2