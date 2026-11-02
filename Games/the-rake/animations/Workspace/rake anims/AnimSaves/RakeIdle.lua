-- Generated from animations/Workspace/rake anims/AnimSaves/RakeIdle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeIdle", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000015, -0.0000011, 0, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000012, -0.0000031, 0.0000013, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000004, 0.0000002, 0.0000041, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000025, 0.0000007, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[11] = new("Pose", I[10], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.0000006, -0.0000015, 0.0000009, 0.8709813, 0.4819526, 0.0954622, -0.4819588, 0.8003709, 0.3565416, 0.095431, -0.3565499, 0.9293896), EasingDirection = Enum.PoseEasingDirection.InOut })
				I[13] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(0, 0.0000002, 0.0000005, 0.8560619, -0.4452021, -0.2625892, 0.5127591, 0.7954614, 0.322985, 0.0650861, -0.4111401, 0.9092457), EasingDirection = Enum.PoseEasingDirection.InOut })
				I[14] = new("Pose", I[11], "Head", { CFrame = CFrame.new(-0.0000001, 0.0000002, 0.0000014, 0.9848077, -0.0593912, -0.1631759, 0.0301537, 0.9839053, -0.1761274, 0.17101, 0.1685312, 0.9707485), EasingDirection = Enum.PoseEasingDirection.Out })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[18] = new("Pose", I[17], "Left Leg", { CFrame = CFrame.new(0.0000013, -0.0000023, -0.0000023, 0.8626736, 0.4473816, 0.2358893, -0.4726611, 0.8791112, 0.0612754, -0.1799594, -0.1643564, 0.969846), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[17], "Right Leg", { CFrame = CFrame.new(0.0000009, -0.0000023, -0.0000019, 0.9047716, -0.2582103, -0.338697, 0.3025839, 0.9493661, 0.084539, 0.2997185, -0.1789728, 0.9370899), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[20] = new("Pose", I[17], "Left Arm", { CFrame = CFrame.new(-0.0000006, 0.0000009, 0.0000049, 0.9357297, 0.3368243, -0.1046868, -0.3084892, 0.9254165, 0.220088, 0.1710099, -0.1736482, 0.9698458), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[21] = new("Pose", I[17], "Right Arm", { CFrame = CFrame.new(-0.0000005, 0.000001, -0.0000007, 0.9357296, -0.3368244, 0.104687, 0.3084891, 0.9254165, 0.220088, -0.1710102, -0.1736483, 0.9698462), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[22] = new("Pose", I[17], "Head", { CFrame = CFrame.new(0.0000002, 0, 0.0000014, 0.9396926, 0, 0.3420201, -0.0593912, 0.9848077, 0.1631759, -0.3368241, -0.1736481, 0.9254165), EasingDirection = Enum.PoseEasingDirection.Out })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 2.25 })
			I[24] = new("Pose", I[23], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[25] = new("Pose", I[24], "Left Arm", { CFrame = CFrame.new(-0.0000005, -0.0000017, -0.0000005, 0.9832929, 0.1692196, 0.0670793, -0.1791496, 0.9649258, 0.1918944, -0.0322543, -0.2007056, 0.9791207), EasingDirection = Enum.PoseEasingDirection.InOut })
				I[26] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(-0.0000002, -0.0000005, 0.0000012, 0.9567063, -0.1692194, -0.2368072, 0.2097498, 0.9649259, 0.1578701, 0.2017867, -0.2007057, 0.9586444), EasingDirection = Enum.PoseEasingDirection.InOut })
				I[27] = new("Pose", I[24], "Head", { CFrame = CFrame.new(0.0000003, 0.0000004, 0.0000028, 0.9995418, -0.0301537, -0.0025981, 0.0292444, 0.9401507, 0.3395016, -0.0077947, -0.339422, 0.9406017), EasingDirection = Enum.PoseEasingDirection.Out })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 2.7 })
			I[29] = new("Pose", I[28], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[30] = new("Pose", I[29], "Head", { CFrame = CFrame.new(0.0000058, -0.0000054, 0.0000023, 0.9845534, -0.0120621, -0.1746684, 0.0707369, 0.9399825, 0.3338101, 0.1601588, -0.3410094, 0.9263161), EasingDirection = Enum.PoseEasingDirection.Out })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 3 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[33] = new("Pose", I[32], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[34] = new("Pose", I[33], "Left Leg", { CFrame = CFrame.new(0.0000008, -0.0000013, 0.0000001, 0.8576995, 0.3487521, 0.3777875, -0.3652487, 0.9304363, -0.0296936, -0.3618629, -0.1125183, 0.9254161), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[35] = new("Pose", I[33], "Right Leg", { CFrame = CFrame.new(0.0000012, -0.0000031, 0.0000013, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[36] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(0.0000004, 0.0000002, 0.0000041, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[37] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000025, 0.0000007, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[38] = new("Pose", I[33], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.InOut })
	return I[1]
end

return build
