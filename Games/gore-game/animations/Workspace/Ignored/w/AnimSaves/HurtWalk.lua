-- Generated from animations/Workspace/Ignored/w/AnimSaves/HurtWalk.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "HurtWalk", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.0000001, -0.0975529, 0.9998793, -0.0013393, -0.0154797, -0.0013393, 0.9851417, -0.1717383, 0.0154797, 0.1717383, 0.985021) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.2871311, -0.0479754, -0.0015133, 0.7042202, 0.7099817, 0, -0.7099817, 0.7042202, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0172973, -0.0984805, 0.0015133, 0.6409383, 0.762776, 0.0858551, -0.7663545, 0.6422393, 0.0151564, -0.0435786, -0.0755097, 0.9961923) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0558249, -0.1267127, -0.0081349, 0.9046244, -0.4235017, -0.0479691, 0.4234334, 0.9058467, -0.0120797, 0.0485684, -0.0093841, 0.9987758) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0233732, -0.0850829, 0.0012216, 0.8784156, -0.4745746, 0.0562587, 0.4728342, 0.8801566, 0.0418601, -0.0693822, -0.0101696, 0.9975383) })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(-0.0000005, 0.0000004, -0.0000001, 0.9999711, 0.000344, 0.0075963, -0.0003466, 0.9999999, 0.000344, -0.0075962, -0.0003466, 0.9999711) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, -0.0654508, 0.9998012, -0.0013814, -0.0198922, -0.0017256, 0.9878614, -0.1553282, 0.0198653, 0.1553316, 0.9876626) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[14] = new("Pose", I[13], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[15] = new("Pose", I[14], "Torso", { CFrame = CFrame.new(0, 0, -0.0206104, 0.9996601, -0.0012999, -0.0260382, -0.0021611, 0.9911869, -0.1324535, 0.0259809, 0.1324648, 0.9908472) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(0, -0.0000001, -0.0024467, 0.9995916, -0.0012454, -0.0285472, -0.0022792, 0.9923918, -0.1230993, 0.0284833, 0.1231141, 0.9919837) })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(0.1408846, -0.0582805, 0.0009518, 0.9898924, 0.1417782, -0.0034518, -0.1418192, 0.9895024, -0.0277905, -0.0005245, 0.0279991, 0.9996078) })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(0.5402069, 0.4408316, -0.000952, 0.9807828, 0.1950727, -0.0034178, -0.194905, 0.9804272, 0.0278302, 0.0087798, -0.0266292, 0.9996068) })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.0121875, -0.0528085, 0) })
					I[22] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.0211522, -0.0350447, -0.0039159, 0.9841147, -0.0925951, -0.1514741, 0.0913976, 0.9957035, -0.0148642, 0.1521997, 0.0007837, 0.9883494) })
					I[23] = new("Pose", I[18], "Head", { CFrame = CFrame.new(-0.0000005, 0.0001628, -0.000012, 1, 0, 0, 0, 0.9961919, -0.0871884, 0, 0.0871884, 0.9961919) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, 0, -0.0412212, 0.9994996, -0.0037159, -0.0314134, -0.0004432, 0.991334, -0.131365, 0.0316293, 0.1313132, 0.9908362) })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(0.0468169, 0.0733438, 0.0072334, 0.9608217, -0.2748537, -0.0357355, 0.2750726, 0.9614226, 0.0012638, 0.0340096, -0.0110442, 0.9993605) })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(0.3747911, 0.394003, -0.0049841, 0.9590061, -0.2833719, -0.00279, 0.2833177, 0.9585139, 0.0313408, -0.0062069, -0.0308464, 0.9995049) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[31] = new("Pose", I[30], "Torso", { CFrame = CFrame.new(-0.0000001, 0.0000001, -0.1309018, 0.999281, -0.0092155, -0.0367755, 0.0035207, 0.988373, -0.1520075, 0.0377487, 0.1517688, 0.9876949) })
					I[32] = new("Pose", I[31], "Left Leg", { CFrame = CFrame.new(0.0010545, 0.0518453, 0.0035156, 0.8191321, -0.5696047, -0.0676245, 0.5715976, 0.8204274, 0.0132312, 0.0479444, -0.0494921, 0.9976231) })
					I[33] = new("Pose", I[31], "Right Leg", { CFrame = CFrame.new(0.2848793, 0.2020544, -0.0029368, 0.7865785, -0.6174804, -0.0034888, 0.617218, 0.7860514, 0.0341349, -0.0183352, -0.0290031, 0.9994112) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(-0.0000001, 0.0000002, -0.1951061, 0.9990896, -0.0132753, -0.0405433, 0.0063327, 0.9859727, -0.1667865, 0.0421888, 0.1663779, 0.9851591) })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(-0.0005647, 0.0041015, 0.0002386, 0.713012, -0.6960202, -0.0846737, 0.6993684, 0.7146013, 0.0151296, 0.0499774, -0.0700057, 0.9962938) })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0.269914, 0.0611485, -0.0002264, 0.6555748, -0.7551184, -0.0042614, 0.7547523, 0.6550576, 0.0353376, -0.0238926, -0.0263827, 0.9993663) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[40] = new("Pose", I[39], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[41] = new("Pose", I[40], "Torso", { CFrame = CFrame.new(-0.0000001, 0.0000001, -0.1844423, 0.999272, -0.0131437, -0.0358153, 0.0071569, 0.9866956, -0.1624206, 0.0374736, 0.162046, 0.9860714) })
					I[42] = new("Pose", I[41], "Left Leg", { CFrame = CFrame.new(0.0000004, -0.0000011, -0.0000001, 0.704958, -0.7040398, -0.0858038, 0.707487, 0.7065639, 0.0151454, 0.0499629, -0.0713819, 0.9961969) })
					I[43] = new("Pose", I[41], "Right Leg", { CFrame = CFrame.new(0.2698315, 0.0505058, -0.0000009, 0.6456159, -0.76365, -0.0043365, 0.7632781, 0.6451006, 0.0353815, -0.0242216, -0.0261528, 0.9993645) })
					I[44] = new("Pose", I[41], "Left Arm", { CFrame = CFrame.new(-0.0980422, -0.1827044, -0.0102271, 0.8176272, 0.5754013, -0.0199766, -0.5756929, 0.8165767, -0.0421929, -0.0079654, 0.0459984, 0.9989098) })
					I[45] = new("Pose", I[41], "Right Arm", { CFrame = CFrame.new(-0.1805179, -0.0757889, -0.0370619, 0.8132253, 0.5598678, -0.1587848, -0.5657797, 0.8245019, 0.0094823, 0.1362272, 0.082126, 0.9872677) })
					I[46] = new("Pose", I[41], "Head", { CFrame = CFrame.new(-0.0000005, -0.0000032, 0.0000025, 0.9990172, 0.0288226, 0.0336716, -0.0286536, 0.9995743, -0.0054905, -0.0338155, 0.0045203, 0.9994178) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[49] = new("Pose", I[48], "Torso", { CFrame = CFrame.new(0, -0.0000003, -0.1219523, 0.9998124, -0.0115684, -0.0155373, 0.0092686, 0.99001, -0.1406919, 0.0170097, 0.1405215, 0.9899315) })
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[51] = new("Pose", I[50], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[52] = new("Pose", I[51], "Torso", { CFrame = CFrame.new(0, -0.0000007, -0.07101, 0.9999426, -0.010657, 0.0010891, 0.0107101, 0.9923771, -0.1227719, 0.0002276, 0.1227766, 0.9924343) })
		I[53] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[54] = new("Pose", I[53], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[55] = new("Pose", I[54], "Torso", { CFrame = CFrame.new(0, -0.0000007, -0.0669996, 0.9999412, -0.010579, 0.0023742, 0.010789, 0.9925461, -0.1213916, -0.0010723, 0.1214101, 0.9926019) })
					I[56] = new("Pose", I[55], "Left Leg", { CFrame = CFrame.new(-0.5814829, 0.4343379, 0.0000001, 0.9455185, -0.3255683, 0, 0.3255683, 0.9455185, 0, 0, 0, 1) })
					I[57] = new("Pose", I[55], "Right Leg", { CFrame = CFrame.new(0.4439466, 0.0718477, -0.0166959, 0.99618, -0.0872772, -0.0028492, 0.0872716, 0.9961825, -0.0020255, 0.0030151, 0.0017691, 0.9999939) })
					I[58] = new("Pose", I[55], "Left Arm", { CFrame = CFrame.new(-0.0121875, -0.152808, 0) })
					I[59] = new("Pose", I[55], "Right Arm", { CFrame = CFrame.new(-0.0211524, -0.0350446, -0.003916, 0.9841147, -0.0925951, -0.1514741, 0.0913976, 0.9957035, -0.0148642, 0.1521997, 0.0007837, 0.9883494) })
					I[60] = new("Pose", I[55], "Head", { CFrame = CFrame.new(-0.0019946, 0.0005613, -0.0019041, 0.9998031, 0.018415, -0.0074007, -0.0190085, 0.9957325, -0.090307, 0.0057061, 0.0904299, 0.9958865) })
		I[61] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[62] = new("Pose", I[61], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[63] = new("Pose", I[62], "Torso", { CFrame = CFrame.new(0, 0.0000001, -0.1000002, 0.9998846, -0.0013193, -0.0151348, -0.0013193, 0.9849176, -0.1730188, 0.0151348, 0.1730188, 0.9848022) })
					I[64] = new("Pose", I[63], "Left Leg", { CFrame = CFrame.new(-0.2871311, -0.0479754, -0.0015133, 0.7042202, 0.7099817, 0, -0.7099817, 0.7042202, 0, 0, 0, 1) })
					I[65] = new("Pose", I[63], "Right Leg", { CFrame = CFrame.new(0.0172973, -0.0984805, 0.0015133, 0.6409383, 0.762776, 0.0858551, -0.7663545, 0.6422393, 0.0151564, -0.0435786, -0.0755097, 0.9961923) })
					I[66] = new("Pose", I[63], "Left Arm", { CFrame = CFrame.new(0.0558249, -0.1267127, -0.0081349, 0.9046244, -0.4235017, -0.0479691, 0.4234334, 0.9058467, -0.0120797, 0.0485684, -0.0093841, 0.9987758) })
					I[67] = new("Pose", I[63], "Right Arm", { CFrame = CFrame.new(0.0233732, -0.0850829, 0.0012216, 0.8784156, -0.4745746, 0.0562587, 0.4728342, 0.8801566, 0.0418601, -0.0693822, -0.0101696, 0.9975383) })
					I[68] = new("Pose", I[63], "Head", { CFrame = CFrame.new(-0.0000005, 0.0000004, -0.0000001, 0.9999711, 0.000344, 0.0075963, -0.0003466, 0.9999999, 0.000344, -0.0075962, -0.0003466, 0.9999711) })
	return I[1]
end

return build
