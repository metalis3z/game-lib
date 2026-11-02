-- Generated from animations/Workspace/Ignored/w/AnimSaves/SwimAnimation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "SwimAnimation", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0.0173644, 0.3, 0.09848, 0.9848125, 0, 0.1736211, 0, 1, 0, -0.1736211, 0, 0.9848125) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0199972, -0.0787877, 0.0138864, 0.8669177, -0.4948992, -0.0594014, 0.4975379, 0.8519508, 0.1632055, -0.0301632, -0.1710401, 0.9848022) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(-0.0000037, 0.0000218, -0.0000042, 0.9397202, -0.3367421, -0.0594192, 0.3419442, 0.9254398, 0.1632035, 0.0000314, -0.1736837, 0.9848015) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0000024, -0.1477216, 0.0260491, 0.9648287, -0.0549097, 0.2570808, -0.0162556, 0.9636081, 0.2668241, -0.2623764, -0.2616185, 0.9288242) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1080414, 0.6780071, -0.0269526, -0.9657209, -0.154188, -0.2088282, 0.1903771, -0.9675771, -0.1659851, -0.1764645, -0.2000514, 0.9637633) })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000001, 0.0000001, 0.0000001, 0.9919037, -0.0037763, -0.1269358, 0.0127535, 0.9974666, 0.0699841, 0.12635, -0.0710363, 0.989439) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[11] = new("Pose", I[10], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Right Leg", { CFrame = CFrame.new(-0.0002461, 0.0014315, -0.0002521, 0.9416027, -0.3314509, -0.0593686, 0.3367245, 0.9273502, 0.163212, 0.0009587, -0.1736717, 0.9848031) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[14] = new("Pose", I[13], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[15] = new("Pose", I[14], "Right Leg", { CFrame = CFrame.new(-0.0004705, 0.0027715, -0.0004876, 0.9434229, -0.3262263, -0.0594105, 0.3315862, 0.9292012, 0.1632043, 0.0019628, -0.1736703, 0.9848019) })
				I[16] = new("Pose", I[14], "Right Arm", { CFrame = CFrame.new(0.1442179, -0.045753, 0.045055, 0.9527112, -0.2855991, -0.1038008, 0.2959305, 0.9495975, 0.1033916, 0.0690404, -0.1292202, 0.9892096) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[18] = new("Pose", I[17], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[19] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(-0.0026918, 0.018873, -0.0032897, 0.9661037, -0.2512199, -0.0594324, 0.2576821, 0.9523511, 0.1631789, 0.0156067, -0.1729624, 0.9848047) })
				I[20] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0.0509517, -0.1399786, 0.0480097, 0.9830356, 0.093203, -0.1579691, -0.0595266, 0.9767675, 0.2058686, 0.1734866, -0.1929728, 0.9657453) })
				I[21] = new("Pose", I[18], "Head", { CFrame = CFrame.new(-0.0000002, 0.0000002, -0.0000002, -0.2377464, 0.9389829, 0.2485714, -0.9166061, -0.3015637, 0.2624739, 0.3214186, -0.1654399, 0.9323732) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[23] = new("Pose", I[22], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[24] = new("Pose", I[23], "Right Leg", { CFrame = CFrame.new(-0.0033144, 0.0313655, -0.0053972, 0.9874833, -0.1461084, -0.0594066, 0.1540031, 0.9745098, 0.163137, 0.0340567, -0.1702439, 0.9848133) })
				I[25] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(-0.0090683, -0.2006153, 0.0499113, 0.9269531, 0.3344411, -0.170021, -0.2803585, 0.9186176, 0.2784614, 0.2493133, -0.2104538, 0.9452788) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[27] = new("Pose", I[26], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Right Leg", { CFrame = CFrame.new(-0.0013355, 0.0280595, -0.0047298, 0.9979586, 0.0235619, -0.059359, -0.0135857, 0.9865034, 0.1631765, 0.0624026, -0.162037, 0.9848096) })
				I[29] = new("Pose", I[27], "Right Arm", { CFrame = CFrame.new(-0.0424165, -0.234306, 0.0509681, 0.8713778, 0.4607536, -0.1685429, -0.3940667, 0.8619474, 0.3189955, 0.2922535, -0.2115484, 0.9326496) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[32] = new("Pose", I[31], "Torso", { CFrame = CFrame.new(0, 0.3, 0.209998) })
					I[33] = new("Pose", I[32], "Left Leg", { CFrame = CFrame.new(0, -0.0000012, -0.0000017, 0.9848022, 0.1710408, 0.0301596, -0.1736795, 0.9698353, 0.1710408, 0.0000051, -0.1736795, 0.9848022) })
					I[34] = new("Pose", I[32], "Right Leg", { CFrame = CFrame.new(-0.0004058, 0.0178252, -0.0029785, 0.9935486, 0.0966245, -0.0593708, -0.0858323, 0.9828529, 0.1631965, 0.0741215, -0.1570477, 0.9848056) })
					I[35] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(-0.0000006, 0.169986, 0.4699962, 0.6159025, 0.1865802, 0.7654096, -0.6928674, -0.3341277, 0.6389785, 0.3749653, -0.9238759, -0.0765147) })
					I[36] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(-0.0556669, -0.2476926, 0.051388, 0.844733, 0.508675, -0.1663609, -0.4367993, 0.8348976, 0.3348915, 0.3092453, -0.2102276, 0.9274544) })
					I[37] = new("Pose", I[32], "Head", { CFrame = CFrame.new(-0.0000001, 0, -0.0000012, -0.4250689, 0.7896914, 0.4423853, -0.8775391, -0.4793437, 0.0124758, 0.2219064, -0.3829072, 0.8967384) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[39] = new("Pose", I[38], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[40] = new("Pose", I[39], "Right Arm", { CFrame = CFrame.new(-0.0553939, -0.2474169, 0.0513794, 0.8452914, 0.5077244, -0.1664285, -0.4359414, 0.8354623, 0.3346009, 0.3089298, -0.2102821, 0.9275472) })
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[42] = new("Pose", I[41], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[43] = new("Pose", I[42], "Right Arm", { CFrame = CFrame.new(-0.0481715, -0.2401202, 0.0511504, 0.8600982, 0.4817529, -0.1677656, -0.4128125, 0.8505105, 0.3259105, 0.2996947, -0.2110593, 0.9303962) })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[45] = new("Pose", I[44], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[46] = new("Pose", I[45], "Right Arm", { CFrame = CFrame.new(-0.040574, -0.2324447, 0.0509098, 0.8748823, 0.4539836, -0.1687595, -0.3880099, 0.8655022, 0.3167875, 0.289878, -0.2116714, 0.9333627) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[49] = new("Pose", I[48], "Torso", { CFrame = CFrame.new(-0.0123512, 0.3, 0.2886412, 0.9923385, 0, -0.1235484, 0, 1, 0, 0.1235484, 0, 0.9923385) })
					I[50] = new("Pose", I[49], "Left Leg", { CFrame = CFrame.new(-0.0836488, 0.1130883, 0.0101716, 0.9323036, 0.3586394, -0.0467735, -0.3497551, 0.9269322, 0.1358976, 0.0920941, -0.1103385, 0.9896181) })
					I[51] = new("Pose", I[49], "Right Leg", { CFrame = CFrame.new(-0.004969, -0.0269036, 0.0025395, 0.8479308, 0.5281003, -0.0460802, -0.4956521, 0.820645, 0.2843779, 0.1879955, -0.2182931, 0.9576042) })
					I[52] = new("Pose", I[49], "Left Arm", { CFrame = CFrame.new(-0.1358004, 0.6353139, -0.0381347, -0.9143585, 0.3581303, 0.1889208, -0.393132, -0.8969109, -0.2024797, 0.096931, -0.2594099, 0.9608907) })
					I[53] = new("Pose", I[49], "Right Arm", { CFrame = CFrame.new(-0.0390944, -0.2309498, 0.0508627, 0.8776537, 0.4485126, -0.1689986, -0.3830917, 0.868335, 0.315016, 0.288036, -0.211733, 0.9339188) })
					I[54] = new("Pose", I[49], "Head", { CFrame = CFrame.new(0, 0.0000002, 0.0000004, 0.9892793, 0.0243889, 0.1439853, -0.0645461, 0.9574468, 0.2812997, -0.1309976, -0.2875776, 0.9487564) })
		I[55] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[56] = new("Pose", I[55], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[57] = new("Pose", I[56], "Torso", { CFrame = CFrame.new(-0.0111272, 0.3, 0.2800555, 0.9937615, 0, -0.1115263, 0, 1, 0, 0.1115263, 0, 0.9937615) })
					I[58] = new("Pose", I[57], "Left Leg", { CFrame = CFrame.new(-0.0805147, 0.1192352, 0.0081639, 0.9432718, 0.3287337, -0.0466111, -0.3199908, 0.9375376, 0.1364886, 0.0885681, -0.1138307, 0.9895445) })
					I[59] = new("Pose", I[57], "Right Leg", { CFrame = CFrame.new(-0.0020724, -0.0108675, -0.0010011, 0.8664797, 0.4968238, -0.0487755, -0.4655945, 0.8395111, 0.2800766, 0.1800963, -0.2199711, 0.9587377) })
		I[60] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[61] = new("Pose", I[60], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[62] = new("Pose", I[61], "Torso", { CFrame = CFrame.new(-0.008577, 0.3, 0.262228, 0.9962817, 0, -0.0861555, 0, 1, 0, 0.0861555, 0, 0.9962817) })
					I[63] = new("Pose", I[62], "Left Leg", { CFrame = CFrame.new(-0.0703431, 0.1348414, 0.0006682, 0.9801772, 0.1926178, -0.0463797, -0.1846228, 0.9729421, 0.138918, 0.0718829, -0.1276014, 0.9892172) })
					I[64] = new("Pose", I[62], "Right Leg", { CFrame = CFrame.new(0.0021675, 0.0190157, -0.0074717, 0.9018496, 0.4286709, -0.0539304, -0.4000337, 0.8756446, 0.2705913, 0.1632185, -0.2224587, 0.9611825) })
					I[65] = new("Pose", I[62], "Left Arm", { CFrame = CFrame.new(-0.3851288, 0.1754206, -0.0511567, 0.2365103, 0.8888447, 0.392451, -0.9703356, 0.2369046, 0.0482174, -0.0501156, -0.3922132, 0.9185082) })
		I[66] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[67] = new("Pose", I[66], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[68] = new("Pose", I[67], "Torso", { CFrame = CFrame.new(-0.0049846, 0.3, 0.2373517, 0.9987553, 0, -0.0498786, 0, 1, 0, 0.0498786, 0, 0.9987553) })
					I[69] = new("Pose", I[68], "Left Leg", { CFrame = CFrame.new(-0.057258, 0.0942633, -0.0068088, 0.9892936, -0.1380601, -0.0473041, 0.1435393, 0.9790338, 0.1445316, 0.0263582, -0.1497741, 0.9883688) })
					I[70] = new("Pose", I[68], "Right Leg", { CFrame = CFrame.new(0.0045738, 0.0522791, -0.0143969, 0.9430583, 0.3271965, -0.0598627, -0.3022535, 0.9180846, 0.256444, 0.1388666, -0.223748, 0.9647036) })
					I[71] = new("Pose", I[68], "Left Arm", { CFrame = CFrame.new(-0.1398527, 0.0734171, -0.0231618, 0.7866462, 0.5041626, 0.3563815, -0.588888, 0.7860935, 0.1877977, -0.1854686, -0.3575991, 0.9152728) })
		I[72] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[73] = new("Pose", I[72], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[74] = new("Pose", I[73], "Torso", { CFrame = CFrame.new(-0.0007104, 0.3, 0.2083396, 0.9999812, 0, -0.0061288, 0, 1, 0, 0.0061288, 0, 0.9999812) })
					I[75] = new("Pose", I[74], "Left Leg", { CFrame = CFrame.new(-0.0475172, 0.032517, -0.004563, 0.952331, -0.3011999, -0.0484181, 0.3050642, 0.940897, 0.1471349, 0.0012394, -0.1548918, 0.9879307) })
					I[76] = new("Pose", I[74], "Right Leg", { CFrame = CFrame.new(0.0034238, 0.0771394, -0.0191405, 0.9775987, 0.2002284, -0.064879, -0.1796266, 0.9543448, 0.2386637, 0.1097042, -0.2216633, 0.9689326) })
					I[77] = new("Pose", I[74], "Left Arm", { CFrame = CFrame.new(-0.0368108, -0.0714423, 0.0108327, 0.950948, 0.1096478, 0.2892668, -0.1859474, 0.9498988, 0.2512285, -0.2472276, -0.2926937, 0.9236931) })
					I[78] = new("Pose", I[74], "Right Arm", { CFrame = CFrame.new(0.3308606, 0.2957034, 0.3566453, 0.2533028, -0.1648001, -0.9532464, 0.6687399, -0.6821902, 0.2956409, -0.699017, -0.7123605, -0.0625923) })
		I[79] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[80] = new("Pose", I[79], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[81] = new("Pose", I[80], "Torso", { CFrame = CFrame.new(0.0038561, 0.3, 0.1783617, 0.999177, 0, 0.040563, 0, 1, 0, -0.040563, 0, 0.999177) })
					I[82] = new("Pose", I[81], "Right Leg", { CFrame = CFrame.new(-0.0002635, 0.0849932, -0.019977, 0.9958809, 0.0605266, -0.0675108, -0.0443888, 0.9746999, 0.219066, 0.0790621, -0.2151669, 0.9733717) })
					I[83] = new("Pose", I[81], "Left Arm", { CFrame = CFrame.new(0.0150461, -0.1816261, 0.0323514, 0.9622928, -0.1211995, 0.2435227, 0.0523417, 0.9610242, 0.2714641, -0.2669325, -0.2484816, 0.9311305) })
		I[84] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[85] = new("Pose", I[84], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[86] = new("Pose", I[85], "Torso", { CFrame = CFrame.new(0.0083147, 0.3, 0.1504057, 0.9963262, 0, 0.085639, 0, 1, 0, -0.085639, 0, 0.9963262) })
					I[87] = new("Pose", I[86], "Right Leg", { CFrame = CFrame.new(-0.0036554, 0.0739704, -0.0167781, 0.9948456, -0.0757667, -0.067392, 0.0878655, 0.9758582, 0.1999509, 0.0506154, -0.2048417, 0.9774855) })
					I[88] = new("Pose", I[86], "Left Arm", { CFrame = CFrame.new(0.0347565, -0.227577, 0.0404974, 0.9522996, -0.2051968, 0.2258757, 0.1394304, 0.9509712, 0.2760668, -0.2714493, -0.2314044, 0.9342202) })
		I[89] = new("Keyframe", I[1], "Keyframe", { Time = 0.85 })
			I[90] = new("Pose", I[89], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[91] = new("Pose", I[90], "Torso", { CFrame = CFrame.new(0.0122552, 0.3, 0.1269582, 0.9921882, 0, 0.1247499, 0, 1, 0, -0.1247499, 0, 0.9921882) })
					I[92] = new("Pose", I[91], "Right Leg", { CFrame = CFrame.new(-0.0044631, 0.0496649, -0.0109846, 0.9790326, -0.1930211, -0.0650998, 0.2018775, 0.96207, 0.1834849, 0.0272141, -0.1927799, 0.9808646) })
					I[93] = new("Pose", I[91], "Left Arm", { CFrame = CFrame.new(0.0317025, -0.2203705, 0.0392489, 0.9543083, -0.1924831, 0.2285735, 0.1262507, 0.9529976, 0.2754204, -0.2708438, -0.2339785, 0.9337547) })
		I[94] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[95] = new("Pose", I[94], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[96] = new("Pose", I[95], "Torso", { CFrame = CFrame.new(0.0152736, 0.3, 0.1098658, 0.988089, 0, 0.1538835, 0, 1, 0, -0.1538835, 0, 0.988089) })
					I[97] = new("Pose", I[96], "Right Leg", { CFrame = CFrame.new(-0.0027229, 0.0226147, -0.0049179, 0.9581766, -0.2793564, -0.0621095, 0.2859773, 0.942802, 0.1712934, 0.0107051, -0.1818912, 0.9832604) })
					I[98] = new("Pose", I[96], "Left Arm", { CFrame = CFrame.new(0.0174191, -0.1870787, 0.0333409, 0.9614686, -0.1315098, 0.2414193, 0.0630139, 0.9602034, 0.2721004, -0.2675955, -0.2464033, 0.9314924) })
		I[99] = new("Keyframe", I[1], "Keyframe", { Time = 0.95 })
			I[100] = new("Pose", I[99], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[101] = new("Pose", I[100], "Torso", { CFrame = CFrame.new(0.0170214, 0.3, 0.100324, 0.9853641, 0, 0.1704631, 0, 1, 0, -0.1704631, 0, 0.9853641) })
					I[102] = new("Pose", I[101], "Right Leg", { CFrame = CFrame.new(-0.0005397, 0.0039167, -0.0008444, 0.9429567, -0.3274933, -0.0598403, 0.3329112, 0.9284999, 0.1644935, 0.0016912, -0.1750317, 0.9845613) })
					I[103] = new("Pose", I[101], "Left Arm", { CFrame = CFrame.new(0.0035826, -0.1556816, 0.0275508, 0.9646417, -0.0708366, 0.2538672, 0.0002001, 0.9634027, 0.268058, -0.2635647, -0.2585291, 0.9293526) })
		I[104] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[105] = new("Pose", I[104], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[106] = new("Pose", I[105], "Torso", { CFrame = CFrame.new(0.0173644, 0.3, 0.09848, 0.9848125, 0, 0.1736211, 0, 1, 0, -0.1736211, 0, 0.9848125) })
					I[107] = new("Pose", I[106], "Left Leg", { CFrame = CFrame.new(0.0199972, -0.0787877, 0.0138864, 0.8669177, -0.4948992, -0.0594014, 0.4975379, 0.8519508, 0.1632055, -0.0301632, -0.1710401, 0.9848022) })
					I[108] = new("Pose", I[106], "Right Leg", { CFrame = CFrame.new(-0.0000037, 0.0000218, -0.0000042, 0.9397202, -0.3367421, -0.0594192, 0.3419442, 0.9254398, 0.1632035, 0.0000314, -0.1736837, 0.9848015) })
					I[109] = new("Pose", I[106], "Left Arm", { CFrame = CFrame.new(-0.0000024, -0.1477216, 0.0260491, 0.9648287, -0.0549097, 0.2570808, -0.0162556, 0.9636081, 0.2668241, -0.2623764, -0.2616185, 0.9288242) })
					I[110] = new("Pose", I[106], "Right Arm", { CFrame = CFrame.new(0.0671391, 0.68607, -0.0344282, -0.9505074, -0.1451231, -0.2747273, 0.2005001, -0.9619634, -0.1855427, -0.237351, -0.2314426, 0.9434505) })
					I[111] = new("Pose", I[106], "Head", { CFrame = CFrame.new(0.0000001, 0.0000001, 0.0000001, 0.9919037, -0.0037763, -0.1269358, 0.0127535, 0.9974666, 0.0699841, 0.12635, -0.0710363, 0.989439) })
	return I[1]
end

return build
