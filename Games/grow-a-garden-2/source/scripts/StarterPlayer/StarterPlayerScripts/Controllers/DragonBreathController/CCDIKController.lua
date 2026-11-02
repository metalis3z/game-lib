--credit to leon games studio
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VectorUtil = require(script.VectorUtil)
local Maid = require(script.Maid)

local function fromToRotation(p1, p2, p3) --[[ fromToRotation | Line: 10 ]]
	local v1 = p1:Dot(p2)

	if v1 > 0.99999 then
		return CFrame.new()
	end

	if v1 < -0.99999 then
		return CFrame.fromAxisAngle(p3, math.pi)
	end

	return CFrame.fromAxisAngle(p1:Cross(p2), math.acos(v1) * 0.8)
end

local function getRotationBetween(p1, p2, p3) --[[ getRotationBetween | Line: 24 ]]
	local v1 = p1:Dot(p2)
	local v2 = p1:Cross(p2)

	if v1 < -0.99999 then
		return CFrame.fromAxisAngle(p3, math.pi)
	end

	return CFrame.new(0, 0, 0, v2.x, v2.y, v2.z, 1 + v1)
end

local function rotateVectorAround(p1, p2, p3) --[[ rotateVectorAround | Line: 35 ]]
	return CFrame.fromAxisAngle(p3, p2):VectorToWorldSpace(p1)
end

local v1 = CFrame.new
local lookAt = CFrame.lookAt

Vector3.new()

