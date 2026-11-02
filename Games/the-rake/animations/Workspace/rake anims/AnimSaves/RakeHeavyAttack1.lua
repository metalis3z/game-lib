-- Generated from animations/Workspace/rake anims/AnimSaves/RakeHeavyAttack1.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeHeavyAttack1", { Loop = false }, nil, { "1607980703" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000021, -0.0000013, -0.0000001, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000016, -0.0000041, 0.0000018, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000005, 0.0000004, 0.0000056, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000034, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0.0000001, -0.1742575, -0.1059917, 0.6427877, -0.7660443, 0, 0.719846, 0.6040229, -0.3420204, 0.2620027, 0.2198465, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0.0024238, 0.0145677, 0, 0.8919961, 0.314545, -0.3246602, -0.2955756, 0.9492425, 0.1075808, 0.3420204, 0, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.710779, 0.6476012, 0.0000001, 0.8919964, 0.3145444, -0.3246601, -0.2955751, 0.9492428, 0.1075805, 0.3420201, 0, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0000008, -0.0000014, -0.0000003, -0.3576137, -0.7516263, 0.5542295, -0.5323851, -0.3235063, -0.7822465, 0.7672539, -0.5748056, -0.2844644), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[16] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0012224, -0.0005625, -0.0089032, 0.8889617, 0.3291285, -0.3184676, -0.30761, 0.9442646, 0.1172201, 0.3392982, -0.0062403, 0.9406582), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0000001, 0.0000005, -0.0000008, 0.9098458, -0.3530496, 0.2180291, 0.02545, 0.5719292, 0.8199081, -0.4141655, -0.7404411, 0.5293524), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, -2.0845952, -0.1202252, 1, 0, 0, 0, 0.7660443, -0.6427878, 0, 0.6427878, 0.7660443), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.0000001, 0.0000002, 0, 0.8823345, -0.4706227, 0, 0.4706227, 0.8823345, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0.2845011, 0.2764031, 0.0000002, 0.6640038, -0.7477291, 0, 0.7477291, 0.6640038, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(0, -0.0000012, 0.0000003, -0.6140887, 0.7891887, -0.008747, -0.5549869, -0.4239171, 0.71574, 0.561146, 0.4443822, 0.698312), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, -0.0000001, 0.0000004, 0.9848077, -0.0301537, 0.1710101, -0.0301537, 0.9401507, 0.3394219, -0.1710101, -0.3394219, 0.9249585), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0, -0.0000009, 0.5906183, 0.248147, -0.7678496, -0.0323295, 0.9580566, 0.2847492, 0.8063031, -0.1433542, 0.5738683), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5333334 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, -2.6770103, -0.3324252, 1, 0, 0, 0, 0.716997, -0.6970762, 0, 0.6970762, 0.716997), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(0.0022886, 0.000063, 0.0026591, 0.4511909, -0.8211753, 0.3494254, 0.8809102, 0.4725111, -0.0270281, -0.1429125, 0.3200072, 0.9365743), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(0.1471719, 0.1568296, 0.016292, 0.8405781, -0.5408425, -0.0302992, 0.5322281, 0.8350106, -0.1396078, 0.100806, 0.1012252, 0.9897431), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.0000006, -0.0000027, 0.000002, -0.755728, 0.5549842, -0.347661, -0.4729582, -0.0953312, 0.8759121, 0.4529744, 0.8263803, 0.3345287), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, -0.0000002, 0.0000011, 0.9999999, 0, 0, 0, 0.7660445, 0.6427875, 0, -0.6427873, 0.7660445), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.0000011, 0.0000007, -0.0000019, 0.5739207, 0.3617496, -0.7346784, -0.1000866, 0.9214007, 0.375504, 0.8127717, -0.1419783, 0.565017), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.7333333 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.0000021, -0.0000013, -0.0000001, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0.0000016, -0.0000041, 0.0000018, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(0.0000005, 0.0000004, 0.0000056, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[40] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[41] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000034, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { Weight = 0 })
					I[45] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(0.0000003, -0.0000012, 0.0000015, -0.8221682, 0.1131315, 0.5578896, -0.3939292, -0.8205519, -0.4141425, 0.4109249, -0.5602638, 0.7191975), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[46] = new("Pose", I[44], "Head", { CFrame = CFrame.new(-0.0000001, -0.0001207, -0.0015932, 0.9396926, 0, -0.3420201, 0.0178999, 0.9986295, 0.0491797, 0.3415514, -0.0523359, 0.9384048), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[47] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0.0000001, 0.0000007, -0.000001, 0.772581, -0.2028431, 0.6016423, -0.3065141, 0.7106979, 0.6332122, -0.5560286, -0.6736195, 0.4868973), EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
