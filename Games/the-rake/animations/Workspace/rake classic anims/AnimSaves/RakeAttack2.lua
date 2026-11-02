-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeAttack2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeAttack2", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396927, -0.3420199, 0, 0.3420199, 0.9396927), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000005, 0.0000004, 0.000006, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000036, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9333167, -0.3434532, -0.1046871, 0.3302789, 0.9355842, -0.1248919, 0.1408381, 0.0819877, 0.9866318), EasingDirection = Enum.PoseEasingDirection.Out })
					I[11] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0.0000067, 0.0141761, -0.074652, 0.9971088, -0.7721632, -0.634374, -0.0365166, 0.6352658, -0.7694126, -0.0666364), EasingDirection = Enum.PoseEasingDirection.Out })
					I[12] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000038, 0.0000007, -0.0045687, -0.9220464, 0.3870521, 0.814633, 0.2210473, 0.5362011, -0.5799592, 0.3177551, 0.7501193), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[10], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0000009, 0.9838627, 0.1763583, -0.0301945, -0.1765083, 0.9842963, -0.0023529, 0.0293054, 0.0076445, 0.9995411), EasingDirection = Enum.PoseEasingDirection.Out })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8594975, -0.4745245, -0.1899735, 0.4877235, 0.8725792, 0.0270407, 0.1529354, -0.115896, 0.9814166), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0.0000067, 0.0141761, -0.074652, 0.9971088, -0.7721632, -0.634374, -0.0365166, 0.6352658, -0.7694126, -0.0666364), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000038, 0.0000007, -0.0045687, -0.9220464, 0.3870521, 0.814633, 0.2210473, 0.5362011, -0.5799592, 0.3177551, 0.7501193), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[16], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0000009, 0.9995399, 0.0028332, -0.0301945, -0.0029056, 0.9999929, -0.0023529, 0.0301876, 0.0024395, 0.9995411), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000002, 0, 0.0000002, 0.8660253, -0.5, 0.0000001, 0.4999999, 0.8660254), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(0.0000007, -0.0000005, 0.0000076, -0.5188051, 0.8531939, 0.0538595, 0.0921659, -0.0068129, 0.9957201, 0.8499091, 0.5215484, -0.0751009), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000036, 0.0000007, 0.718127, 0.4065376, -0.5648192, -0.2945851, 0.9129043, 0.2825336, 0.6304862, -0.0365081, 0.7753411), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[22], "Head", { CFrame = CFrame.new(0.0045307, 0.0010883, -0.0050851, 0.9963679, 0.0846243, -0.0094692, -0.0732596, 0.9085767, 0.4112436, 0.0434047, -0.4090562, 0.9114763), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8660254, 0.4999998, 0, -0.4330124, 0.75, -0.5, -0.2499999, 0.4330127, 0.8660254), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.0000008, -0.0000005, 0.0000077, -0.4345653, 0.7020934, -0.5641075, -0.8200896, -0.0495564, 0.5700848, 0.3722976, 0.7103575, 0.5973148), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000036, 0.0000007, 0.718127, 0.4065376, -0.5648192, -0.2945851, 0.9129043, 0.2825336, 0.6304862, -0.0365081, 0.7753411), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[31] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.0045307, 0.0010883, -0.005085, 0.9643874, -0.2565193, 0.0644573, 0.231682, 0.9368454, 0.262, -0.1275946, -0.2377359, 0.9629128), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[32] = new("Keyframe", I[1], "KF0.64999997615814", { Time = 0.65 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396927, -0.3420199, 0, 0.3420199, 0.9396927), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[35] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(0.0000005, 0.0000004, 0.000006, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[36] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000036, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[34], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
