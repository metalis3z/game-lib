-- Generated from animations/Workspace/Rake Player Animations/idle1/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000082, 0.0471018, -0.002672, 1, 0.0001743, 0.0000099, -0.0001746, 0.9983944, 0.0566457, 0, -0.0566457, 0.9983944), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(-0.0000093, 0.0530007, -0.0026523, 1, -0.0001744, -0.0000087, 0.0001746, 0.9987502, 0.0499807, 0, -0.0499807, 0.9987502), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 1.113 })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 7.5 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9976138, -0.069041, 0, 0.069041, 0.9976138), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[13], "Left Leg", { CFrame = CFrame.new(0.0020079, 0.0310125, -0.0020012, 0.9953089, 0.0966513, 0.0043211, -0.0967291, 0.9932436, 0.0641149, 0.0019048, -0.0642321, 0.9979331), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[13], "Right Leg", { CFrame = CFrame.new(-0.0019994, 0.0391034, -0.002293, 0.9972681, -0.073788, -0.0034053, 0.0738603, 0.9955254, 0.0589387, -0.0009589, -0.0590292, 0.9982558), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-0.0000038, 0.0000189, -0.000011, 0.9999981, -0.0002866, 0.0019166, -0.0000482, 0.9850201, 0.1724397, -0.0019373, -0.1724395, 0.9850182), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0, 0.0000205, -0.000004, 0.9999951, 0.0005486, -0.0030714, 0.0001268, 0.9764656, 0.215673, 0.0031175, -0.2156723, 0.9764608), EasingDirection = Enum.PoseEasingDirection.Out })
					I[18] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0, 0.0027601, 0.0015602, 1, 0, 0, 0, 0.9997901, 0.020486, 0, -0.020486, 0.9997901), EasingDirection = Enum.PoseEasingDirection.Out })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 15 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[21] = new("Pose", I[20], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[21], "Left Leg", { CFrame = CFrame.new(0.0000082, 0.0471018, -0.002672, 1, 0.0001743, 0.0000099, -0.0001746, 0.9983944, 0.0566457, 0, -0.0566457, 0.9983944), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[21], "Right Leg", { CFrame = CFrame.new(-0.0000093, 0.0530007, -0.0026523, 1, -0.0001744, -0.0000087, 0.0001746, 0.9987502, 0.0499807, 0, -0.0499807, 0.9987502), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[21], "Left Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[21], "Right Arm", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[26] = new("Pose", I[21], "Head", { EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
