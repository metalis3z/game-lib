-- Generated from animations/Workspace/Rake animations/AnimSaves/Rake walk.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Rake walk", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.8660253, -0.5, 0, 0.5, 0.8660253) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000015, 0, 0.8660253, 0.5, 0, -0.5, 0.8660253, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0, 0.0000001, 0, 0.8660253, -0.5000002, 0, 0.5000002, 0.8660253, 0, 0, 0, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000001, -0.0000001, 0.0000003, 0.7660444, 0.6427876, 0, -0.6040227, 0.7198463, 0.3420201, 0.2198463, -0.2620026, 0.9396926) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0.0000003, 0.7660444, -0.6427876, 0, 0.6040227, 0.7198463, 0.3420201, -0.2198463, -0.2620026, 0.9396926) })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9991541, 0, 0.0411224, 0.0205612, 0.8660253, -0.499577, -0.035613, 0.5, 0.8652927) })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.0000082, -0.0000098, -0.0000613, 0.9892852, -0.1453466, -0.0137475, 0.1459953, 0.9848897, 0.0931507, -0.0000006, -0.0941591, 0.9955525) })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(-0.0000073, -0.000008, -0.0000611, 0.5396291, -0.8419028, -0.0000006, 0.8419026, 0.539629, 0, -0.0000003, 0.0000005, 0.9999954) })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0000083, -0.0000032, 0.0000607, 0.6664661, 0.7372127, 0.1110874, -0.725657, 0.6072761, 0.3234767, 0.1710088, -0.2961972, 0.9396883) })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0000098, -0.0000025, 0.0000601, 0.9229499, -0.3493592, -0.1615908, 0.384782, 0.8486304, 0.3629997, 0.0103124, -0.3972057, 0.9176667) })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.9848077, 0.1736481, 0, -0.1736481, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.8660253, -0.5, 0, 0.5, 0.8660253) })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000015, 0, 0.8660253, 0.5, 0, -0.5, 0.8660253, 0, 0, 0, 1) })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0, 0.0000001, 0, 0.8660253, -0.5000002, 0, 0.5000002, 0.8660253, 0, 0, 0, 1) })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(0.0000001, -0.0000001, 0.0000003, 0.7660444, 0.6427876, 0, -0.6040227, 0.7198463, 0.3420201, 0.2198463, -0.2620026, 0.9396926) })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0.0000003, 0.7660444, -0.6427876, 0, 0.6040227, 0.7198463, 0.3420201, -0.2198463, -0.2620026, 0.9396926) })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9990832, 0, -0.0428108, -0.0214054, 0.8660253, -0.4995418, 0.0370753, 0.5000002, 0.8652313) })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(0.0000033, -0.0000092, -0.0000317, 0.7499777, 0.6614628, 0.0000004, -0.6614627, 0.7499776, 0, 0.0000003, 0.0000002, 0.9999976) })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(0.0000064, -0.0000078, -0.000032, 0.9345303, 0.3551201, 0.0232877, -0.3558828, 0.9325274, 0.0611513, 0.0000003, -0.0654351, 0.9978544) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.0000048, -0.0000032, 0.0000319, 0.8938776, 0.37825, 0.240644, -0.4327802, 0.8681201, 0.2430399, -0.1169771, -0.321393, 0.9396904) })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.0000044, -0.0000029, 0.0000316, 0.7539448, -0.6173196, -0.2246855, 0.6569376, 0.7084762, 0.2578643, 0.0000003, -0.3420196, 0.9396903) })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, 0, 0.0000008, 0.9999994, 0, 0, 0, 0.9848077, 0.1736479, 0, -0.1736479, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
		I[34] = new("Keyframe", I[1], "KF0.89999997615814", { Time = 0.9 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.8660253, -0.5, 0, 0.5, 0.8660253) })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000015, 0, 0.8660253, 0.5, 0, -0.5, 0.8660253, 0, 0, 0, 1) })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0, 0.0000001, 0, 0.8660253, -0.5000002, 0, 0.5000002, 0.8660253, 0, 0, 0, 1) })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(0.0000001, -0.0000001, 0.0000003, 0.7660444, 0.6427876, 0, -0.6040227, 0.7198463, 0.3420201, 0.2198463, -0.2620026, 0.9396926) })
					I[40] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0.0000003, 0.7660444, -0.6427876, 0, 0.6040227, 0.7198463, 0.3420201, -0.2198463, -0.2620026, 0.9396926) })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999994, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926) })
	return I[1]
end

return build
