-- Generated from animations/Workspace/Rake animations/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9683529, 0.2495851, 0, -0.2495851, 0.9683529), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0, 0.0000002, 0, 0.9515845, -0.3073872, 0, 0.3059667, 0.9471869, 0.0960277, -0.0295177, -0.0913785, 0.9953787), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000001, 0.0000003, 0.0000001, 0.9515845, 0.3073872, 0, -0.3062015, 0.947914, 0.0877477, 0.0269725, -0.0834994, 0.9961427), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.9380843, 0.3392409, 0.4332699, -0.2989807, 0.4585611, -0.8368585, -0.9429773, -0.2764266, 0.1854239, -0.1463017, 0.8445769, 0.5150589), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.4035267, -0.1805393, 0.7768945, -0.5963842, -0.2498174, 0.762835, 0.7885955, -0.3597113, 0.4987234, 0.1498106, 0.8989989, 0.4115309), EasingDirection = Enum.PoseEasingDirection.Out })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9717276, -0.2104432, 0.1070475, 0.2286329, 0.9518621, -0.2041703, -0.0589282, 0.2228725, 0.973065), EasingDirection = Enum.PoseEasingDirection.Out })
					I[12] = new("Pose", I[11], "Left Leg", { CFrame = CFrame.new(0, -0.0000002, 0, 0.9185731, 0.395251, 0, -0.395251, 0.9185731, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[11], "Right Leg", { CFrame = CFrame.new(0, -0.0000001, 0.0000001, 0.9824492, -0.1865299, -0.0000164, 0.1858143, 0.9786723, 0.0875987, -0.0163237, -0.0860644, 0.9961559), EasingDirection = Enum.PoseEasingDirection.Out })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9323511, 0.3453437, 0.1070475, -0.3193237, 0.9253901, -0.2041703, -0.1695696, 0.1561756, 0.9730649), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[16], "Left Leg", { CFrame = CFrame.new(0, 0, 0.0000001, 0.911682, 0.4108775, 0.0039596, -0.4108277, 0.9113104, 0.027091, 0.0075227, -0.0263251, 0.9996251), EasingDirection = Enum.PoseEasingDirection.Out })
					I[18] = new("Pose", I[16], "Right Leg", { CFrame = CFrame.new(0, -0.0000002, 0, 0.9911404, -0.132818, 0, 0.132818, 0.9911404, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[21] = new("Pose", I[20], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9658916, 0.0673509, 0.2500345, -0.1269851, 0.9647059, 0.2306886, -0.2256726, -0.2545708, 0.940354), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[21], "Left Leg", { CFrame = CFrame.new(0, -0.0000006, 0.0000001, 0.9942585, -0.1068445, 0.0058565, 0.1063701, 0.9928313, 0.0545081, -0.0116384, -0.0535722, 0.9984962), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[21], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.935536, 0.3532314, 0, -0.3532314, 0.935536, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9683529, 0.2495851, 0, -0.2495851, 0.9683529), EasingDirection = Enum.PoseEasingDirection.Out })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(0, 0.0000002, 0, 0.9515845, -0.3073872, 0, 0.3059667, 0.9471869, 0.0960277, -0.0295177, -0.0913785, 0.9953787), EasingDirection = Enum.PoseEasingDirection.Out })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(0.0000001, 0.0000003, 0.0000001, 0.9515845, 0.3073872, 0, -0.3062015, 0.947914, 0.0877477, 0.0269725, -0.0834994, 0.9961427), EasingDirection = Enum.PoseEasingDirection.Out })
					I[29] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(0.9380843, 0.3392409, 0.4332699, -0.2989807, 0.4585611, -0.8368585, -0.9429773, -0.2764266, 0.1854239, -0.1463017, 0.8445769, 0.5150589), EasingDirection = Enum.PoseEasingDirection.Out })
					I[30] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(-0.4035267, -0.1805393, 0.7768945, -0.5963842, -0.2498174, 0.762835, 0.7885955, -0.3597113, 0.4987234, 0.1498106, 0.8989989, 0.4115309), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