local Motor6D = Instance.new("Motor6D")
local _ = {
	[Instance.new("Motor6D")] = {
		ConstraintType = "Hinge",
		UpperAngle = 45,
		LowerAngle = -45,
		AxisAttachment = nil,
		JointAttachment = nil
	},
	[Motor6D] = {
		ConstraintType = "BallSocketConstraint",
		UpperAngle = 45,
		TwistLimitsEnabled = false,
		TwistUpperAngle = 45,
		TwistLowerAngle = -45,
		AxisAttachment = nil,
		JointAttachment = nil
	}
}
local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 66 | Upvalues: t (copy), Maid (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Maid = Maid.new()
	v2.Motor6DTable = p1
	v2.Constraints = p2

	local v3, v4 = v2:SetupJoints()

	v2.JointInfo = v3
	v2.JointAxisInfo = v4
	v2.EndEffector = p1[#p1].Part1:FindFirstChild("EndEffector")

	if not v2.EndEffector then
		local EndEffector = Instance.new("Attachment")

		EndEffector.Name = "EndEffector"
		EndEffector.Parent = p1[#p1].Part1
		v2.EndEffector = EndEffector
		v2.Maid:GiveTask(EndEffector)
	end

	v2.DebugMode = false
	v2.LerpMode = true
	v2.LerpAlpha = 0.9
	v2.ConstantLerpSpeed = true
	v2.AngularSpeed = 1.5707963267948966
	v2.FootOrientationSystem = false
	v2.FootRaycastParams = RaycastParams.new()
	v2.RaycastLengthDown = 50
	v2._RayResultTable = {}
	v2.UseLastMotor = false

	return v2
end
function t.SetupJoints(p1) --[[ SetupJoints | Line: 106 ]]
	local t = {}

	for k, v in pairs(p1.Motor6DTable) do
		local JointPosition = Instance.new("Attachment")

		JointPosition.CFrame = v.C0
		JointPosition.Name = "JointPosition"
		JointPosition.Parent = v.Part0
		t[v] = JointPosition
		p1.Maid:GiveTask(JointPosition)

		if p1.Constraints then
			local v1 = p1.Constraints[v]

			if v1 then
				if v1.AxisAttachment then
					if typeof(v1.AxisAttachment) == "string" then
						v1.AxisAttachment = v.Part0:FindFirstChild(v1.AxisAttachment .. "AxisAttachment")
					end
				else
					v1.AxisAttachment = v.Part0:FindFirstChild(v.Part0.Name .. "AxisAttachment")
				end

				if v1.JointAttachment then
					if typeof(v1.JointAttachment) == "string" then
						v1.JointAttachment = v.Part1:FindFirstChild(v1.JointAttachment .. "JointAttachment")
					end

					continue
				end

				v1.JointAttachment = v.Part1:FindFirstChild(v.Part0.Name .. "JointAttachment")
			end
		end
	end

	return t, {}
end
function t.GetConstraints(p1) --[[ GetConstraints | Line: 150 ]]
	if not p1.Constraints then
		p1.Constraints = {}
	end

	for k, v in pairs(p1.Motor6DTable) do
		local Part0 = v.Part0
		local v1 = Part0:FindFirstChildWhichIsA("HingeConstraint")
		local v2 = Part0:FindFirstChildWhichIsA("BallSocketConstraint")

		if v1 then
			p1.Constraints[v] = {
				ConstraintType = "Hinge",
				UpperAngle = v1.UpperAngle,
				LowerAngle = v1.LowerAngle,
				AxisAttachment = v1.Attachment0,
				JointAttachment = v1.Attachment1
			}

			continue
		end

		if v2 then
			p1.Constraints[v] = {
				ConstraintType = "BallSocketConstraint",
				UpperAngle = v2.UpperAngle,
				TwistLimitsEnabled = v2.TwistLimitsEnabled,
				TwistUpperAngle = v2.TwistUpperAngle,
				TwistLowerAngle = v2.TwistLowerAngle,
				AxisAttachment = v2.Attachment0,
				JointAttachment = v2.Attachment1
			}
		end
	end
end
function t.GetConstraintsFromMotor(p1, p2, p3) --[[ GetConstraintsFromMotor | Line: 183 ]]
	if not p1.Constraints then
		p1.Constraints = {}
	end

	local v1 = p2.Part0:FindFirstChild(p3)

	if v1:IsA("HingeConstraint") then
		p1.Constraints[p2] = {
			ConstraintType = "Hinge",
			UpperAngle = v1.UpperAngle,
			LowerAngle = v1.LowerAngle,
			AxisAttachment = v1.Attachment0,
			JointAttachment = v1.Attachment1
		}

		return
	end

	if not v1:IsA("BallSocketConstraint") then
		return
	end

	p1.Constraints[p2] = {
		ConstraintType = "BallSocketConstraint",
		UpperAngle = v1.UpperAngle,
		TwistLimitsEnabled = v1.TwistLimitsEnabled,
		TwistUpperAngle = v1.TwistUpperAngle,
		TwistLowerAngle = v1.TwistLowerAngle,
		AxisAttachment = v1.Attachment0,
		JointAttachment = v1.Attachment1
	}
end
function t._CCDIKIterateFoot(p1, p2) --[[ _CCDIKIterateFoot | Line: 211 | Upvalues: v1 (copy) ]]
	local Constraints = p1.Constraints
	local Motor6DTable = p1.Motor6DTable
	local v12 = Motor6DTable[#Motor6DTable]

	v12.C0 = v12.C0 * v12.Transform
	p1:OrientFootMotorToFloor(v12, p2)
	v12.Transform = v1()

	if not Constraints then
		return
	end

	local v2 = Constraints[v12]

	if not v2 then
		return
	end

	if v2.ConstraintType == "Hinge" then
		p1:RotateToHingeAxis(v12, v2)
	end

	if v2.ConstraintType ~= "BallSocketConstraint" then
		return
	end

	p1:RotateToBallSocketConstraintAxis(v12, v2)
end
function t._CCDIKIterateStep(p1, p2, p3) --[[ _CCDIKIterateStep | Line: 233 | Upvalues: v1 (copy) ]]
	local Constraints = p1.Constraints

	for i = #p1.Motor6DTable - 1 + (if p1.UseLastMotor then 1 else 0), 1, -1 do
		local v2 = p1.Motor6DTable[i]

		v2.C0 = v2.C0 * v2.Transform
		p1:RotateFromEffectorToGoal(v2, p2, p3)
		v2.Transform = v1()

		if Constraints then
			local v3 = Constraints[v2]

			if v3 then
				if v3.ConstraintType == "Hinge" then
					p1:RotateToHingeAxis(v2, v3)
				end

				if v3.ConstraintType == "BallSocketConstraint" then
					p1:RotateToBallSocketConstraintAxis(v2, v3)
				end
			end
		end
	end
end
function t.CCDIKIterateOnce(p1, p2, p3, p4) --[[ CCDIKIterateOnce | Line: 257 ]]
	local _ = p1.EndEffector.WorldPosition - p2

	p1:_CCDIKIterateStep(p2, p4)

	if not p1.FootOrientationSystem then
		return
	end

	p1:_CCDIKIterateFoot(p4)
end
function t.CCDIKIterateOnceDebug(p1, p2, p3, p4) --[[ CCDIKIterateOnceDebug | Line: 269 ]]
	p1:_CCDIKIterateStep(p2, p4)
end
function t.CCDIKIterateUntil(p1, p2, p3, p4, p5) --[[ CCDIKIterateUntil | Line: 281 ]]
	local count = 0

	while (p3 or 1) < (p1.EndEffector.WorldPosition - p2).Magnitude and count <= (p4 or 10) do
		count = count + 1
		p1:_CCDIKIterateStep(p2, p5)

		if p1.FootOrientationSystem then
			p1:_CCDIKIterateFoot(p5)
		end
	end
end

local function worldCFrameToC0ObjectSpace(p1, p2) --[[ worldCFrameToC0ObjectSpace | Line: 295 ]]
	local C1 = p1.C1
	local C0 = p1.C0
	local v2 = C0 * C1:Inverse() * p1.Part1.CFrame:Inverse() * p2 * C1

	return v2 - v2.Position + C0.Position
end

local function calculateGoalFromToC0CFrame(p1, p2, p3, p4) --[[ calculateGoalFromToC0CFrame | Line: 304 | Upvalues: fromToRotation (copy) ]]
	local v1 = fromToRotation(p2, p3, p4)
	local v2 = p1.Part1.CFrame
	local C1 = p1.C1
	local C0 = p1.C0
	local v3 = C0 * C1:Inverse() * v2:Inverse() * (v1 * v2) * C1

	return v3 - v3.Position + C0.Position
end

function t.rotateJointFromTo(p1, p2, p3, p4) --[[ rotateJointFromTo | Line: 319 | Upvalues: fromToRotation (copy) ]]
	local v1 = fromToRotation(p2, p3, p4)
	local v2 = p1.Part1.CFrame
	local C1 = p1.C1
	local C0 = p1.C0
	local v3 = C0 * C1:Inverse() * v2:Inverse() * (v1 * v2) * C1

	p1.C0 = v3 - v3.Position + C0.Position
end

local v2 = TweenInfo.new(0.1)

function t.rotateJointFromToTween(p1, p2, p3, p4) --[[ rotateJointFromToTween | Line: 324 | Upvalues: fromToRotation (copy), TweenService (copy), v2 (copy) ]]
	local v1 = fromToRotation(p2, p3, p4)
	local v22 = p1.Part1.CFrame
	local C1 = p1.C1
	local C0 = p1.C0
	local v3 = C0 * C1:Inverse() * v22:Inverse() * (v1 * v22) * C1
	local v4 = TweenService:Create(p1, v2, {
		C0 = v3 - v3.Position + C0.Position
	})

	v4:Play()
	v4.Completed:Wait()
end
function t.rotateJointFromToWithLerp(p1, p2, p3, p4, p5, p6) --[[ rotateJointFromToWithLerp | Line: 332 | Upvalues: fromToRotation (copy), VectorUtil (copy) ]]
	local v1 = fromToRotation(p3, p4, p5)
	local v2 = p2.Part1.CFrame
	local C1 = p2.C1
	local C0 = p2.C0
	local v3 = C0 * C1:Inverse() * v2:Inverse() * (v1 * v2) * C1
	local v4 = v3 - v3.Position + C0.Position
	local LerpAlpha = p1.LerpAlpha
	local C02 = p2.C0
	local v5

	if p6 and p1.ConstantLerpSpeed then
		v5, LerpAlpha = v4, math.min(p6 * (p1.AngularSpeed / VectorUtil.AngleBetween(C02.LookVector, v4.LookVector)), 1)
	else
		v5 = v4
	end

	p2.C0 = C02:Lerp(v5, LerpAlpha)
end
function t.RotateFromEffectorToGoal(p1, p2, p3, p4) --[[ RotateFromEffectorToGoal | Line: 347 ]]
	local v1 = p2.Part0.CFrame
	local WorldPosition = p1.JointInfo[p2].WorldPosition
	local WorldPosition2 = p1.EndEffector.WorldPosition
	local Unit = (WorldPosition2 - WorldPosition).Unit
	local Unit2 = (p3 - WorldPosition).Unit

	if p1.DebugMode then
		p1.VisualizeVector(WorldPosition, WorldPosition2 - WorldPosition, BrickColor.Blue())
		p1.VisualizeVector(WorldPosition, p3 - WorldPosition, BrickColor.Red())
		p1.rotateJointFromToTween(p2, Unit, Unit2, v1.UpVector)

		return
	end

	if p1.LerpMode == true then
		p1:rotateJointFromToWithLerp(p2, Unit, Unit2, v1.RightVector, p4)
	else
		p1.rotateJointFromTo(p2, Unit, Unit2, v1.RightVector)
	end
end
function t.RotateToHingeAxis(p1, p2, p3) --[[ RotateToHingeAxis | Line: 379 ]]
	local AxisAttachment = p3.AxisAttachment
	local JointAttachment = p3.JointAttachment

	p1.rotateJointFromTo(p2, JointAttachment.WorldAxis, AxisAttachment.WorldAxis, p2.Part0.CFrame.RightVector)

	local WorldCFrame = AxisAttachment.WorldCFrame
	local v4, _, _2 = WorldCFrame:ToObjectSpace(JointAttachment.WorldCFrame):ToEulerAnglesXYZ()
	local v7 = math.rad((math.clamp(math.deg(v4), p3.LowerAngle or -180, p3.UpperAngle or 180)))
	local v8 = WorldCFrame:ToWorldSpace((CFrame.fromEulerAnglesXYZ(v7, 0, 0))) * JointAttachment.CFrame:Inverse()
	local C1 = p2.C1
	local C0 = p2.C0
	local v10 = C0 * C1:Inverse() * p2.Part1.CFrame:Inverse() * v8 * C1

	p2.C0 = v10 - v10.Position + C0.Position
end

local function twistSwing(p1, p2) --[[ twistSwing | Line: 421 ]]
	local v1, v2 = p1:ToAxisAngle()
	local v3 = math.cos(v2 / 2)
	local v4 = (math.sin(v2 / 2) * v1):Dot(p2) * p2
	local v5 = CFrame.new(p1.x, p1.y, p1.z, v4.x, v4.y, v4.z, v3)

	return v5:Inverse() * p1, v5
end

function t.RotateToBallSocketConstraintAxis(p1, p2, p3) --[[ RotateToBallSocketConstraintAxis | Line: 429 | Upvalues: VectorUtil (copy), twistSwing (copy) ]]
	local v1 = p2.Part0.CFrame
	local AxisAttachment = p3.AxisAttachment
	local JointAttachment = p3.JointAttachment
	local WorldAxis = AxisAttachment.WorldAxis
	local WorldAxis2 = JointAttachment.WorldAxis
	local v2 = VectorUtil.AngleBetween(WorldAxis2, WorldAxis)
	local v3 = math.rad(p3.UpperAngle) or 0.7853981633974483

	if v3 < v2 then
		p1.rotateJointFromTo(p2, WorldAxis2, CFrame.fromAxisAngle(WorldAxis2:Cross(WorldAxis), v2 - v3):VectorToWorldSpace(WorldAxis2), v1.RightVector)
	end

	if not p3.TwistLimitsEnabled then
		return
	end

	local WorldCFrame = AxisAttachment.WorldCFrame
	local WorldAxis3 = AxisAttachment.WorldAxis
	local v6, v7 = twistSwing(WorldCFrame:ToObjectSpace(JointAttachment.WorldCFrame), WorldAxis3)
	local v8, v9 = v7:ToAxisAngle()
	local v11 = math.sign((v8:Dot(WorldAxis3)))
	local v13 = math.deg(v11 * v9)
	local TwistUpperAngle = p3.TwistUpperAngle
	local TwistLowerAngle = p3.TwistLowerAngle
	local v14 = false
	local v15

	if TwistUpperAngle < v13 then
		v15 = TwistUpperAngle
	elseif v13 < TwistLowerAngle then
		v15 = TwistLowerAngle
	else
		v14 = true
		v15 = v13
	end

	if v14 then
		return
	end

	local v16 = math.rad(v15)
	local v17 = WorldCFrame * (CFrame.fromAxisAngle(v11 * v8, v16) * v6) * JointAttachment.CFrame:Inverse()
	local C1 = p2.C1
	local C0 = p2.C0
	local v19 = C0 * C1:Inverse() * p2.Part1.CFrame:Inverse() * v17 * C1

	p2.C0 = v19 - v19.Position + C0.Position
end
function t.SetupFoot(p1, p2, p3) --[[ SetupFoot | Line: 481 ]]
	local Motor6DTable = p1.Motor6DTable
	local Part1 = Motor6DTable[#Motor6DTable].Part1
	local t = {}

	for k, v in pairs(p2) do
		t[k] = Part1:FindFirstChild(v)
	end

	p1.FootAttachmentTable = t
	p1.FootRaycastParams = p3
	p1.FootOrientationSystem = true
end
function t.OrientFootMotorToFloor(p1, p2, p3) --[[ OrientFootMotorToFloor | Line: 493 ]]
	local FootAttachmentTable = p1.FootAttachmentTable
	local RaycastLengthDown = p1.RaycastLengthDown
	local _RayResultTable = p1._RayResultTable
	local FootRaycastParams = p1.FootRaycastParams

	for i = 1, 3 do
		local v1 = FootAttachmentTable[i]

		_RayResultTable[i] = workspace:Raycast(v1.WorldPosition, -v1.WorldCFrame.UpVector * RaycastLengthDown, FootRaycastParams)
	end

	local v4 = if (_RayResultTable[1] and (_RayResultTable[2] and _RayResultTable[3])) == nil then true else false
	local WorldCFrame = p1.EndEffector.WorldCFrame
	local v5 = v4 and WorldCFrame.UpVector or (_RayResultTable[2].Position - _RayResultTable[1].Position):Cross(_RayResultTable[3].Position - _RayResultTable[1].Position).Unit
	local UpVector = WorldCFrame.UpVector

	if v4 == false then
		p1:rotateJointFromToWithLerp(p2, UpVector, v5, WorldCFrame.UpVector, p3)
	end

	local Constraints = p1.Constraints

	if not Constraints then
		return
	end

	local v6 = Constraints[p2]

	if not v6 then
		return
	end

	if v6.ConstraintType == "Hinge" then
		p1:RotateToHingeAxis(p2, v6)
	end

	if v6.ConstraintType ~= "BallSocketConstraint" then
		return
	end

	p1:RotateToBallSocketConstraintAxis(p2, v6)
end
function t.InitDragDebug(p1) --[[ InitDragDebug | Line: 529 | Upvalues: RunService (copy) ]]
	local Part1 = p1.Motor6DTable[#p1.Motor6DTable].Part1

	p1.LerpMode = false

	local Part = Instance.new("Part")

	Part.CanCollide = false
	Part.Anchored = true
	Part.Size = Vector3.new(1, 1, 1)
	Part.BrickColor = BrickColor.random()
	Part.Position = Part1.Position
	Part.Name = "DragMe!: " .. Part1.Name
	Part.Parent = workspace
	RunService.Heartbeat:Connect(function() --[[ Line: 540 | Upvalues: p1 (copy), Part (copy) ]]
		p1:CCDIKIterateOnce(Part.Position)
	end)
end
function t.InitTweenDragDebug(p1) --[[ InitTweenDragDebug | Line: 544 | Upvalues: lookAt (copy) ]]
	local Part1 = p1.Motor6DTable[#p1.Motor6DTable].Part1

	p1.DebugMode = true

	for i = 1, #p1.Motor6DTable - 1 do
		local v2 = p1.Motor6DTable[i + 1]
		local WorldPosition = p1.JointInfo[p1.Motor6DTable[i]].WorldPosition
		local v3 = p1.JointInfo[v2].WorldPosition - WorldPosition
		local WedgePart = Instance.new("WedgePart")

		WedgePart.Size = Vector3.new(0.1, 0.1, v3.Magnitude)
		WedgePart.CFrame = lookAt(WorldPosition, WorldPosition + v3) * CFrame.new(0, 0, -v3.Magnitude / 2)
		WedgePart.CanCollide = false

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = WedgePart
		WeldConstraint.Part1 = v2.Parent
		WeldConstraint.Parent = v2.Parent
		WedgePart.Parent = workspace
		WedgePart.Name = "I am a limb vector"
	end

	for k, v in pairs(p1.Motor6DTable) do
		v.Part1.Transparency = 0.75
		v.Part0.Transparency = 0.75
	end

	local Part = Instance.new("Part")

	Part.CanCollide = false
	Part.Anchored = true
	Part.Size = Vector3.new(1, 1, 1)
	Part.BrickColor = BrickColor.random()
	Part.Position = Part1.Position
	Part.Name = "DragMe!: " .. Part1.Name
	Part.Parent = workspace
	spawn(function() --[[ Line: 578 | Upvalues: p1 (copy), Part (copy) ]]
		while true do
			wait()
			p1:CCDIKIterateOnceDebug(Part.Position)
		end
	end)
end
function commandBarSetupJoints(p1) --[[ commandBarSetupJoints | Line: 591 ]]
	for k, v in pairs((p1:GetDescendants())) do
		if v:IsA("Motor6D") then
			local v2 = v.Part0.Name
			local Attachment = Instance.new("Attachment")

			Attachment.CFrame = v.C0
			Attachment.Name = v2 .. "AxisAttachment"
			Attachment.Parent = v.Part0

			local Attachment2 = Instance.new("Attachment")

			Attachment2.CFrame = v.C1
			Attachment2.Name = v2 .. "JointAttachment"
			Attachment2.Parent = v.Part1
		end
	end
end
function commandBarSetupRigAttachments(p1) --[[ commandBarSetupRigAttachments | Line: 609 ]]
	for k, v in pairs((p1:GetDescendants())) do
		if v:IsA("Motor6D") then
			local v2 = v.Name
			local Attachment = Instance.new("Attachment")

			Attachment.CFrame = v.C0
			Attachment.Name = v2 .. "RigAttachment"
			Attachment.Parent = v.Part0

			local Attachment2 = Instance.new("Attachment")

			Attachment2.CFrame = v.C1
			Attachment2.Name = v2 .. "RigAttachment"
			Attachment2.Parent = v.Part1
		end
	end
end
function t.VisualizeVector(p1, p2, p3) --[[ VisualizeVector | Line: 629 | Upvalues: lookAt (copy), Debris (copy) ]]
	local WedgePart = Instance.new("WedgePart")

	WedgePart.Size = Vector3.new(0.1, 0.1, p2.Magnitude)
	WedgePart.CFrame = lookAt(p1, p1 + p2) * CFrame.new(0, 0, -p2.Magnitude / 2)
	WedgePart.Anchored = true
	WedgePart.CanCollide = false
	WedgePart.BrickColor = if p3 then p3 else BrickColor.random()
	WedgePart.Parent = workspace
	Debris:AddItem(WedgePart, 0.75)
end
function t.Destroy(p1) --[[ Destroy | Line: 642 ]]
	p1.Maid:DoCleaning()
end

return t