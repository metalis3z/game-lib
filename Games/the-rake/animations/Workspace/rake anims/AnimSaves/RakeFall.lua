-- Generated from animations/Workspace/rake anims/AnimSaves/RakeFall.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeFall", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, -1.1449027, 0.2217948, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.000004, -0.0000006, 0.6427876, -0.7660444, 0, 0.7198462, 0.6040226, 0.3420201, -0.2620026, -0.2198462, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000006, -0.0000039, -0.0000007, 0.7660444, 0.6427877, 0, -0.6040227, 0.7198461, 0.3420201, 0.2198463, -0.2620026, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0000004, -0.0000008, 0.0000008, 0.599729, 0.7817165, -0.17101, -0.6477419, 0.5997289, 0.4698463, 0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0000001, -0.0000008, 0.0000018, 0.5997289, -0.7817165, 0.17101, 0.6477419, 0.5997289, 0.4698463, -0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018949, 1, 0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(-0.0000003, -1.1449013, 0.2217946, 0.9981492, -0.0013519, 0.0607955, 0.0237646, 0.928921, -0.3695142, -0.0559746, 0.3702752, 0.927234), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0.0000003, -0.0000042, -0.0000007, 0.7660443, -0.6427878, 0, 0.6040229, 0.719846, 0.3420201, -0.2198464, -0.2620025, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.0000005, -0.0000042, -0.0000006, 0.6427875, 0.7660445, 0, -0.7198462, 0.6040226, 0.3420201, 0.2620026, -0.2198462, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.0000002, -0.0000007, 0.0000012, 0.7263614, 0.6656986, -0.17101, -0.5337594, 0.7030969, 0.4698463, 0.4330127, -0.25, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0000006, -0.000001, 0.0000019, 0.4548741, -0.8739823, 0.17101, 0.7420431, 0.4781385, 0.4698463, -0.4924038, -0.0868241, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018949, 0.9962719, 0, 0.0862686, 0.0075188, 0.9961947, -0.0868308, -0.0859403, 0.0871557, 0.9924808), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, -1.1449027, 0.2217948, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.000004, -0.0000006, 0.6427876, -0.7660444, 0, 0.7198462, 0.6040226, 0.3420201, -0.2620026, -0.2198462, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0.0000006, -0.0000039, -0.0000007, 0.7660444, 0.6427877, 0, -0.6040227, 0.7198461, 0.3420201, 0.2198463, -0.2620026, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.0000005, -0.0000008, 0.0000008, 0.599729, 0.7817165, -0.17101, -0.6477419, 0.5997289, 0.4698463, 0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.0000001, -0.0000008, 0.0000018, 0.5997289, -0.7817165, 0.17101, 0.6477419, 0.5997289, 0.4698463, -0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018949, 1, 0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(-0.0000001, -1.1449009, 0.2217954, 0.9983199, 0.0007869, -0.0579357, -0.022183, 0.9289141, -0.3696297, 0.0535264, 0.370294, 0.9273711), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(-0.0000005, -0.0000024, 0.0000004, 0.4999999, -0.8660254, 0, 0.8137977, 0.4698462, 0.3420202, -0.2961982, -0.17101, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(0.0000007, -0.0000046, -0.0000004, 0.8660254, 0.5000001, 0, -0.4698463, 0.8137975, 0.3420201, 0.1710101, -0.296198, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.0000002, -0.0000003, 0.0000006, 0.4548742, 0.8739823, -0.17101, -0.7420431, 0.4781386, 0.4698463, 0.4924038, -0.0868241, 0.8660254), EasingDirection = Enum.PoseEasingDirection.Out })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0, 0, 0.0000002, 0.7263612, -0.6656989, 0.1710101, 0.5337597, 0.7030968, 0.4698464, -0.4330128, -0.2499999, 0.8660254), EasingDirection = Enum.PoseEasingDirection.Out })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018945, 0.9973803, 0, -0.0723358, -0.0063045, 0.9961947, -0.0869274, 0.0720605, 0.0871557, 0.9935849), EasingDirection = Enum.PoseEasingDirection.Out })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, -1.1449027, 0.2217948, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.000004, -0.0000006, 0.6427876, -0.7660444, 0, 0.7198462, 0.6040226, 0.3420201, -0.2620026, -0.2198462, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0.0000006, -0.0000039, -0.0000007, 0.7660444, 0.6427877, 0, -0.6040227, 0.7198461, 0.3420201, 0.2198463, -0.2620026, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(-0.0000004, -0.0000008, 0.0000008, 0.599729, 0.7817165, -0.17101, -0.6477419, 0.5997289, 0.4698463, 0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[40] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(0.0000001, -0.0000008, 0.0000018, 0.5997289, -0.7817165, 0.17101, 0.6477419, 0.5997289, 0.4698463, -0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018949, 1, 0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
