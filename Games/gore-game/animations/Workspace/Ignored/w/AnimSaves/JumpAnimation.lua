-- Generated from animations/Workspace/Ignored/w/AnimSaves/JumpAnimation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "JumpAnimation", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.057098, -0.2769462, 1, 0, 0, 0, 0.9794071, -0.2018956, 0, 0.2018956, 0.9794071) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.4900109, 0.3355141, 0, 0.9913467, 0.1312698, 0, -0.1312698, 0.9913467, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.8809386, 0.4732306, 0, -0.4732306, 0.8809386, 0, 0, 0, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9838111, -0.1783524, -0.0174931, 0.1792083, 0.9791262, 0.0958979, 0.0000243, -0.0974803, 0.9952375) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0, -0.0000002, 0, 0.9935893, 0.1127965, 0.0075705, -0.1130503, 0.9913645, 0.0664538, -0.0000094, -0.0668837, 0.9977608) })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9888105, 0.149177, 0, -0.149177, 0.9888105) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0.0542923, 0.3284624, 1, 0, 0, 0, 0.9999892, -0.0046614, 0, 0.0046614, 0.9999892) })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0.0088561, -0.04015, 0, 0.960792, -0.2772702, 0, 0.2772702, 0.960792, 0, 0, 0, 1) })
					I[14] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.0000001, 0, 0, 0.9838146, -0.1442287, -0.1063338, 0.1791893, 0.7918752, 0.5838022, 0.0000021, -0.593407, 0.8049026) })
					I[15] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9935854, 0.1018096, 0.0492221, -0.1130841, 0.8945512, 0.4324237, -0.0000068, -0.4352161, 0.9003261) })
					I[16] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0.0015539, -0.0083318, 1, 0, 0, 0, 0.9999712, 0.0075963, 0, -0.0075963, 0.9999712), EasingDirection = Enum.PoseEasingDirection.Out })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("Pose", I[18], "Torso", { CFrame = CFrame.new(0, 0.0542923, 0.3284621, 1, 0, 0, 0, 0.9878883, 0.1551666, 0, -0.1551666, 0.9878883) })
					I[20] = new("Pose", I[19], "Left Leg", { CFrame = CFrame.new(-0.3485293, 0.584815, 0, 0.960792, -0.2772702, 0, 0.2772702, 0.960792, 0, 0, 0, 1) })
					I[21] = new("Pose", I[19], "Right Leg", { CFrame = CFrame.new(0.6041154, 0.54602, 0, 0.8809386, 0.4732306, 0, -0.4732306, 0.8809386, 0, 0, 0, 1) })
					I[22] = new("Pose", I[19], "Left Arm", { CFrame = CFrame.new(-0.0000001, 0.0000004, -0.0000004, 0.9838206, -0.1124557, -0.1394661, 0.1791566, 0.6174545, 0.7659327, -0.0000196, -0.7785265, 0.6276116) })
					I[23] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(0, 0.0000001, 0.0000001, 0.9935854, 0.0757546, 0.0839598, -0.1130841, 0.6655071, 0.7377752, 0.000014, -0.7425373, 0.6698048) })
					I[24] = new("Pose", I[19], "Head", { CFrame = CFrame.new(0, 0, -0.0000001, 1, 0, 0, 0, 0.9741117, -0.2260673, 0, 0.2260673, 0.9741117) })
		I[25] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[26] = new("Pose", I[25], "HumanoidRootPart", { Weight = 0 })
				I[27] = new("Pose", I[26], "Torso", { Weight = 0 })
					I[28] = new("Pose", I[27], "Left Leg", { CFrame = CFrame.new(-0.3485292, 0.5848143, 0, 0.9947682, -0.1021577, 0, 0.1021577, 0.9947682, 0, 0, 0, 1) })
					I[29] = new("Pose", I[27], "Right Leg", { CFrame = CFrame.new(0.6041154, 0.5460199, 0, 0.9657491, 0.2594776, 0, -0.2594776, 0.9657491, 0, 0, 0, 1) })
					I[30] = new("Pose", I[27], "Left Arm", { CFrame = CFrame.new(0, 0.0000007, -0.0000007, 0.8989695, 0.4049391, -0.1669677, -0.0094358, 0.3990103, 0.9168979, 0.4379096, -0.8226877, 0.362519) })
					I[31] = new("Pose", I[27], "Right Arm", { CFrame = CFrame.new(0.0000001, 0.0000005, 0.0000001, 0.9541813, 0.2802133, 0.1049694, -0.1988414, 0.3316261, 0.9222181, 0.2236072, -0.9008355, 0.3721494) })
					I[32] = new("Pose", I[27], "Head", { CFrame = CFrame.new(0, 0, -0.0000002, 1, 0, 0, 0, 0.9882086, -0.1531135, 0, 0.1531135, 0.9882086), EasingDirection = Enum.PoseEasingDirection.Out })
		I[33] = new("Keyframe", I[1], "KF0.4", { Time = 0.4 })
			I[34] = new("Pose", I[33], "HumanoidRootPart", { Weight = 0 })
				I[35] = new("Pose", I[34], "Torso", { CFrame = CFrame.new(0, 0.0542923, 0.3284622, 1, 0, 0, 0, 0.9990195, 0.0442723, 0, -0.0442723, 0.9990195) })
					I[36] = new("Pose", I[35], "Left Leg", { CFrame = CFrame.new(-0.3701984, 0.4601806, 0, 0.985216, 0.1713168, 0, -0.1713168, 0.985216, 0, 0, 0, 1) })
					I[37] = new("Pose", I[35], "Right Leg", { CFrame = CFrame.new(0.6041152, 0.5460194, 0, 0.966736, -0.2557762, 0, 0.2557762, 0.966736, 0, 0, 0, 1) })
					I[38] = new("Pose", I[35], "Left Arm", { CFrame = CFrame.new(0, 0.0000005, -0.0000007, 0.7579349, 0.6305977, -0.1669772, -0.1158063, 0.3819757, 0.916888, 0.6419685, -0.6756043, 0.3625399) })
					I[39] = new("Pose", I[35], "Right Arm", { CFrame = CFrame.new(0.0000004, 0.0000007, -0.0000004, 0.8314731, 0.5455628, 0.1049467, -0.2866796, 0.2595187, 0.9222065, 0.475886, -0.796876, 0.3721845) })
	return I[1]
end

return build
