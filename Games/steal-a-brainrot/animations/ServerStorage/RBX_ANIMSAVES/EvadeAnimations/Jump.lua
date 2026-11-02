-- Generated from animations/ServerStorage/RBX_ANIMSAVES/EvadeAnimations/Jump.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Jump", { Loop = false, Priority = Enum.AnimationPriority.Action2 }, { ["ViralWorkerRef"] = "vw_0a7749e857" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_1c8e56c854" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_e710c60b4a" })
				I[4] = new("IntValue", I[3], "Null", nil, { ["ViralWorkerRef"] = "vw_dfcbf845b2" })
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(-0.0005302, -0.1971245, -0.3402303, 0.9994591, 0.0328814, -0.0004418, -0.0325073, 0.9858793, -0.1642719, -0.0049659, 0.1641975, 0.9864151) }, { ["ViralWorkerRef"] = "vw_264aaa151a" })
					I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(-0.0010061, 0.0331099, -0.0026736, 0.998879, -0.0446292, -0.0157795, 0.0429393, 0.9945706, -0.0947918, 0.0199243, 0.0940081, 0.9953724) }, { ["ViralWorkerRef"] = "vw_43226c8179" })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.4613652, 0.3180451, 0.0817942, 0.9707553, -0.1272379, 0.2035798, 0.111475, 0.9899381, 0.0871547, -0.2126208, -0.0619119, 0.9751714) }, { ["ViralWorkerRef"] = "vw_a8d82e0d9e" })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0.1556129, -0.2549263, 0.1314287, 0.9286152, -0.3710268, 0.0036299, 0.3633136, 0.9112097, 0.1941658, -0.0753483, -0.1789864, 0.980962) }, { ["ViralWorkerRef"] = "vw_faf40b62c5" })
					I[9] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.5875537, 0.3735842, -0.0105502, 0.9827187, 0.1279164, -0.1337955, -0.1102527, 0.9850975, 0.1320136, 0.1486883, -0.1149808, 0.9821768) }, { ["ViralWorkerRef"] = "vw_9e3d95309e" })
					I[10] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.0079026, -0.3921865, 0.0542367, 0.799147, 0.5627541, -0.2113572, -0.5102273, 0.8208956, 0.2565132, 0.3178561, -0.0971515, 0.9431486) }, { ["ViralWorkerRef"] = "vw_773eb36efa" })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 }, { ["ViralWorkerRef"] = "vw_77b00b5385" })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_57b03c9e2f" })
				I[13] = new("IntValue", I[12], "Null", nil, { ["ViralWorkerRef"] = "vw_fcba8c3529" })
				I[14] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(-0.0005302, -0.0354271, -0.2363866, 0.9994593, 0.0328814, -0.0004418, -0.0320644, 0.9714681, -0.2349929, -0.0072977, 0.23488, 0.9719971) }, { ["ViralWorkerRef"] = "vw_b55a911800" })
					I[15] = new("Pose", I[14], "Head", { CFrame = CFrame.new(-0.00147, 0.0472223, -0.0054734, 0.9991083, -0.0418471, -0.0056507, 0.0360057, 0.9141616, -0.4037478, 0.0220614, 0.4031844, 0.9148531) }, { ["ViralWorkerRef"] = "vw_a0613aba57" })
					I[16] = new("Pose", I[14], "Left Leg", { CFrame = CFrame.new(-0.3764049, 0.1796039, 0.0816564, 0.9738639, 0.0555718, 0.2202295, -0.0702239, 0.9957693, 0.0592647, -0.2160043, -0.0731811, 0.9736463) }, { ["ViralWorkerRef"] = "vw_730566ff07" })
					I[17] = new("Pose", I[14], "Right Arm", { CFrame = CFrame.new(-0.0107789, -0.2957312, 0.1592003, 0.8282207, -0.5028713, -0.2473278, 0.5431792, 0.8289302, 0.1335346, 0.1378668, -0.2449393, 0.9596864) }, { ["ViralWorkerRef"] = "vw_8d02dd0cfd" })
					I[18] = new("Pose", I[14], "Right Leg", { CFrame = CFrame.new(0.4745947, 0.2275652, -0.0102516, 0.9880224, 0.0142461, -0.1536515, 0.0024265, 0.9941719, 0.1077798, 0.1542914, -0.1068617, 0.9822297) }, { ["ViralWorkerRef"] = "vw_cd5c36dbc4" })
					I[19] = new("Pose", I[14], "Left Arm", { CFrame = CFrame.new(0.2080352, -0.4133596, 0.1196891, 0.8065786, 0.572889, 0.1457026, -0.5908309, 0.7891029, 0.1680353, -0.0187087, -0.2216193, 0.9749539) }, { ["ViralWorkerRef"] = "vw_6dbf41af29" })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 }, { ["ViralWorkerRef"] = "vw_19f1aa2498" })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_0abcd25786" })
				I[22] = new("IntValue", I[21], "Null", nil, { ["ViralWorkerRef"] = "vw_cde0800fe1" })
				I[23] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(-0.0005302, -0.044117, -0.0487947, 0.999459, 0.0328872, -0.0004425, -0.0320263, 0.9700578, -0.2407536, -0.0074884, 0.2406375, 0.9705862) }, { ["ViralWorkerRef"] = "vw_2c6634c5be" })
					I[24] = new("Pose", I[23], "Head", { CFrame = CFrame.new(-0.0015166, 0.0483892, -0.0057859, 0.9990189, -0.0432932, -0.0093265, 0.0386942, 0.9557311, -0.2916867, 0.0215416, 0.2910396, 0.9564686) }, { ["ViralWorkerRef"] = "vw_22fff52da7" })
					I[25] = new("Pose", I[23], "Left Leg", { CFrame = CFrame.new(-0.3090966, 0.056207, 0.0790909, 0.9594629, 0.1688069, 0.2256891, -0.1829687, 0.9821681, 0.043223, -0.2143683, -0.0827649, 0.9732401) }, { ["ViralWorkerRef"] = "vw_e2ae2ba6a6" })
					I[26] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(-0.144688, -0.3265592, 0.2126181, 0.576055, -0.6449097, -0.5022472, 0.7515804, 0.6594651, 0.0152437, 0.3213838, -0.3862603, 0.8645897) }, { ["ViralWorkerRef"] = "vw_435f46a1b5" })
					I[27] = new("Pose", I[23], "Right Leg", { CFrame = CFrame.new(0.3926797, 0.0932546, -0.0031483, 0.9815179, -0.0994541, -0.1634987, 0.115366, 0.9891574, 0.0908754, 0.152688, -0.108058, 0.9823491) }, { ["ViralWorkerRef"] = "vw_3b30ee183e" })
					I[28] = new("Pose", I[23], "Left Arm", { CFrame = CFrame.new(0.4008344, -0.4290023, 0.2355509, 0.6164352, 0.5740299, 0.5389783, -0.7113232, 0.6995151, 0.0685407, -0.3376791, -0.4256386, 0.8395264) }, { ["ViralWorkerRef"] = "vw_d2581506b2" })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 }, { ["ViralWorkerRef"] = "vw_aff8770401" })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_3f7795ab78" })
				I[31] = new("IntValue", I[30], "Null", nil, { ["ViralWorkerRef"] = "vw_b1389281f6" })
				I[32] = new("Pose", I[30], "Torso", { CFrame = CFrame.new(-0.0005302, -0.0590782, 0.1057816, 0.9994591, 0.0328843, -0.0004422, -0.032007, 0.9695297, -0.2428739, -0.007558, 0.2427566, 0.9700578) }, { ["ViralWorkerRef"] = "vw_0fb5abd13b" })
					I[33] = new("Pose", I[32], "Head", { CFrame = CFrame.new(-0.0015216, 0.0488235, -0.0059655, 0.9988298, -0.0448683, -0.0180521, 0.0443804, 0.998661, -0.0265791, 0.0192205, 0.0257469, 0.9994838) }, { ["ViralWorkerRef"] = "vw_33b6587a1d" })
					I[34] = new("Pose", I[32], "Left Leg", { CFrame = CFrame.new(-0.3842983, 0.1231292, 0.067253, 0.9753525, 0.0072316, 0.2205336, -0.0326504, 0.9931902, 0.1118348, -0.2182231, -0.1162789, 0.9689469) }, { ["ViralWorkerRef"] = "vw_d41a03b17f" })
					I[35] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(-0.0572168, -0.3038792, 0.2599548, 0.3546028, -0.7750944, -0.5229582, 0.9305695, 0.3470412, 0.1166306, 0.0910883, -0.5280064, 0.8443411) }, { ["ViralWorkerRef"] = "vw_d632025809" })
					I[36] = new("Pose", I[32], "Right Leg", { CFrame = CFrame.new(0.4927637, 0.1564035, 0.0206774, 0.9913525, 0.0411182, -0.1246174, -0.0213297, 0.9875028, 0.1561506, 0.1294807, -0.1521422, 0.9798406) }, { ["ViralWorkerRef"] = "vw_ca0cd30dc7" })
					I[37] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(0.3144494, -0.4141441, 0.3194846, 0.4814259, 0.6942478, 0.5350226, -0.8678453, 0.463073, 0.1800219, -0.1227747, -0.5509839, 0.8254351) }, { ["ViralWorkerRef"] = "vw_b83dfd5e68" })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 }, { ["ViralWorkerRef"] = "vw_26613b0384" })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_436f1f802f" })
				I[40] = new("IntValue", I[39], "Null", nil, { ["ViralWorkerRef"] = "vw_6ac727bf3d" })
				I[41] = new("Pose", I[39], "Torso", { CFrame = CFrame.new(-0.0005302, -0.0931549, 0.1700449, 0.9994591, 0.0328814, -0.0004418, -0.0320018, 0.969454, -0.2431766, -0.0075676, 0.2430593, 0.9699819) }, { ["ViralWorkerRef"] = "vw_86ff407dfb" })
					I[42] = new("Pose", I[41], "Head", { CFrame = CFrame.new(-0.0015242, 0.0488746, -0.0060518, 0.9986688, -0.0440252, -0.0268741, 0.0492107, 0.9693403, 0.2407443, 0.0154513, -0.2417463, 0.9702166) }, { ["ViralWorkerRef"] = "vw_c01a4a5311" })
					I[43] = new("Pose", I[41], "Left Leg", { CFrame = CFrame.new(-0.5415494, 0.2671511, 0.0496684, 0.9396656, -0.2913602, 0.1792709, 0.2472997, 0.9406281, 0.2325116, -0.236372, -0.1741495, 0.955929) }, { ["ViralWorkerRef"] = "vw_c32848e0e2" })
					I[44] = new("Pose", I[41], "Right Arm", { CFrame = CFrame.new(0.0989153, -0.2372508, 0.2515391, 0.1261144, -0.8431037, -0.5227536, 0.9445406, -0.0590135, 0.3230483, -0.3032129, -0.534503, 0.7889033) }, { ["ViralWorkerRef"] = "vw_0404043c9a" })
					I[45] = new("Pose", I[41], "Right Leg", { CFrame = CFrame.new(0.6935607, 0.2871196, 0.0505094, 0.9551411, 0.2947814, -0.028453, -0.2776761, 0.9248152, 0.2600234, 0.1029639, -0.2404584, 0.965183) }, { ["ViralWorkerRef"] = "vw_606946f232" })
					I[46] = new("Pose", I[41], "Left Arm", { CFrame = CFrame.new(0.0933646, -0.3557155, 0.3172075, 0.2622302, 0.847647, 0.4612263, -0.9318979, 0.0983171, 0.3491421, 0.2506029, -0.5213713, 0.8157021) }, { ["ViralWorkerRef"] = "vw_266d2d2998" })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 }, { ["ViralWorkerRef"] = "vw_be4e28c820" })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_02c3370997" })
				I[49] = new("IntValue", I[48], "Null", nil, { ["ViralWorkerRef"] = "vw_838d7972f5" })
				I[50] = new("Pose", I[48], "Torso", { CFrame = CFrame.new(-0.0005302, -0.1531067, 0.1613417, 0.9994591, 0.0328814, -0.0004418, -0.032068, 0.9715829, -0.2345174, -0.007282, 0.2344048, 0.9721119) }, { ["ViralWorkerRef"] = "vw_1961a51583" })
					I[51] = new("Pose", I[50], "Head", { CFrame = CFrame.new(-0.0014708, 0.04713, -0.0056545, 0.9986143, -0.0428237, -0.0305896, 0.0508986, 0.9336491, 0.3545547, 0.0133766, -0.3556203, 0.9345351) }, { ["ViralWorkerRef"] = "vw_138a3685f1" })
					I[52] = new("Pose", I[50], "Left Leg", { CFrame = CFrame.new(-0.6400987, 0.372385, 0.0392345, 0.8876092, -0.4381662, 0.141988, 0.3862835, 0.8760486, 0.2886596, -0.2508692, -0.2013692, 0.9468449) }, { ["ViralWorkerRef"] = "vw_59f5b34ec1" })
					I[53] = new("Pose", I[50], "Right Arm", { CFrame = CFrame.new(0.3479187, -0.1939283, 0.1645558, -0.1433165, -0.8597024, -0.4902779, 0.8161296, -0.3828842, 0.4328193, -0.5598153, -0.3381, 0.7565021) }, { ["ViralWorkerRef"] = "vw_b9c7d67b7c" })
					I[54] = new("Pose", I[50], "Right Leg", { CFrame = CFrame.new(0.8125554, 0.3868645, 0.067159, 0.9076112, 0.4185268, 0.0328306, -0.4080828, 0.8611934, 0.3030094, 0.0985439, -0.2884121, 0.9524219) }, { ["ViralWorkerRef"] = "vw_e26af733da" })
					I[55] = new("Pose", I[50], "Left Arm", { CFrame = CFrame.new(-0.226737, -0.2923575, 0.2151021, -0.0557991, 0.9102039, 0.4103848, -0.8580655, -0.2538717, 0.4464001, 0.5105, -0.3272282, 0.7951803) }, { ["ViralWorkerRef"] = "vw_28604424e2" })
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 }, { ["ViralWorkerRef"] = "vw_09e5313750" })
			I[57] = new("Pose", I[56], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_5995407b49" })
				I[58] = new("IntValue", I[57], "Null", nil, { ["ViralWorkerRef"] = "vw_6936696ab6" })
				I[59] = new("Pose", I[57], "Torso", { CFrame = CFrame.new(-0.0005302, -0.2081261, 0.1402998, 0.9994591, 0.0328814, -0.0004418, -0.0322188, 0.9764507, -0.2133219, -0.0065829, 0.2132208, 0.9769819) }, { ["ViralWorkerRef"] = "vw_1119904935" })
					I[60] = new("Pose", I[59], "Head", { CFrame = CFrame.new(-0.001329, 0.0428998, -0.0046714, 0.9986404, -0.0432012, -0.0291719, 0.050177, 0.9483224, 0.3133172, 0.0141287, -0.3143549, 0.9492005) }, { ["ViralWorkerRef"] = "vw_184ac25c2f" })
					I[61] = new("Pose", I[59], "Left Leg", { CFrame = CFrame.new(-0.6402889, 0.4041634, 0.0413516, 0.8922055, -0.4280832, 0.1439254, 0.3787876, 0.8828336, 0.2777131, -0.2459465, -0.1932598, 0.9498215) }, { ["ViralWorkerRef"] = "vw_6983f0c240" })
					I[62] = new("Pose", I[59], "Right Arm", { CFrame = CFrame.new(0.4704534, -0.1582903, 0.0744036, -0.3714872, -0.8024136, -0.4670441, 0.6642147, -0.5811691, 0.4701715, -0.6487035, -0.1355549, 0.7488717) }, { ["ViralWorkerRef"] = "vw_08cec79992" })
					I[63] = new("Pose", I[59], "Right Leg", { CFrame = CFrame.new(0.8098574, 0.4270717, 0.0727372, 0.9116317, 0.4103018, 0.0240941, -0.3987512, 0.8687135, 0.2938267, 0.0996267, -0.2774691, 0.955555) }, { ["ViralWorkerRef"] = "vw_7de248aa49" })
					I[64] = new("Pose", I[59], "Left Arm", { CFrame = CFrame.new(-0.3851179, -0.2541693, 0.1118261, -0.3201074, 0.8635674, 0.3895935, -0.7292894, -0.4871024, 0.4804875, 0.6047051, -0.1303186, 0.7857155) }, { ["ViralWorkerRef"] = "vw_8202a2468e" })
		I[65] = new("Keyframe", I[1], "Keyframe", { Time = 0.2833333 }, { ["ViralWorkerRef"] = "vw_126623e728" })
			I[66] = new("Pose", I[65], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_a5d4cb2086" })
				I[67] = new("IntValue", I[66], "Null", nil, { ["ViralWorkerRef"] = "vw_0152dc73a7" })
				I[68] = new("Pose", I[66], "Torso", { CFrame = CFrame.new(-0.0005302, -0.2147026, 0.1146326, 0.9994591, 0.0328814, -0.0004418, -0.0323852, 0.9818647, -0.186797, -0.0057083, 0.1867103, 0.9823985) }, { ["ViralWorkerRef"] = "vw_5228988b61" })
					I[69] = new("Pose", I[68], "Head", { CFrame = CFrame.new(-0.0011537, 0.0376143, -0.0035618, 0.9986945, -0.0440385, -0.0258832, 0.0485652, 0.9756573, 0.213857, 0.0158352, -0.2148348, 0.976522) }, { ["ViralWorkerRef"] = "vw_c78f943b7a" })
					I[70] = new("Pose", I[68], "Left Leg", { CFrame = CFrame.new(-0.6279716, 0.4153304, 0.0455974, 0.9029334, -0.4020043, 0.152001, 0.358415, 0.8995035, 0.2498638, -0.2371717, -0.1711308, 0.9562761) }, { ["ViralWorkerRef"] = "vw_3666ea9d10" })
					I[71] = new("Pose", I[68], "Right Arm", { CFrame = CFrame.new(0.4569914, -0.1240768, 0.0206019, -0.506858, -0.7484159, -0.4277489, 0.6016312, -0.6624971, 0.446248, -0.6173612, -0.0311629, 0.7860622) }, { ["ViralWorkerRef"] = "vw_5424203b10" })
					I[72] = new("Pose", I[68], "Right Leg", { CFrame = CFrame.new(0.7919512, 0.4451559, 0.0750474, 0.9214959, 0.3883841, 0.001935, -0.3744939, 0.8871964, 0.2695119, 0.1029574, -0.2490785, 0.9629952) }, { ["ViralWorkerRef"] = "vw_be69745e13" })
					I[73] = new("Pose", I[68], "Left Arm", { CFrame = CFrame.new(-0.377207, -0.245313, 0.0515522, -0.4737726, 0.8188789, 0.3240019, -0.6780556, -0.5739624, 0.4591383, 0.5619432, -0.0021642, 0.8271728) }, { ["ViralWorkerRef"] = "vw_975b3d518c" })
		I[74] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 }, { ["ViralWorkerRef"] = "vw_006b65404e" })
			I[75] = new("Pose", I[74], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_d14bcb6938" })
				I[76] = new("IntValue", I[75], "Null", nil, { ["ViralWorkerRef"] = "vw_de92251f7a" })
				I[77] = new("Pose", I[75], "Torso", { CFrame = CFrame.new(-0.0005302, -0.1839104, 0.0910034, 0.9994593, 0.0328814, -0.0004418, -0.0325223, 0.9863753, -0.1612643, -0.0048668, 0.1611915, 0.9869112) }, { ["ViralWorkerRef"] = "vw_fac8a6ce76" })
					I[78] = new("Pose", I[77], "Head", { CFrame = CFrame.new(-0.0009847, 0.0325106, -0.0026259, 0.9987637, -0.0446356, -0.0218876, 0.0464701, 0.9946686, 0.0920604, 0.0176618, -0.0929638, 0.9955129) }, { ["ViralWorkerRef"] = "vw_12ddec86a8" })
					I[79] = new("Pose", I[77], "Left Leg", { CFrame = CFrame.new(-0.6071633, 0.4112977, 0.0504273, 0.9164518, -0.3655683, 0.1627146, 0.3295501, 0.9201954, 0.211275, -0.2269648, -0.1400008, 0.963788) }, { ["ViralWorkerRef"] = "vw_cff9ec7975" })
					I[80] = new("Pose", I[77], "Right Arm", { CFrame = CFrame.new(0.4771214, -0.122238, 0.019134, -0.5090082, -0.7424436, -0.435532, 0.5962645, -0.6690521, 0.4436639, -0.6207895, -0.0338637, 0.783246) }, { ["ViralWorkerRef"] = "vw_c17893be2c" })
					I[81] = new("Pose", I[77], "Right Leg", { CFrame = CFrame.new(0.763972, 0.4463193, 0.0742978, 0.9337615, 0.3568452, -0.027406, -0.3409702, 0.9102599, 0.2348747, 0.1087605, -0.2099723, 0.9716395) }, { ["ViralWorkerRef"] = "vw_6e1265b884" })
					I[82] = new("Pose", I[77], "Left Arm", { CFrame = CFrame.new(-0.3965356, -0.260161, 0.0584058, -0.4715466, 0.8161272, 0.3340366, -0.6781322, -0.5777411, 0.4542592, 0.5637203, -0.0123165, 0.8258743) }, { ["ViralWorkerRef"] = "vw_442bf18575" })
		I[83] = new("Keyframe", I[1], "Keyframe", { Time = 0.3833333 }, { ["ViralWorkerRef"] = "vw_6913fa1aaf" })
			I[84] = new("Pose", I[83], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_f7e50368a0" })
				I[85] = new("IntValue", I[84], "Null", nil, { ["ViralWorkerRef"] = "vw_4fe38602dd" })
				I[86] = new("Pose", I[84], "Torso", { CFrame = CFrame.new(-0.0005302, -0.1562233, 0.0697756, 0.9994591, 0.0328814, -0.0004418, -0.0326233, 0.989745, -0.1390707, -0.0041355, 0.1390099, 0.9902825) }, { ["ViralWorkerRef"] = "vw_15f47ce954" })
					I[87] = new("Pose", I[86], "Head", { CFrame = CFrame.new(-0.0008386, 0.0280796, -0.001923, 0.9988256, -0.0447712, -0.0185179, 0.0445735, 0.9989461, -0.010955, 0.0189888, 0.0101167, 0.9997689) }, { ["ViralWorkerRef"] = "vw_6a46f0df21" })
					I[88] = new("Pose", I[86], "Left Leg", { CFrame = CFrame.new(-0.5830729, 0.3980191, 0.0546526, 0.9297701, -0.3249167, 0.1730798, 0.297067, 0.9398625, 0.1685528, -0.2174368, -0.1052991, 0.970378) }, { ["ViralWorkerRef"] = "vw_139927f320" })
					I[89] = new("Pose", I[86], "Right Arm", { CFrame = CFrame.new(0.5030493, -0.1368883, 0.0229878, -0.5043833, -0.7378998, -0.4484433, 0.5940016, -0.6734465, 0.4400369, -0.6267055, -0.0444287, 0.7779887) }, { ["ViralWorkerRef"] = "vw_783b88027c" })
					I[90] = new("Pose", I[86], "Right Leg", { CFrame = CFrame.new(0.7323084, 0.4364576, 0.0709678, 0.9454488, 0.3205743, -0.0579562, -0.3041505, 0.9323517, 0.1954812, 0.1167017, -0.16719, 0.9789935) }, { ["ViralWorkerRef"] = "vw_7bb2983980" })
					I[91] = new("Pose", I[86], "Left Arm", { CFrame = CFrame.new(-0.4187023, -0.2793475, 0.0706633, -0.4638644, 0.8115618, 0.3552426, -0.6802583, -0.5831756, 0.4440217, 0.5675197, -0.0356909, 0.8225861) }, { ["ViralWorkerRef"] = "vw_1701a8642c" })
		I[92] = new("Keyframe", I[1], "Keyframe", { Time = 0.4166667 }, { ["ViralWorkerRef"] = "vw_6db19cb224" })
			I[93] = new("Pose", I[92], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_f2184f3be1" })
				I[94] = new("IntValue", I[93], "Null", nil, { ["ViralWorkerRef"] = "vw_2cd08d17e5" })
				I[95] = new("Pose", I[93], "Torso", { CFrame = CFrame.new(-0.0005302, -0.1323357, 0.0497475, 0.9994593, 0.0328814, -0.0004418, -0.0326913, 0.9920454, -0.1215614, -0.0035588, 0.1215101, 0.9925838) }, { ["ViralWorkerRef"] = "vw_90be6b4234" })
					I[96] = new("Pose", I[95], "Head", { CFrame = CFrame.new(-0.0007219, 0.0245754, -0.0014521, 0.9988529, -0.0447285, -0.0171108, 0.0437462, 0.9975813, -0.0540182, 0.0194856, 0.0532078, 0.9983934) }, { ["ViralWorkerRef"] = "vw_859046c85d" })
					I[97] = new("Pose", I[95], "Left Leg", { CFrame = CFrame.new(-0.5606818, 0.3814957, 0.0576663, 0.9406816, -0.2868738, 0.1811667, 0.2664824, 0.9551882, 0.1288504, -0.2100122, -0.0729295, 0.9749752) }, { ["ViralWorkerRef"] = "vw_61a2873892" })
					I[98] = new("Pose", I[95], "Right Arm", { CFrame = CFrame.new(0.5216596, -0.1814806, 0.0283001, -0.4974267, -0.7347878, -0.4611438, 0.5933493, -0.6759631, 0.4370475, -0.6328536, -0.0562203, 0.7722281) }, { ["ViralWorkerRef"] = "vw_f0687b5650" })
					I[99] = new("Pose", I[95], "Right Leg", { CFrame = CFrame.new(0.7031559, 0.421782, 0.0662448, 0.9545799, 0.2857083, -0.0845463, -0.2702641, 0.9497337, 0.1579967, 0.1254374, -0.1279706, 0.9838136) }, { ["ViralWorkerRef"] = "vw_8c499f8973" })
					I[100] = new("Pose", I[95], "Left Arm", { CFrame = CFrame.new(-0.4337023, -0.3228768, 0.0825562, -0.4548614, 0.8069403, 0.3767605, -0.6824703, -0.5876361, 0.4346471, 0.5721325, -0.0594237, 0.8180059) }, { ["ViralWorkerRef"] = "vw_eb4d9e73a4" })
	return I[1]
end

return build
