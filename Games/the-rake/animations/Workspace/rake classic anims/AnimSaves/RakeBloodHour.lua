-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeBloodHour.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeBloodHour", { Loop = false }, nil, { "1595939955" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000033, -0.0000011, -0.0000003, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0000002, 0.000004, 0.0000002, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000018, -0.0000038, 0.0000021, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000006, 0.0000011, 0.0000075, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -2.1868575, -0.632909, 1, 0, 0, 0, 0.34202, -0.9396926, 0, 0.9396926, 0.34202), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.5048661, 0.7840887, 0.0230024, 0.3317151, 0.9412915, 0.0627305, -0.925622, 0.3119098, 0.2143276, 0.1821786, -0.1291603, 0.9747454), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0000002, 0.0000034, 0.0000008, 0.0036102, -0.899672, -0.4365511, 0.9482194, -0.1355686, 0.2872302, -0.3175957, -0.4149831, 0.852597), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[15] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0.0000001, -0.0000002, 1, 0, 0, 0, 0.7660444, -0.6427877, 0, 0.6427877, 0.7660444), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[16] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.4960158, 0.8158687, -0.1052586, 0.3459973, -0.9363539, -0.0593891, 0.9287595, 0.3328423, 0.1631615, -0.1330098, -0.1116117, 0.9848104), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0000003, 0.0000007, 0.0000075, -0.008741, 0.8874298, 0.4608597, -0.9259912, -0.1811455, 0.3312498, 0.3774436, -0.4238565, 0.8233353), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 28.7000008 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, -1.2935821, -0.2571151, 1, 0, 0, 0, 0.7660444, 0.6427876, 0, -0.6427876, 0.7660444), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(0.0259834, 0.2781066, -0.0445133, 0.7678214, -0.6379052, -0.0593912, 0.6379052, 0.752629, 0.1631759, -0.0593912, -0.1631759, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0, -0.0000002, 0.0000002, 0.7071067, 0.3535534, -0.6123723, 0, 0.8660254, 0.5, 0.7071068, -0.3535534, 0.6123725), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.7660443, 0.6427878, 0, -0.6427878, 0.7660443), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(-0.0259835, 0.2781064, -0.0445132, 0.7678214, 0.6379051, 0.0593912, -0.6379051, 0.7526292, 0.1631759, 0.0593912, -0.1631759, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(0.0000002, -0.0000003, 0.0000002, 0.7071067, -0.3535536, 0.6123723, 0.0000003, 0.8660253, 0.5, -0.7071069, -0.3535531, 0.6123725), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "KF30", { Time = 30 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, -1.2935821, -0.2571151, 1, 0, 0, 0, 0.7660444, 0.6427876, 0, -0.6427876, 0.7660444) })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(0.0259834, 0.2781066, -0.0445133, 0.7678214, -0.6379052, -0.0593912, 0.6379052, 0.752629, 0.1631759, -0.0593912, -0.1631759, 0.9848077) })
					I[30] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0, -0.0000002, 0.0000002, 0.7071067, 0.3535534, -0.6123723, 0, 0.8660254, 0.5, 0.7071068, -0.3535534, 0.6123725) })
					I[31] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.7660443, 0.6427878, 0, -0.6427878, 0.7660443) })
					I[32] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(-0.0259835, 0.2781064, -0.0445132, 0.7678214, 0.6379051, 0.0593912, -0.6379051, 0.7526292, 0.1631759, 0.0593912, -0.1631759, 0.9848077) })
					I[33] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.0000002, -0.0000003, 0.0000002, 0.7071067, -0.3535536, 0.6123723, 0.0000003, 0.8660253, 0.5, -0.7071069, -0.3535531, 0.6123725) })
	return I[1]
end

return build
