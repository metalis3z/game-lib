-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeIdle2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeIdle2", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000005, -0.0000007, 0, 0.7841091, 0.4923915, 0.3777875, -0.5212681, 0.8528762, -0.0296936, -0.3368269, -0.1736456, 0.9254161), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000003, -0.0000015, 0.0000006, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709956, 0.9151059), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000002, -0.0000001, 0.0000014, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774434, 0.2273441, -0.3045771, 0.9249577), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000007, 0.0000006, 0.8607451, -0.5070776, 0.0446091, 0.4554452, 0.8063037, 0.3774179, -0.2273486, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000002, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.0000002, -0.000001, 0.0000007, 0.8709813, 0.4819526, 0.0954622, -0.4819588, 0.8003709, 0.3565416, 0.095431, -0.3565499, 0.9293896), EasingDirection = Enum.PoseEasingDirection.Out })
				I[13] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(-0.0000003, -0.0000002, 0.0000008, 0.8560619, -0.445202, -0.2625892, 0.5127591, 0.7954614, 0.322985, 0.0650861, -0.4111401, 0.9092456), EasingDirection = Enum.PoseEasingDirection.Out })
				I[14] = new("Pose", I[11], "Head", { CFrame = CFrame.new(-0.0000001, 0.0000001, 0.0000009, 0.7162305, -0.6785187, -0.1631759, 0.6555414, 0.7343327, -0.1761274, 0.2393311, 0.0191792, 0.9707485), EasingDirection = Enum.PoseEasingDirection.Out })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[18] = new("Pose", I[17], "Left Leg", { CFrame = CFrame.new(0.0000007, -0.0000009, -0.000001, 0.8377951, 0.4923976, 0.2358893, -0.5185115, 0.8528723, 0.0612754, -0.1710116, -0.1736476, 0.969846), EasingDirection = Enum.PoseEasingDirection.Out })
					I[19] = new("Pose", I[17], "Right Leg", { CFrame = CFrame.new(0.0000002, -0.000001, -0.0000007, 0.914815, -0.3324431, -0.229336, 0.36729, 0.9209639, 0.1300896, 0.1679627, -0.2032408, 0.9646147), EasingDirection = Enum.PoseEasingDirection.Out })
					I[20] = new("Pose", I[17], "Left Arm", { CFrame = CFrame.new(-0.0000001, 0.0000004, 0.0000016, 0.9357297, 0.3368243, -0.1046868, -0.3084892, 0.9254165, 0.220088, 0.1710099, -0.1736482, 0.969846), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[17], "Right Arm", { CFrame = CFrame.new(-0.0000002, 0.0000001, 0.0000004, 0.9357296, -0.3368244, 0.104687, 0.3084891, 0.9254165, 0.2200881, -0.1710102, -0.1736483, 0.9698462), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[17], "Head", { CFrame = CFrame.new(0, 0, 0.0000006, 0.9396926, 0, 0.3420201, -0.0593912, 0.9848077, 0.1631759, -0.3368241, -0.1736481, 0.9254165), EasingDirection = Enum.PoseEasingDirection.Out })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[24] = new("Pose", I[23], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[25] = new("Pose", I[24], "Left Arm", { CFrame = CFrame.new(-0.0000002, -0.0000009, 0.0000002, 0.9832929, 0.1692196, 0.0670793, -0.1791496, 0.9649258, 0.1918944, -0.0322543, -0.2007056, 0.9791206), EasingDirection = Enum.PoseEasingDirection.Out })
				I[26] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(-0.0000002, -0.0000004, 0.0000008, 0.9567063, -0.1692194, -0.2368071, 0.2097498, 0.9649259, 0.1578701, 0.2017867, -0.2007057, 0.9586444), EasingDirection = Enum.PoseEasingDirection.Out })
				I[27] = new("Pose", I[24], "Head", { CFrame = CFrame.new(0.0000002, 0.0000003, 0.0000015, 0.8807054, 0.4736572, -0.0025981, -0.4447491, 0.8288165, 0.3395016, 0.1629607, -0.2978454, 0.9406017), EasingDirection = Enum.PoseEasingDirection.Out })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 1.8 })
			I[29] = new("Pose", I[28], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[30] = new("Pose", I[29], "Head", { CFrame = CFrame.new(0.0000058, -0.0000055, 0.0000017, 0.9845534, -0.0120621, -0.1746684, 0.0707369, 0.9399825, 0.3338101, 0.1601588, -0.3410094, 0.9263161), EasingDirection = Enum.PoseEasingDirection.Out })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[33] = new("Pose", I[32], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[34] = new("Pose", I[33], "Left Leg", { CFrame = CFrame.new(0.0000005, -0.0000007, 0, 0.7841091, 0.4923915, 0.3777875, -0.5212681, 0.8528762, -0.0296936, -0.3368269, -0.1736456, 0.9254161), EasingDirection = Enum.PoseEasingDirection.Out })
					I[35] = new("Pose", I[33], "Right Leg", { CFrame = CFrame.new(0.0000003, -0.0000015, 0.0000006, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709956, 0.9151059), EasingDirection = Enum.PoseEasingDirection.Out })
					I[36] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(0.0000002, -0.0000001, 0.0000014, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774434, 0.2273441, -0.3045771, 0.9249577), EasingDirection = Enum.PoseEasingDirection.Out })
					I[37] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000007, 0.0000006, 0.8607451, -0.5070776, 0.0446091, 0.4554452, 0.8063037, 0.3774179, -0.2273486, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out })
					I[38] = new("Pose", I[33], "Head", { CFrame = CFrame.new(0, 0, 0.0000002, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
