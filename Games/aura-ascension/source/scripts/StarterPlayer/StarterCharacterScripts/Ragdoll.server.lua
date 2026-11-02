local character = script.Parent

local REQUIRED_PARTS = {
	Head = true,
	Torso = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
	HumanoidRootPart = true,
}

local MOTOR_NAMES = {
	Neck = {Part = "Torso", Constraint = "Neck_Ragdoll"},
	["Left Shoulder"] = {Part = "Torso", Constraint = "Left Shoulder_Ragdoll"},
	["Right Shoulder"] = {Part = "Torso", Constraint = "Right Shoulder_Ragdoll"},
	["Left Hip"] = {Part = "Torso", Constraint = "Left Hip_Ragdoll"},
	["Right Hip"] = {Part = "Torso", Constraint = "Right Hip_Ragdoll"},
	RootJoint = {Part = "HumanoidRootPart", Constraint = "RootJoint_Ragdoll"},
}

local ATTACHMENTS = {
	{
		Name = "Neck_RagdollA1",
		Part = "Head",
		CFrame = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
	},
	{
		Name = "Neck_RagdollA0",
		Part = "Torso",
		CFrame = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
	},
	{
		Name = "Left Hip_RagdollA0",
		Part = "Torso",
		CFrame = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	},
	{
		Name = "Right Hip_RagdollA0",
		Part = "Torso",
		CFrame = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
	},
	{
		Name = "Left Shoulder_RagdollA0",
		Part = "Torso",
		CFrame = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	},
	{
		Name = "Right Shoulder_RagdollA0",
		Part = "Torso",
		CFrame = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
	},
	{
		Name = "RootJoint_RagdollA1",
		Part = "Torso",
		CFrame = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
	},
	{
		Name = "RootJoint_RagdollA0",
		Part = "HumanoidRootPart",
		CFrame = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
	},
	{
		Name = "Left Hip_RagdollA1",
		Part = "Left Leg",
		CFrame = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	},
	{
		Name = "Right Hip_RagdollA1",
		Part = "Right Leg",
		CFrame = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
	},
	{
		Name = "Left Shoulder_RagdollA1",
		Part = "Left Arm",
		CFrame = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	},
	{
		Name = "Right Shoulder_RagdollA1",
		Part = "Right Arm",
		CFrame = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
	},
}

local CONSTRAINTS = {
	{
		Name = "Neck_Ragdoll",
		ParentPart = "Torso",
		Attachment0 = {Part = "Torso", Name = "Neck_RagdollA0"},
		Attachment1 = {Part = "Head", Name = "Neck_RagdollA1"},
		UpperAngle = 25,
		TwistLowerAngle = -25,
		TwistUpperAngle = 25,
	},
	{
		Name = "Left Hip_Ragdoll",
		ParentPart = "Torso",
		Attachment0 = {Part = "Torso", Name = "Left Hip_RagdollA0"},
		Attachment1 = {Part = "Left Leg", Name = "Left Hip_RagdollA1"},
		UpperAngle = 50,
		TwistLowerAngle = -30,
		TwistUpperAngle = 30,
	},
	{
		Name = "Right Hip_Ragdoll",
		ParentPart = "Torso",
		Attachment0 = {Part = "Torso", Name = "Right Hip_RagdollA0"},
		Attachment1 = {Part = "Right Leg", Name = "Right Hip_RagdollA1"},
		UpperAngle = 50,
		TwistLowerAngle = -30,
		TwistUpperAngle = 30,
	},
	{
		Name = "Left Shoulder_Ragdoll",
		ParentPart = "Torso",
		Attachment0 = {Part = "Torso", Name = "Left Shoulder_RagdollA0"},
		Attachment1 = {Part = "Left Arm", Name = "Left Shoulder_RagdollA1"},
		UpperAngle = 70,
		TwistLowerAngle = -45,
		TwistUpperAngle = 45,
	},
	{
		Name = "Right Shoulder_Ragdoll",
		ParentPart = "Torso",
		Attachment0 = {Part = "Torso", Name = "Right Shoulder_RagdollA0"},
		Attachment1 = {Part = "Right Arm", Name = "Right Shoulder_RagdollA1"},
		UpperAngle = 70,
		TwistLowerAngle = -45,
		TwistUpperAngle = 45,
	},
	{
		Name = "RootJoint_Ragdoll",
		ParentPart = "HumanoidRootPart",
		Attachment0 = {Part = "HumanoidRootPart", Name = "RootJoint_RagdollA0"},
		Attachment1 = {Part = "Torso", Name = "RootJoint_RagdollA1"},
		UpperAngle = 15,
		TwistLowerAngle = -10,
		TwistUpperAngle = 10,
	},
}

local DEFAULT_DURATION = 3
local DEFAULT_KNOCKBACK = Vector3.new(0, 30, 0)

local humanoid = character:FindFirstChildOfClass("Humanoid")
local activeToken = 0
local lastRequestToken = character:GetAttribute("RagdollRequestToken") or 0

