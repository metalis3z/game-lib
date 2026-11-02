-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeHeavyAttack2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeHeavyAttack2", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000024, -0.0000014, -0.0000001, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.000002, -0.0000048, 0.0000021, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000006, 0.0000005, 0.0000067, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000041, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679) })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(-0.1016041, -0.0087004, -0.0583744, 0.5080221, 0.820529, 0.2620026, -0.827785, 0.5491732, -0.1148061, -0.2380866, -0.1585578, 0.958214) })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0.2557467, 0.3492036, -0.0416887, 0.7368324, -0.0323887, 0.6752988, -0.2709299, 0.9009942, 0.3388305, -0.6194148, -0.43262, 0.6551069) })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(-0.1438552, -0.1947428, -0.0716311, 0.8884708, 0.3876175, -0.2457078, -0.441974, 0.8668763, -0.2306176, 0.1236069, 0.3134935, 0.9415111) })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.0667653, -0.0635345, 0.4199533, -0.4691881, -0.2312851, 0.8522732, -0.8391021, 0.4175807, -0.3486165, -0.275263, -0.8787112, -0.3899959) })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0000004, 0.0000006, -0.0000009, 0.0695081, -0.7747005, 0.6284965, 0.777244, 0.4369934, 0.4526903, -0.6253483, 0.4570295, 0.6325058) })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0012222, -0.0005625, -0.0089027, 0.697024, -0.6923172, -0.1866931, 0.690924, 0.5788275, 0.4331083, -0.1917852, -0.4308777, 0.8817952) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(-0.119458, -0.3340918, -0.0924787, 0.7580218, 0.5972916, 0.2620026, -0.5900356, 0.7991729, -0.1148061, -0.2779582, -0.0675653, 0.958214), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.0561922, 0.3571604, 0.0769521, 0.7732127, 0.2915743, 0.5631396, -0.5427921, 0.7634755, 0.3499734, -0.3279003, -0.5762717, 0.7485934), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(-0.1438552, -0.1947427, -0.0716312, 0.942282, 0.2274473, -0.2457078, -0.2847279, 0.9304545, -0.2306176, 0.1761666, 0.2872667, 0.9415111), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.0988308, -0.1609072, 0.4223915, -0.4938548, -0.3487993, 0.7965214, -0.7915016, 0.5596091, -0.2456878, -0.3600449, -0.7517822, -0.5524411), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.4368665, -0.1223345, -0.2330234, -0.5627102, -0.6932894, 0.4502301, 0.6616645, -0.051252, 0.7480461, -0.4955373, 0.7188344, 0.487565), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0.0012223, -0.0005626, -0.0089027, 0.8917748, -0.4121691, -0.1866931, 0.4512855, 0.7802298, 0.4331083, -0.0328503, -0.4704869, 0.8817952), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(-0.0000001, -2.0845933, -0.1202251, 0.9249586, -0.3394217, -0.1710101, 0.2084427, 0.8292711, -0.5185178, 0.3178099, 0.4439617, 0.8377915), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(-0.6267787, 0.0496929, -0.0684041, 0.9917337, 0.0124353, -0.1277093, -0.0527303, 0.9468639, -0.3172824, 0.1169778, 0.3213938, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(0.2845008, 0.2764021, 0.0000001, 0.4401299, 0.8713019, -0.2170677, -0.8757039, 0.4699605, 0.1108137, 0.1985655, 0.1413146, 0.9698463), EasingDirection = Enum.PoseEasingDirection.Out })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.4224925, 0.4127827, -0.1053969, -0.0648304, 0.7041552, -0.7070804, -0.3086569, -0.6879739, -0.6568279, -0.9489616, 0.1756627, 0.261944) })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.196125, -0.1062482, -0.0713015, 0.6969464, 0.7100565, -0.1004263, -0.7152914, 0.6783128, -0.1680762, -0.0512231, 0.1889741, 0.9806449), EasingDirection = Enum.PoseEasingDirection.Out })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, -0.0000001, 0.0000004, 0.9646101, 0.2007056, 0.17101, -0.2032642, 0.9791204, -0.0025983, -0.1679609, -0.0322539, 0.9852659), EasingDirection = Enum.PoseEasingDirection.Out })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, -2.6365383, 0.0655218, 1, 0, 0, 0, 0.9948682, 0.1011798, 0, -0.1011798, 0.9948682), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.0130149, -0.1996217, -0.0007643, 0.9980614, -0.0536325, -0.031576, 0.0530557, 0.9984139, -0.0188275, 0.0325357, 0.0171158, 0.999324), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0.1471722, 0.1568284, 0.0162915, 0.8886723, 0.455851, 0.0496122, -0.4570264, 0.8893257, 0.0150506, -0.0372606, -0.0360491, 0.998655), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(-0.3344119, 0.2424285, -0.1714456, -0.1071946, 0.3757888, -0.9204848, -0.668395, -0.7126281, -0.2130935, -0.7360414, 0.5924049, 0.3275653), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[40] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(-0.0000014, 0.0000007, -0.0000024, 0.5349596, 0.1902566, -0.8231772, 0.2837889, 0.8772433, 0.3871791, 0.7957902, -0.4407341, 0.4152969), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, -0.0000004, 0.0000015, 0.9999999, 0, 0, 0, 0.9848077, 0.173648, 0, -0.1736479, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { CFrame = CFrame.new(0, -2.6365383, 0.0655218, 1, 0, 0, 0, 0.9948682, 0.1011798, 0, -0.1011798, 0.9948682), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[45] = new("Pose", I[44], "Left Leg", { CFrame = CFrame.new(0.0130149, -0.1996217, -0.0007643, 0.9980614, -0.0536325, -0.031576, 0.0530557, 0.9984139, -0.0188275, 0.0325357, 0.0171158, 0.999324), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[46] = new("Pose", I[44], "Right Leg", { CFrame = CFrame.new(0.1471722, 0.1568284, 0.0162915, 0.8886723, 0.455851, 0.0496122, -0.4570264, 0.8893257, 0.0150506, -0.0372606, -0.0360491, 0.998655), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[47] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(-0.3344119, 0.2424285, -0.1714456, -0.1071946, 0.3757888, -0.9204848, -0.668395, -0.7126281, -0.2130935, -0.7360414, 0.5924049, 0.3275653), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[48] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(-0.0000014, 0.0000007, -0.0000024, 0.5349596, 0.1902566, -0.8231772, 0.2837889, 0.8772433, 0.3871791, 0.7957902, -0.4407341, 0.4152969), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[49] = new("Pose", I[44], "Head", { CFrame = CFrame.new(0, -0.0000004, 0.0000015, 0.9999999, 0, 0, 0, 0.9848077, 0.173648, 0, -0.1736479, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 0.85 })
			I[51] = new("Pose", I[50], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[52] = new("Pose", I[51], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[53] = new("Pose", I[52], "Left Leg", { CFrame = CFrame.new(0.0000024, -0.0000014, -0.0000001, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[54] = new("Pose", I[52], "Right Leg", { CFrame = CFrame.new(0.000002, -0.0000048, 0.0000021, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[55] = new("Pose", I[52], "Left Arm", { CFrame = CFrame.new(0.0000006, 0.0000005, 0.0000067, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[56] = new("Pose", I[52], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000041, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[57] = new("Pose", I[52], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
