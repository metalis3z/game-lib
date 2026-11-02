-- Generated from animations/ServerStorage/RBX_ANIMSAVES/R6/Walk2 [by emm1gar].rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk2 [by emm1gar]", nil, { ["ViralWorkerRef"] = "vw_7bddf502f5" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_708acffa1a" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_1975b873d8" })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9984044, -0.0562906, 0.0044754, 0.0564669, 0.9947086, -0.0858266, 0.0003795, 0.0859423, 0.9963) }, { ["ViralWorkerRef"] = "vw_4ae56929fd" })
					I[5] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000019, -0.0000001, 0, 0.9978293, 0.0656087, -0.0056587, -0.0656086, 0.9978452, 0.0002109, 0.0056603, 0.0001609, 0.999984) }, { ["ViralWorkerRef"] = "vw_407cd544c2" })
					I[6] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.2081364, -0.0125158, -0.0209655, 0.8793159, 0.4759359, -0.0169861, -0.4745406, 0.8786322, 0.0530736, 0.0401841, -0.0386079, 0.9984461) }, { ["ViralWorkerRef"] = "vw_1b9a3277f0" })
					I[7] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1429331, -0.2647428, -0.0072923, 0.7003267, -0.6018335, 0.3838463, 0.5817841, 0.7928131, 0.1815888, -0.4136046, 0.0961443, 0.9053656) }, { ["ViralWorkerRef"] = "vw_a7931948ff" })
					I[8] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.2053217, -0.2663485, 0.0187871, 0.6993709, 0.7089269, -0.0911203, -0.7118884, 0.7022926, 0, 0.0639931, 0.0648675, 0.9958399) }, { ["ViralWorkerRef"] = "vw_106e4461dd" })
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.1218759, -0.1846478, 0.0030621, 0.8192413, -0.548762, 0.1664423, 0.5248937, 0.8344797, 0.1677206, -0.2309315, -0.0500391, 0.9716822) }, { ["ViralWorkerRef"] = "vw_ca2db7ac8e" })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 }, { ["ViralWorkerRef"] = "vw_bd6309930f" })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_dfcc52dd86" })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999251, -0.0113888, 0.0044754, 0.011731, 0.996241, -0.0858266, -0.0034811, 0.0858726, 0.9963) }, { ["ViralWorkerRef"] = "vw_573e9394f1" })
					I[13] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0000038, -0.0000001, 0.000001, 0.9994081, 0.0342669, -0.0029598, -0.0342665, 0.9994123, 0.0001853, 0.0029644, -0.0000837, 0.9999955) }, { ["ViralWorkerRef"] = "vw_7f4f079a0f" })
					I[14] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.4190316, 0.1249608, -0.0342805, 0.9925297, 0.1176714, -0.0322155, -0.1160871, 0.9921128, 0.0472894, 0.037526, -0.0431963, 0.9983613) }, { ["ViralWorkerRef"] = "vw_bd10d86cc1" })
					I[15] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0189481, -0.292241, 0.0349699, 0.9557444, -0.2507642, 0.1538425, 0.2372277, 0.9661782, 0.1011056, -0.1739931, -0.0601355, 0.9829081) }, { ["ViralWorkerRef"] = "vw_10b24beefd" })
					I[16] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.3806664, -0.1367835, 0.0347433, 0.5793884, 0.8099604, -0.0909571, -0.8133415, 0.5817865, -0.0001831, 0.0527693, 0.0740852, 0.9958548) }, { ["ViralWorkerRef"] = "vw_81ba088f66" })
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0202832, -0.2272711, 0.0224814, 0.9528231, -0.2901226, 0.089194, 0.280255, 0.9537735, 0.1085035, -0.1165503, -0.0783877, 0.9900858) }, { ["ViralWorkerRef"] = "vw_b27a3aecc0" })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 }, { ["ViralWorkerRef"] = "vw_a5c3735935" })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_208c1df5ee" })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0.0004751, -0.0091385, 0.106086, 0.9999657, 0.0080431, 0.0019894, -0.0078424, 0.9962713, -0.0859201, -0.002673, 0.0859016, 0.9963) }, { ["ViralWorkerRef"] = "vw_30bdd5b18a" })
					I[21] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0.0000058, -0.0000018, 0.000001, 0.9998543, -0.0170089, 0.0014507, 0.0170084, 0.9998553, 0.0002842, -0.0014553, -0.0002595, 0.9999988) }, { ["ViralWorkerRef"] = "vw_3bf9719c3b" })
					I[22] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.039895, -0.0912552, -0.0252627, 0.9968387, 0.0658102, -0.0445163, -0.0645424, 0.9974836, 0.0293435, 0.0463354, -0.0263775, 0.9985777) }, { ["ViralWorkerRef"] = "vw_0cb165a65e" })
					I[23] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(-0.0279451, -0.2819393, 0.0326537, 0.9755844, 0.218158, -0.0253395, -0.214293, 0.970813, 0.1077029, 0.048096, -0.0996431, 0.9938598) }, { ["ViralWorkerRef"] = "vw_e7866727ba" })
					I[24] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(1.0775914, 0.0349801, 0.0674369, 0.9185122, 0.394253, -0.0299956, -0.3953919, 0.9159839, -0.0681084, 0.0006235, 0.0744185, 0.997227) }, { ["ViralWorkerRef"] = "vw_31253ced07" })
					I[25] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.0588819, -0.2504711, 0.0161896, 0.9654509, 0.2583186, -0.0342904, -0.2489367, 0.9531786, 0.1716997, 0.077038, -0.1572316, 0.9845519) }, { ["ViralWorkerRef"] = "vw_4129ee2858" })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 }, { ["ViralWorkerRef"] = "vw_3440a8c29b" })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_3c733ff5fc" })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0.0004754, -0.0091398, 0.1060859, 0.9957429, 0.0920233, -0.0052628, -0.0921349, 0.9920447, -0.0857819, -0.002673, 0.0859016, 0.9963) }, { ["ViralWorkerRef"] = "vw_bdbd2c8075" })
					I[29] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.0000058, -0.0000015, 0.0000019, 0.9977028, -0.0674939, 0.0057863, 0.0674914, 0.9977197, 0.0006027, -0.0058138, -0.0002108, 0.999983) }, { ["ViralWorkerRef"] = "vw_30c0479ad2" })
					I[30] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(-0.0398926, -0.0912555, -0.0252625, 0.9090675, -0.4102004, 0.0730253, 0.4105146, 0.9117836, 0.0113492, -0.071239, 0.0196608, 0.9972652) }, { ["ViralWorkerRef"] = "vw_85140a7d5e" })
					I[31] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.0595594, -0.2749927, 0.031096, 0.917403, 0.3871904, -0.0919562, -0.3759754, 0.9190047, 0.1186267, 0.130439, -0.0742551, 0.9886712) }, { ["ViralWorkerRef"] = "vw_e2b78c62a3" })
					I[32] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(1.0896432, 0.218965, 0.0235742, 0.9943876, 0.0772395, 0.0723023, -0.0788922, 0.9966766, 0.020285, -0.0704957, -0.0258754, 0.9971758) }, { ["ViralWorkerRef"] = "vw_25808ed3da" })
					I[33] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.1628887, -0.2236696, 0.0096523, 0.8777595, 0.4788714, 0.0148508, -0.4789234, 0.8761658, 0.0544589, 0.0130665, -0.0549141, 0.998405) }, { ["ViralWorkerRef"] = "vw_7b7bf471ab" })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 }, { ["ViralWorkerRef"] = "vw_51257df001" })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_4da54d27cb" })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9984044, 0.0562906, -0.0044754, -0.0564669, 0.9947086, -0.0858266, -0.0003795, 0.0859423, 0.9963) }, { ["ViralWorkerRef"] = "vw_703cd6ed11" })
					I[37] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0.0000058, -0.0000018, 0.0000029, 0.9999079, -0.0135131, 0.0011514, 0.0135125, 0.9999083, 0.0003946, -0.0011567, -0.000379, 0.9999992) }, { ["ViralWorkerRef"] = "vw_f58955d263" })
					I[38] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(-0.2053217, -0.2663485, 0.0187871, 0.6993709, -0.7089269, 0.0911203, 0.7118884, 0.7022926, 0, -0.0639931, 0.0648675, 0.9958399) }, { ["ViralWorkerRef"] = "vw_322179d131" })
					I[39] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(-0.1110007, -0.2465462, 0.0231605, 0.8199562, 0.4958939, -0.2859388, -0.4837156, 0.8673531, 0.1171206, 0.3060892, 0.0422796, 0.951063) }, { ["ViralWorkerRef"] = "vw_fccda035f9" })
					I[40] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0.2081364, -0.0125158, -0.0209655, 0.8793159, -0.4759359, 0.0169861, 0.4745406, 0.8786322, 0.0530736, -0.0401841, -0.0386079, 0.9984461) }, { ["ViralWorkerRef"] = "vw_1566ed358c" })
					I[41] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(-0.1628878, -0.22367, 0.0096511, 0.7648804, 0.6356927, -0.1041713, -0.6305625, 0.7719318, 0.080697, 0.1317111, 0.0039631, 0.9912795) }, { ["ViralWorkerRef"] = "vw_e0eb8ea1a7" })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.5833333 }, { ["ViralWorkerRef"] = "vw_0c65e9b3f5" })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_d66cb697d5" })
				I[44] = new("Pose", I[43], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999251, 0.0113888, -0.0044754, -0.011731, 0.996241, -0.0858266, 0.0034811, 0.0858726, 0.9963) }, { ["ViralWorkerRef"] = "vw_93c354725b" })
					I[45] = new("Pose", I[44], "Head", { CFrame = CFrame.new(0.0000018, -0.000001, 0.0000033, 0.9989851, 0.0448703, -0.003852, -0.0448682, 0.9989921, 0.0006776, 0.0038785, -0.0005041, 0.9999922) }, { ["ViralWorkerRef"] = "vw_7a06af5c52" })
					I[46] = new("Pose", I[44], "Left Leg", { CFrame = CFrame.new(-0.3806664, -0.1367835, 0.0347433, 0.5793884, -0.8099604, 0.0909571, 0.8133415, 0.5817865, -0.0001831, -0.0527693, 0.0740852, 0.9958548) }, { ["ViralWorkerRef"] = "vw_a54f1e9003" })
					I[47] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(-0.029259, -0.2934173, 0.0470942, 0.9016128, 0.3676788, -0.2278289, -0.3564977, 0.9299527, 0.0899837, 0.244955, 0.0000903, 0.9695336) }, { ["ViralWorkerRef"] = "vw_15618c92ef" })
					I[48] = new("Pose", I[44], "Right Leg", { CFrame = CFrame.new(0.3726987, 0.0313017, -0.0285735, 0.9961532, -0.0808521, 0.0337866, 0.0792444, 0.9957708, 0.0464883, -0.0374024, -0.043632, 0.9983469) }, { ["ViralWorkerRef"] = "vw_b4df05de5c" })
					I[49] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(-0.0569161, -0.2984171, 0.013378, 0.8168256, 0.5767009, 0.0144818, -0.5761635, 0.8142967, 0.070398, 0.0288057, -0.0658467, 0.997413) }, { ["ViralWorkerRef"] = "vw_8b64f040ba" })
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 }, { ["ViralWorkerRef"] = "vw_c9e5c22a35" })
			I[51] = new("Pose", I[50], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_22153c1aba" })
				I[52] = new("Pose", I[51], "Torso", { CFrame = CFrame.new(-0.0004751, -0.0091385, 0.106086, 0.9999657, -0.0080431, -0.0019894, 0.0078424, 0.9962713, -0.0859201, 0.002673, 0.0859016, 0.9963) }, { ["ViralWorkerRef"] = "vw_8a80c3c173" })
					I[53] = new("Pose", I[52], "Head", { CFrame = CFrame.new(-0.0000057, -0.0000001, 0.0000033, 0.9996846, -0.0250258, 0.0021395, 0.0250249, 0.9996868, 0.0004301, -0.0021496, -0.0003764, 0.9999973) }, { ["ViralWorkerRef"] = "vw_2a0145c539" })
					I[54] = new("Pose", I[52], "Left Leg", { CFrame = CFrame.new(-1.0775914, 0.0349801, 0.0674369, 0.9185122, -0.394253, 0.0299956, 0.3953919, 0.9159839, -0.0681084, -0.0006235, 0.0744185, 0.997227) }, { ["ViralWorkerRef"] = "vw_e522f65831" })
					I[55] = new("Pose", I[52], "Right Arm", { CFrame = CFrame.new(0.0131536, -0.3069377, 0.0503048, 0.9933508, 0.0960987, -0.0634046, -0.0898413, 0.9914074, 0.0950774, 0.0719965, -0.0887486, 0.9934483) }, { ["ViralWorkerRef"] = "vw_f584c0f8ab" })
					I[56] = new("Pose", I[52], "Right Leg", { CFrame = CFrame.new(0.039895, -0.0912552, -0.0252627, 0.9968387, -0.0658102, 0.0445163, 0.0645424, 0.9974836, 0.0293435, -0.0463354, -0.0263775, 0.9985777) }, { ["ViralWorkerRef"] = "vw_f76296f137" })
					I[57] = new("Pose", I[52], "Left Arm", { CFrame = CFrame.new(-0.0095398, -0.3318317, 0.0150456, 0.9889997, 0.0991395, 0.1097734, -0.1132798, 0.9848726, 0.131122, -0.0951138, -0.1421145, 0.9852695) }, { ["ViralWorkerRef"] = "vw_de775b05e5" })
		I[58] = new("Keyframe", I[1], "Keyframe", { Time = 0.8166667 }, { ["ViralWorkerRef"] = "vw_272307d722" })
			I[59] = new("Pose", I[58], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_bd8a95a062" })
				I[60] = new("Pose", I[59], "Torso", { CFrame = CFrame.new(-0.0004754, -0.0091398, 0.1060859, 0.9957429, -0.0920233, 0.0052628, 0.0921349, 0.9920447, -0.0857819, 0.002673, 0.0859016, 0.9963) }, { ["ViralWorkerRef"] = "vw_109ca9ea71" })
					I[61] = new("Pose", I[60], "Head", { CFrame = CFrame.new(-0.0000038, 0.0000002, 0.0000024, 0.9983614, 0.0570136, -0.0048915, -0.0570104, 0.9983735, 0.0007634, 0.0049271, -0.0004833, 0.9999874) }, { ["ViralWorkerRef"] = "vw_a8b12a395e" })
					I[62] = new("Pose", I[60], "Left Leg", { CFrame = CFrame.new(-1.0896432, 0.218965, 0.0235742, 0.9943876, -0.0772395, -0.0723023, 0.0788922, 0.9966766, 0.020285, 0.0704957, -0.0258754, 0.9971758) }, { ["ViralWorkerRef"] = "vw_b9ed38e00c" })
					I[63] = new("Pose", I[60], "Right Arm", { CFrame = CFrame.new(0.0200479, -0.3644423, 0.0559042, 0.9524788, -0.2888005, 0.0968447, 0.2713761, 0.9489411, 0.1608299, -0.1383479, -0.1269055, 0.9822181) }, { ["ViralWorkerRef"] = "vw_50b6bcbf1a" })
					I[64] = new("Pose", I[60], "Right Leg", { CFrame = CFrame.new(0.0398926, -0.0912555, -0.0252625, 0.9090675, 0.4102004, -0.0730253, -0.4105146, 0.9117836, 0.0113492, 0.071239, 0.0196608, 0.9972652) }, { ["ViralWorkerRef"] = "vw_79658dbb69" })
					I[65] = new("Pose", I[60], "Left Arm", { CFrame = CFrame.new(0.0686078, -0.3407798, 0.0075241, 0.8952833, -0.4098896, 0.1745211, 0.3546313, 0.8928194, 0.2776853, -0.2696363, -0.1867162, 0.9446864) }, { ["ViralWorkerRef"] = "vw_c9342a75fe" })
		I[66] = new("Keyframe", I[1], "Keyframe", { Time = 0.9166667 }, { ["ViralWorkerRef"] = "vw_c3059d51e1" })
			I[67] = new("Pose", I[66], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_498a1b6580" })
				I[68] = new("Pose", I[67], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9984044, -0.0562906, 0.0044754, 0.0564669, 0.9947086, -0.0858266, 0.0003795, 0.0859423, 0.9963) }, { ["ViralWorkerRef"] = "vw_2620dfc339" })
					I[69] = new("Pose", I[68], "Head", { CFrame = CFrame.new(0.0000019, -0.0000001, 0, 0.9978293, 0.0656087, -0.0056587, -0.0656086, 0.9978452, 0.0002109, 0.0056603, 0.0001609, 0.999984) }, { ["ViralWorkerRef"] = "vw_c4c391a42a" })
					I[70] = new("Pose", I[68], "Left Leg", { CFrame = CFrame.new(-0.2081364, -0.0125158, -0.0209655, 0.8793159, 0.4759359, -0.0169861, -0.4745406, 0.8786322, 0.0530736, 0.0401841, -0.0386079, 0.9984461) }, { ["ViralWorkerRef"] = "vw_a1fab33c18" })
					I[71] = new("Pose", I[68], "Right Arm", { CFrame = CFrame.new(0.1429331, -0.2647428, -0.0072923, 0.7003267, -0.6018335, 0.3838463, 0.5817841, 0.7928131, 0.1815888, -0.4136046, 0.0961443, 0.9053656) }, { ["ViralWorkerRef"] = "vw_81a52fc1d0" })
					I[72] = new("Pose", I[68], "Right Leg", { CFrame = CFrame.new(0.2053217, -0.2663485, 0.0187871, 0.6993709, 0.7089269, -0.0911203, -0.7118884, 0.7022926, 0, 0.0639931, 0.0648675, 0.9958399) }, { ["ViralWorkerRef"] = "vw_a39b4c54fe" })
					I[73] = new("Pose", I[68], "Left Arm", { CFrame = CFrame.new(0.1218759, -0.1846478, 0.0030621, 0.8192413, -0.548762, 0.1664423, 0.5248937, 0.8344797, 0.1677206, -0.2309315, -0.0500391, 0.9716822) }, { ["ViralWorkerRef"] = "vw_8949e89079" })
	return I[1]
end

return build