local function getPart(partName)
	local part = character:FindFirstChild(partName)
	if not part or not part:IsA("BasePart") then
		return nil
	end
	return part
end

local function clearRagdollObjects()
	for _, definition in ipairs(ATTACHMENTS) do
		local part = getPart(definition.Part)
		if part then
			local existing = part:FindFirstChild(definition.Name)
			if existing and existing:IsA("Attachment") then
				existing:Destroy()
			end
		end
	end

	for _, definition in ipairs(CONSTRAINTS) do
		local part = getPart(definition.ParentPart)
		if part then
			local existing = part:FindFirstChild(definition.Name)
			if existing and existing:IsA("BallSocketConstraint") then
				existing:Destroy()
			end
		end
	end
end

local function buildAttachment(definition)
	local part = getPart(definition.Part)
	if not part then
		return nil
	end

	local attachment = Instance.new("Attachment")
	attachment.Name = definition.Name
	attachment.CFrame = definition.CFrame
	attachment.Parent = part
	return attachment
end

local function buildConstraint(definition)
	local parentPart = getPart(definition.ParentPart)
	local attachment0Part = getPart(definition.Attachment0.Part)
	local attachment1Part = getPart(definition.Attachment1.Part)
	if not parentPart or not attachment0Part or not attachment1Part then
		return
	end

	local attachment0 = attachment0Part:FindFirstChild(definition.Attachment0.Name)
	local attachment1 = attachment1Part:FindFirstChild(definition.Attachment1.Name)
	if not attachment0 or not attachment1 then
		return
	end

	local constraint = Instance.new("BallSocketConstraint")
	constraint.Name = definition.Name
	constraint.Attachment0 = attachment0
	constraint.Attachment1 = attachment1
	constraint.Enabled = false
	constraint.LimitsEnabled = true
	constraint.TwistLimitsEnabled = true
	constraint.UpperAngle = definition.UpperAngle
	constraint.TwistLowerAngle = definition.TwistLowerAngle
	constraint.TwistUpperAngle = definition.TwistUpperAngle
	constraint.Restitution = 0.08
	constraint.Radius = 0.15
	constraint.MaxFrictionTorque = 0
	constraint.Parent = parentPart
end

local function setRagdollEnabled(enabled)
	if not humanoid then
		return
	end

	for motorName, info in pairs(MOTOR_NAMES) do
		local part = getPart(info.Part)
		if part then
			local motor = part:FindFirstChild(motorName)
			if motor and motor:IsA("Motor6D") then
				motor.Enabled = not enabled
			end

			local constraint = part:FindFirstChild(info.Constraint)
			if constraint and constraint:IsA("BallSocketConstraint") then
				constraint.Enabled = enabled
			end
		end
	end

	humanoid.PlatformStand = enabled
	humanoid.AutoRotate = not enabled
	if enabled then
		pcall(function()
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end)
	else
		pcall(function()
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end)
	end
end

local function triggerRagdoll(knockbackVector, duration)
	if not humanoid or humanoid.Health <= 0 then
		return false
	end

	local rootPart = getPart("HumanoidRootPart")
	if not rootPart then
		return false
	end

	activeToken += 1
	local token = activeToken
	setRagdollEnabled(true)
	rootPart.AssemblyLinearVelocity = typeof(knockbackVector) == "Vector3" and knockbackVector or DEFAULT_KNOCKBACK

	task.delay(type(duration) == "number" and duration or DEFAULT_DURATION, function()
		if token ~= activeToken or not character.Parent then
			return
		end
		setRagdollEnabled(false)
	end)

	return true
end

local function processAttributeRequest()
	local requestToken = character:GetAttribute("RagdollRequestToken") or 0
	if requestToken == 0 or requestToken == lastRequestToken then
		return
	end
	lastRequestToken = requestToken
	triggerRagdoll(Vector3.new(
		tonumber(character:GetAttribute("RagdollKnockbackX")) or DEFAULT_KNOCKBACK.X,
		tonumber(character:GetAttribute("RagdollKnockbackY")) or DEFAULT_KNOCKBACK.Y,
		tonumber(character:GetAttribute("RagdollKnockbackZ")) or DEFAULT_KNOCKBACK.Z
		), tonumber(character:GetAttribute("RagdollDuration")) or DEFAULT_DURATION)
end

local function setupRagdoll()
	if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		return
	end

	for partName in pairs(REQUIRED_PARTS) do
		if not getPart(partName) then
			return
		end
	end

	clearRagdollObjects()

	for _, definition in ipairs(ATTACHMENTS) do
		buildAttachment(definition)
	end

	for _, definition in ipairs(CONSTRAINTS) do
		buildConstraint(definition)
	end
end

character:GetAttributeChangedSignal("RagdollRequestToken"):Connect(processAttributeRequest)
setupRagdoll()
processAttributeRequest()