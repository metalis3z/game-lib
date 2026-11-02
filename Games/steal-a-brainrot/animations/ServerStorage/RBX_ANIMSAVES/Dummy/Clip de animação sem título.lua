-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Dummy/Clip de animação sem título.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Clip de animação sem título", { Priority = Enum.AnimationPriority.Movement }, { ["ViralWorkerRef"] = "vw_5872c76ce6" }, { "1638500988" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_b83aedc2a3" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_fcec918491" })
				I[4] = new("Pose", I[3], "LowerTorso", { CFrame = CFrame.new(0.0000076, 0.000001, -0.0000153, 0.9986295, 0, -0.0523361, 0.0090881, 0.9848077, 0.1734105, 0.051541, -0.1736485, 0.983458) }, { ["ViralWorkerRef"] = "vw_6cd3f23b20" })
					I[5] = new("Pose", I[4], "UpperTorso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_6248f2bc18" })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0, 0.0000088, 0.0000153, 0.9509925, -0.1029405, -0.2915754, 0.2489266, 0.8142624, 0.5244162, 0.1834353, -0.5712966, 0.7999822) }, { ["ViralWorkerRef"] = "vw_feae611c4c" })
							I[7] = new("Pose", I[6], "LeftLowerArm", nil, { ["ViralWorkerRef"] = "vw_ff5f6ef337" })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0.0000153, 0.0000012, 0, 0.8951496, 0.1564344, 0.4174151, 0.088526, 0.8553633, -0.5104085, -0.4368871, 0.4938439, 0.7518297) }, { ["ViralWorkerRef"] = "vw_0763c1b5af" })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(-0.0000076, 0.0000076, 0.0000458, 1, 0, 0, 0, 0.9681475, -0.25038, 0, 0.2503797, 0.9681478) }, { ["ViralWorkerRef"] = "vw_1b1f90ad2c" })
					I[10] = new("Pose", I[4], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000038, 0, 1, 0, 0, 0, 0.9659259, 0.2588188, 0, -0.2588188, 0.9659259) }, { ["ViralWorkerRef"] = "vw_a4973990c2" })
						I[11] = new("Pose", I[10], "RightLowerLeg", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.3746066, 0.9271839, 0, -0.9271839, 0.3746066) }, { ["ViralWorkerRef"] = "vw_a664c82d8a" })
					I[12] = new("Pose", I[4], "LeftUpperLeg", { CFrame = CFrame.new(0, -0.0000014, 0, 1, 0, 0, 0, 0.8386706, -0.5446389, 0, 0.5446389, 0.8386706) }, { ["ViralWorkerRef"] = "vw_ba5a582596" })
						I[13] = new("Pose", I[12], "LeftLowerLeg", { CFrame = CFrame.new(0, -0.0927238, 0.0375061, 1, 0, 0, 0, 0.990268, 0.1391737, 0, -0.1391737, 0.990268) }, { ["ViralWorkerRef"] = "vw_6fff37dafc" })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 }, { ["ViralWorkerRef"] = "vw_c6603d6fea" })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_cc3190e9a3" })
				I[16] = new("Pose", I[15], "LowerTorso", { CFrame = CFrame.new(0.0000076, -0.0000005, 0, 0.9999906, 0, -0.004364, 0.0007578, 0.9848077, 0.1736471, 0.0042977, -0.1736487, 0.9847982) }, { ["ViralWorkerRef"] = "vw_b52e63461a" })
					I[17] = new("Pose", I[16], "UpperTorso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_3f9b59e108" })
						I[18] = new("Pose", I[17], "LeftUpperArm", { CFrame = CFrame.new(-0.0000076, 0.0000069, 0.0000153, 0.9811764, 0.0009703, 0.1931118, -0.0112204, 0.9985844, 0.0519921, -0.192788, -0.0531802, 0.9797983) }, { ["ViralWorkerRef"] = "vw_08d88b5afe" })
							I[19] = new("Pose", I[18], "LeftLowerArm", { CFrame = CFrame.new(0, 0.000001, 0, 1.0000001, 0, 0, 0, 0.9781474, -0.2079117, 0, 0.2079117, 0.9781476) }, { ["ViralWorkerRef"] = "vw_bc1432f954" })
						I[20] = new("Pose", I[17], "RightUpperArm", { CFrame = CFrame.new(-0.0000076, -0.0000091, 0, 0.9956186, -0.0676024, 0.0646036, 0.0668046, 0.9976616, 0.0144334, -0.0654282, -0.0100544, 0.9978066) }, { ["ViralWorkerRef"] = "vw_91f8c4c4bd" })
							I[21] = new("Pose", I[20], "RightLowerArm", { CFrame = CFrame.new(-0.0000153, 0.0000086, 0.0000458, 1, 0, 0, 0, 0.990268, -0.1391731, 0, 0.1391731, 0.990268) }, { ["ViralWorkerRef"] = "vw_e4f0e2293a" })
					I[22] = new("Pose", I[16], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000076, 0, 1, 0, 0, 0, 0.6156614, -0.7880111, 0, 0.7880111, 0.6156614) }, { ["ViralWorkerRef"] = "vw_495d8841da" })
						I[23] = new("Pose", I[22], "RightLowerLeg", { CFrame = CFrame.new(0, -0.0000229, -0.0000229, 1, 0, 0, 0, 0.0000001, 1.0000002, 0, -1.0000002, 0.0000001) }, { ["ViralWorkerRef"] = "vw_634f73f71b" })
					I[24] = new("Pose", I[16], "LeftUpperLeg", { CFrame = CFrame.new(0, -0.0000076, 0.0000153, 1, 0, 0, 0, 0.9563048, -0.2923716, 0, 0.2923716, 0.9563048) }, { ["ViralWorkerRef"] = "vw_876f5f62c7" })
						I[25] = new("Pose", I[24], "LeftLowerLeg", { CFrame = CFrame.new(0, -0.092701, 0.0375061, 1, 0, 0, 0, 0.9659254, 0.25882, 0, -0.25882, 0.9659254) }, { ["ViralWorkerRef"] = "vw_002dbefc55" })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 }, { ["ViralWorkerRef"] = "vw_118916f6d0" })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_94d682045d" })
				I[28] = new("Pose", I[27], "LowerTorso", { CFrame = CFrame.new(0.0000076, 0.000001, -0.0000153, 0.9998214, 0, -0.0189068, 0.0032831, 0.9848077, 0.1736176, 0.0186196, -0.1736487, 0.9846315) }, { ["ViralWorkerRef"] = "vw_3b56297cd8" })
					I[29] = new("Pose", I[28], "UpperTorso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_cd91e74639" })
						I[30] = new("Pose", I[29], "LeftUpperArm", { CFrame = CFrame.new(-0.0000076, 0.0000069, 0.0000153, 0.9811764, 0.0009703, 0.1931118, -0.0112204, 0.9985844, 0.0519921, -0.192788, -0.0531802, 0.9797983) }, { ["ViralWorkerRef"] = "vw_56c851e9e7" })
							I[31] = new("Pose", I[30], "LeftLowerArm", { CFrame = CFrame.new(0, 0.000001, 0, 1.0000001, 0, 0, 0, 0.9781474, -0.2079117, 0, 0.2079117, 0.9781476) }, { ["ViralWorkerRef"] = "vw_1e905c6e2c" })
						I[32] = new("Pose", I[29], "RightUpperArm", { CFrame = CFrame.new(-0.0000076, -0.0000091, 0, 0.9956186, -0.0676024, 0.0646036, 0.0668046, 0.9976616, 0.0144334, -0.0654282, -0.0100544, 0.9978066) }, { ["ViralWorkerRef"] = "vw_0ba8ee3919" })
							I[33] = new("Pose", I[32], "RightLowerArm", { CFrame = CFrame.new(-0.0000153, 0.0000086, 0.0000458, 1, 0, 0, 0, 0.990268, -0.1391731, 0, 0.1391731, 0.990268) }, { ["ViralWorkerRef"] = "vw_be4c6ef5e3" })
					I[34] = new("Pose", I[28], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000095, 0.0000305, 1, 0, 0, 0, 0.9455185, -0.3255684, 0, 0.3255684, 0.9455185) }, { ["ViralWorkerRef"] = "vw_709d2a287e" })
					I[35] = new("Pose", I[28], "LeftUpperLeg", { CFrame = CFrame.new(0, -0.0000076, 0.0000153, 1, 0, 0, 0, 0.9563048, -0.2923716, 0, 0.2923716, 0.9563048) }, { ["ViralWorkerRef"] = "vw_3c4b3ebbdf" })
						I[36] = new("Pose", I[35], "LeftLowerLeg", { CFrame = CFrame.new(0, -0.0926952, 0.0374908, 1, 0, 0, 0, -0.139174, 0.9902678, 0, -0.9902678, -0.139174) }, { ["ViralWorkerRef"] = "vw_409de7d1ab" })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 1.2 }, { ["ViralWorkerRef"] = "vw_983e3f04e2" })
			I[38] = new("Pose", I[37], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_afca527000" })
				I[39] = new("Pose", I[38], "LowerTorso", { CFrame = CFrame.new(0.0000076, 0.000001, -0.0000153, 0.9986295, 0, -0.0523361, 0.0090881, 0.9848077, 0.1734105, 0.051541, -0.1736485, 0.983458) }, { ["ViralWorkerRef"] = "vw_d4d39efb61" })
					I[40] = new("Pose", I[39], "UpperTorso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_dbe290b854" })
						I[41] = new("Pose", I[40], "LeftUpperArm", { CFrame = CFrame.new(0, 0.0000088, 0.0000153, 0.9509925, -0.1029405, -0.2915754, 0.2489266, 0.8142624, 0.5244162, 0.1834353, -0.5712966, 0.7999822) }, { ["ViralWorkerRef"] = "vw_4c7632a53c" })
							I[42] = new("Pose", I[41], "LeftLowerArm", nil, { ["ViralWorkerRef"] = "vw_5ece30f2ed" })
						I[43] = new("Pose", I[40], "RightUpperArm", { CFrame = CFrame.new(0.0000153, 0.0000012, 0, 0.8951496, 0.1564344, 0.4174151, 0.088526, 0.8553633, -0.5104085, -0.4368871, 0.4938439, 0.7518297) }, { ["ViralWorkerRef"] = "vw_5bacb9a1f1" })
							I[44] = new("Pose", I[43], "RightLowerArm", { CFrame = CFrame.new(-0.0000076, 0.0000076, 0.0000458, 1, 0, 0, 0, 0.9681475, -0.25038, 0, 0.2503797, 0.9681478) }, { ["ViralWorkerRef"] = "vw_4ba0a5868b" })
					I[45] = new("Pose", I[39], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000038, 0, 1, 0, 0, 0, 0.9659259, 0.2588188, 0, -0.2588188, 0.9659259) }, { ["ViralWorkerRef"] = "vw_c22e7a0f3f" })
						I[46] = new("Pose", I[45], "RightLowerLeg", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.3746066, 0.9271839, 0, -0.9271839, 0.3746066) }, { ["ViralWorkerRef"] = "vw_d93ff478d5" })
					I[47] = new("Pose", I[39], "LeftUpperLeg", { CFrame = CFrame.new(0, -0.0000014, 0, 1, 0, 0, 0, 0.8386706, -0.5446389, 0, 0.5446389, 0.8386706) }, { ["ViralWorkerRef"] = "vw_45dcb882ba" })
						I[48] = new("Pose", I[47], "LeftLowerLeg", { CFrame = CFrame.new(0, -0.0927238, 0.0375061, 1, 0, 0, 0, 0.990268, 0.1391737, 0, -0.1391737, 0.990268) }, { ["ViralWorkerRef"] = "vw_16f2cb6d34" })
		I[49] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 }, { ["ViralWorkerRef"] = "vw_beadcdac00" })
			I[50] = new("Pose", I[49], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_5982938b86" })
				I[51] = new("Pose", I[50], "LowerTorso", { CFrame = CFrame.new(0.0000153, -0.0000005, 0, 0.9977628, 0, 0.0668539, -0.0116091, 0.9848076, 0.1732603, -0.0658382, -0.1736488, 0.9826045) }, { ["ViralWorkerRef"] = "vw_b83cb2e40e" })
					I[52] = new("Pose", I[51], "UpperTorso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_6073b33a04" })
						I[53] = new("Pose", I[52], "LeftUpperArm", { CFrame = CFrame.new(-0.0000153, -0.0000007, 0.0000153, 0.8517071, -0.0641389, -0.5200782, -0.1725311, 0.9028211, -0.393887, 0.4948011, 0.4252061, 0.7578732) }, { ["ViralWorkerRef"] = "vw_9b153c9196" })
						I[54] = new("Pose", I[52], "RightUpperArm", { CFrame = CFrame.new(-0.0000153, 0.000006, 0.0000153, 0.9688334, 0.1683467, 0.1817166, -0.2466225, 0.7242681, 0.6439046, -0.0232123, -0.6686517, 0.7432133) }, { ["ViralWorkerRef"] = "vw_0243da4878" })
							I[55] = new("Pose", I[54], "RightLowerArm", { CFrame = CFrame.new(-0.0000153, 0.0000229, 0.000061, 0.9999999, 0, 0, 0, 0.9992851, -0.0378065, 0, 0.0378065, 0.999285) }, { ["ViralWorkerRef"] = "vw_1bbf0119a5" })
					I[56] = new("Pose", I[51], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000057, 0.0000153, 1, 0, 0, 0, 0.7193397, -0.6946586, 0, 0.6946586, 0.7193397) }, { ["ViralWorkerRef"] = "vw_bdaab0b94e" })
						I[57] = new("Pose", I[56], "RightLowerLeg", { CFrame = CFrame.new(0, 0, -0.0000458, 1, 0, 0, 0, 0.9743701, 0.2249513, 0, -0.2249513, 0.9743701) }, { ["ViralWorkerRef"] = "vw_8ebe2c26ef" })
					I[58] = new("Pose", I[51], "LeftUpperLeg", { CFrame = CFrame.new(0, -0.0000076, 0.0000153, 1, 0, 0, 0, 0.9848079, 0.1736475, 0, -0.1736475, 0.9848079) }, { ["ViralWorkerRef"] = "vw_fa750f2d2c" })
						I[59] = new("Pose", I[58], "LeftLowerLeg", { CFrame = CFrame.new(0, -0.0927162, 0.0375214, 1, 0, 0, 0, 0.5299186, 0.8480482, 0, -0.8480482, 0.5299186) }, { ["ViralWorkerRef"] = "vw_69501dad7a" })
	return I[1]
end

return build
