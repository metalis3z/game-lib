-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeJump.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeJump", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1595948325" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.068404, 0.1879385, 1, 0, 0, 0, 0.9396927, -0.3420199, 0, 0.3420199, 0.9396927), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0, -0.0000024, -0.0000005, 0.9999999, 0, 0, 0, 0.9396925, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0, -0.0000027, -0.0000005, 0.9999999, 0.0000002, 0, -0.0000002, 0.9396925, 0.3420201, 0.0000001, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.0000001, -0.0000004, 0.0000004, 0.9396926, -0.2961982, -0.17101, 0.3420202, 0.8137977, 0.4698463, 0, -0.5, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0000001, -0.0000004, 0.0000004, 0.9396926, 0.2961982, 0.17101, -0.3420202, 0.8137977, 0.4698463, 0, -0.5, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018953, 1, 0, 0, 0, 0.9659258, 0.258819, 0, -0.258819, 0.9659258), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, -0.4999995, 0.8660245, 1, 0, 0, 0, 0.8660253, -0.4999999, 0, 0.4999999, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.0000001, -0.0000015, -0.0000012, 0.8660253, -0.5000002, 0, 0.4330128, 0.7499999, 0.4999999, -0.2500001, -0.4330126, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0, -0.0000025, -0.0000015, 0.8660254, 0.5, 0, -0.4698463, 0.8137975, 0.3420201, 0.17101, -0.2961981, 0.9396925), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(0.0000005, -0.0000013, 0.0000007, -0.5385923, 0.8415453, -0.0414669, -0.8404652, -0.5331246, 0.0969327, 0.0594663, 0.0870588, 0.9944266), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(-0.0000002, -0.0000011, 0.0000005, -0.5033401, -0.8620449, -0.0593914, 0.8568488, -0.4890639, -0.1631759, 0.1116187, -0.1330225, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0.0000007, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, -1.1449035, 0.2217952, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000024, -0.0000005, 0.6427876, -0.7660444, 0, 0.7198462, 0.6040226, 0.3420201, -0.2620026, -0.2198462, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(0.0000002, -0.0000024, -0.0000005, 0.7660444, 0.6427877, 0, -0.6040227, 0.7198461, 0.3420201, 0.2198463, -0.2620026, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.0000003, -0.0000005, 0.0000005, 0.599729, 0.7817165, -0.17101, -0.6477419, 0.5997289, 0.4698463, 0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.0000001, -0.0000006, 0.000001, 0.5997289, -0.7817165, 0.17101, 0.6477419, 0.5997289, 0.4698463, -0.4698463, -0.1710101, 0.8660253), EasingDirection = Enum.PoseEasingDirection.Out })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, -0.0001659, -0.0018951, 1, 0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947), EasingDirection = Enum.PoseEasingDirection.Out })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, -0.7167413, -0.0792549, 1, 0, 0, 0, 0.7660443, -0.6427878, 0, 0.6427878, 0.7660443), EasingDirection = Enum.PoseEasingDirection.Out })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000002, 0, 0.7660444, 0.6427876, 0, -0.6427876, 0.7660444, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[40] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.7660444, 0.6427876, 0, -0.6427876, 0.7660444), EasingDirection = Enum.PoseEasingDirection.Out })
		I[42] = new("Keyframe", I[1], "KF0.64999997615814", { Time = 0.65 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[45] = new("Pose", I[44], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[46] = new("Pose", I[44], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[47] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[48] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[49] = new("Pose", I[44], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[51] = new("Pose", I[50], "HumanoidRootPart", { Weight = 0 })
				I[52] = new("Pose", I[51], "Torso", { CFrame = CFrame.new(0, -0.102606, 0.2819079, 1, 0, 0, 0, 0.9396927, -0.3420201, 0, 0.3420201, 0.9396927), EasingDirection = Enum.PoseEasingDirection.Out })
					I[53] = new("Pose", I[52], "Left Arm", { CFrame = CFrame.new(-0.0003201, 0.0008796, -0.0107015, 0.8799202, -0.4211984, -0.2198464, 0.4618243, 0.649519, 0.6040228, -0.1116191, -0.6330222, 0.7660444), EasingDirection = Enum.PoseEasingDirection.Out })
					I[54] = new("Pose", I[52], "Right Arm", { CFrame = CFrame.new(0.0003201, 0.0008796, -0.0107015, 0.8799202, 0.4211984, 0.2198464, -0.4618243, 0.649519, 0.6040228, 0.1116191, -0.6330222, 0.7660444), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
