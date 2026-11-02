-- Generated from animations/Workspace/Rake Player Animations/idle2/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
-- Animation pack: require(this)() returns the KeyframeSequence / Animation instances

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9984247, 0.0561082, 0, -0.0561082, 0.9984247), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0, 0.0000007, 0.0000001, 1, 0, 0, 0, 0.9989394, 0.046045, 0, -0.046045, 0.9989394), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 5 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9968411, -0.0794215, 0, 0.0794215, 0.9968411), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0, 0.0000012, 0, 0.9966559, 0.0815421, 0.0052978, -0.081714, 0.994559, 0.0646171, 0, -0.0648339, 0.9978961), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0, 0.0000011, 0.0000002, 0.9966559, -0.0814978, -0.0059405, 0.081714, 0.9940187, 0.0724554, 0, -0.0726985, 0.997354), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0, 0.0000005, -0.0000006, 1, 0, 0, 0, 0.9979004, 0.0647675, 0, -0.0647675, 0.9979004), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0, 0.0000002, -0.0000001, 1, 0, 0, 0, 0.9949309, 0.100561, 0, -0.100561, 0.9949309), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9886048, -0.1505342, 0, 0.1505342, 0.9886048), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 10 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9984247, 0.0561082, 0, -0.0561082, 0.9984247), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0, 0.0000007, 0.0000001, 1, 0, 0, 0, 0.9989394, 0.046045, 0, -0.046045, 0.9989394), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[20], "Left Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[20], "Right Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[20], "Head", { EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
