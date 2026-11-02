-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1719522752" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.1599884, -0.1088638, -0.4367065, 0.9075896, -0.4181514, -0.0378458, 0.0666834, 0.2325539, -0.9702958, 0.4145312, 0.8781051, 0.2389469) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0.1083374, -0.1437683, 0, 0.7986388, -0.6018121, 0, 0.6018114, 0.7986385, -0.0000003, -0.0000002, -0.0000001, 1.0000011) })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(-0.010025, -0.034111, -0.4065552, 0.990269, 0.1017845, 0.0949163, -0.0000001, 0.6820019, -0.7313516, -0.1391731, 0.7242334, 0.6753641) })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(-0.14888, -0.1186523, -0.1107483, 0.6077385, 0.7941258, 0.0044748, -0.6395416, 0.4927616, -0.5900622, -0.4707876, 0.3557412, 0.8073464) })
								I[10] = new("Pose", I[9], "RightHand", { CFrame = CFrame.new(-0.0541229, -0.0957031, -0.0023041, 1.0000002, 0.0000004, 0.0000001, 0.0000004, 1.0000008, 0, 0.0000001, 0, 1.0000008) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "LowerTorso", { Weight = 0 })
					I[14] = new("Pose", I[13], "UpperTorso", { CFrame = CFrame.new(0, -0.0000229, 0, 0.965167, 0.0067808, -0.2615505, 0.087274, 0.9340667, 0.3462722, 0.2466533, -0.3570366, 0.9009368) })
						I[15] = new("Pose", I[14], "LeftUpperArm", { CFrame = CFrame.new(0.0612183, -0.0673599, -0.8763733, 0.9639106, -0.2607698, -0.0536405, 0.1884456, 0.8106169, -0.5544279, 0.1880594, 0.5243103, 0.8305014) })
							I[16] = new("Pose", I[15], "LeftLowerArm", { CFrame = CFrame.new(0.0140076, -0.4094048, 0.068161, 0.734392, -0.6426717, 0.2182733, 0.6066108, 0.7657511, 0.2136596, -0.3044561, -0.0245029, 0.9522113) })
						I[17] = new("Pose", I[14], "RightUpperArm", { CFrame = CFrame.new(-0.1255798, -0.2613144, -1.0508118, 0.9543552, 0.2525828, 0.159405, -0.2370133, 0.9652121, -0.1104171, -0.1817493, 0.0675965, 0.981019) })
							I[18] = new("Pose", I[17], "RightLowerArm", { CFrame = CFrame.new(-0.0923462, -0.1524506, -0.4037476, 0.6289888, 0.7732193, 0.0806673, -0.7184445, 0.617781, -0.3196649, -0.2970057, 0.1431105, 0.9440906) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "UpperTorso", { CFrame = CFrame.new(0, -0.0000229, 0, 0.9608328, 0.014132, -0.2767714, 0.1219228, 0.8753015, 0.4679573, 0.2488713, -0.4833726, 0.8392938) })
						I[23] = new("Pose", I[22], "LeftUpperArm", { CFrame = CFrame.new(0.0743103, -0.6165085, -0.8423157, 0.7495668, -0.6557528, 0.0902206, 0.6290531, 0.6632673, -0.4054263, 0.2060187, 0.3606475, 0.9096647) })
						I[24] = new("Pose", I[22], "RightUpperArm", { CFrame = CFrame.new(-0.2066345, 0.0153046, -0.8792419, 0.9757274, -0.2091914, 0.0647843, 0.2020443, 0.9740332, 0.1021724, -0.0844757, -0.0866025, 0.9926551) })
		I[25] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 })
			I[26] = new("Pose", I[25], "HumanoidRootPart", { Weight = 0 })
				I[27] = new("Pose", I[26], "LowerTorso", { Weight = 0 })
					I[28] = new("Pose", I[27], "UpperTorso", { Weight = 0 })
						I[29] = new("Pose", I[28], "LeftUpperArm", { CFrame = CFrame.new(-0.0750122, -0.3264923, -1.3458862, 0.7495673, -0.6557523, 0.0902203, 0.6290527, 0.663268, -0.4054256, 0.2060186, 0.3606473, 0.909665) })
						I[30] = new("Pose", I[28], "RightUpperArm", { CFrame = CFrame.new(-0.355957, 0.305336, -1.3828125, 0.9757282, -0.2091877, 0.0647833, 0.202041, 0.974034, 0.1021707, -0.084474, -0.086601, 0.9926555) })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { Weight = 0 })
				I[33] = new("Pose", I[32], "LowerTorso", { Weight = 0 })
					I[34] = new("Pose", I[33], "UpperTorso", { Weight = 0 })
						I[35] = new("Pose", I[34], "LeftUpperArm", { CFrame = CFrame.new(-0.1098633, -0.258812, -1.4634094, 0.7495678, -0.6557518, 0.0902199, 0.6290522, 0.6632687, -0.4054252, 0.2060182, 0.3606468, 0.9096653) })
						I[36] = new("Pose", I[34], "RightUpperArm", { CFrame = CFrame.new(-0.3908081, 0.3730164, -1.5003052, 0.9757289, -0.2091842, 0.0647824, 0.2020378, 0.9740348, 0.1021688, -0.0844724, -0.0865997, 0.9926557) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 0.5166667 })
			I[38] = new("Pose", I[37], "HumanoidRootPart", { Weight = 0 })
				I[39] = new("Pose", I[38], "LowerTorso", { Weight = 0 })
					I[40] = new("Pose", I[39], "UpperTorso", { Weight = 0 })
						I[41] = new("Pose", I[40], "LeftUpperArm", { CFrame = CFrame.new(-0.0426636, -0.3893204, -1.2368164, 0.7495683, -0.6557513, 0.0902196, 0.6290516, 0.6632695, -0.4054247, 0.2060179, 0.3606464, 0.9096655) })
						I[42] = new("Pose", I[40], "RightUpperArm", { CFrame = CFrame.new(-0.3236084, 0.2425156, -1.2736816, 0.9757298, -0.2091808, 0.0647814, 0.2020346, 0.9740357, 0.102167, -0.0844708, -0.0865984, 0.992656) })
		I[43] = new("Keyframe", I[1], "Keyframe", { Time = 0.5333334 })
			I[44] = new("Pose", I[43], "HumanoidRootPart", { Weight = 0 })
				I[45] = new("Pose", I[44], "LowerTorso", { Weight = 0 })
					I[46] = new("Pose", I[45], "UpperTorso", { Weight = 0 })
						I[47] = new("Pose", I[46], "LeftUpperArm", { CFrame = CFrame.new(-0.1098633, -0.258812, -1.4634094, 0.7495678, -0.6557518, 0.0902199, 0.6290522, 0.6632687, -0.4054252, 0.2060182, 0.3606468, 0.9096653) })
						I[48] = new("Pose", I[46], "RightUpperArm", { CFrame = CFrame.new(-0.3908081, 0.3730164, -1.5003052, 0.9757289, -0.2091842, 0.0647824, 0.2020378, 0.9740348, 0.1021688, -0.0844724, -0.0865997, 0.9926557) })
		I[49] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[50] = new("Pose", I[49], "HumanoidRootPart", { Weight = 0 })
				I[51] = new("Pose", I[50], "LowerTorso", { Weight = 0 })
					I[52] = new("Pose", I[51], "UpperTorso", { Weight = 0 })
						I[53] = new("Pose", I[52], "LeftUpperArm", { CFrame = CFrame.new(-0.0426636, -0.3893204, -1.2368164, 0.7495683, -0.6557513, 0.0902196, 0.6290516, 0.6632695, -0.4054247, 0.2060179, 0.3606464, 0.9096655) })
						I[54] = new("Pose", I[52], "RightUpperArm", { CFrame = CFrame.new(-0.3236084, 0.2425156, -1.2736816, 0.9757298, -0.2091808, 0.0647814, 0.2020346, 0.9740357, 0.102167, -0.0844708, -0.0865984, 0.992656) })
		I[55] = new("Keyframe", I[1], "Keyframe", { Time = 0.5666667 })
			I[56] = new("Pose", I[55], "HumanoidRootPart", { Weight = 0 })
				I[57] = new("Pose", I[56], "LowerTorso", { Weight = 0 })
					I[58] = new("Pose", I[57], "UpperTorso", { Weight = 0 })
						I[59] = new("Pose", I[58], "LeftUpperArm", { CFrame = CFrame.new(-0.0675659, -0.3409882, -1.3207397, 0.7495687, -0.6557507, 0.0902192, 0.6290511, 0.6632701, -0.4054242, 0.2060175, 0.360646, 0.9096657) })
						I[60] = new("Pose", I[58], "RightUpperArm", { CFrame = CFrame.new(-0.3484802, 0.2908554, -1.357605, 0.9757307, -0.2091773, 0.0647805, 0.2020314, 0.9740364, 0.1021652, -0.0844693, -0.0865971, 0.9926562) })
		I[61] = new("Keyframe", I[1], "Keyframe", { Time = 0.5833333 })
			I[62] = new("Pose", I[61], "HumanoidRootPart", { Weight = 0 })
				I[63] = new("Pose", I[62], "LowerTorso", { Weight = 0 })
					I[64] = new("Pose", I[63], "UpperTorso", { Weight = 0 })
						I[65] = new("Pose", I[64], "LeftUpperArm", { CFrame = CFrame.new(0.0245361, -0.5198364, -1.0101929, 0.7495692, -0.6557502, 0.0902188, 0.6290508, 0.6632708, -0.4054238, 0.2060172, 0.3606456, 0.9096659) })
						I[66] = new("Pose", I[64], "RightUpperArm", { CFrame = CFrame.new(-0.2564087, 0.1120148, -1.0470581, 0.9757314, -0.2091739, 0.0647796, 0.2020282, 0.9740374, 0.1021633, -0.0844677, -0.0865957, 0.9926565) })
		I[67] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[68] = new("Pose", I[67], "HumanoidRootPart", { Weight = 0 })
				I[69] = new("Pose", I[68], "LowerTorso", { Weight = 0 })
					I[70] = new("Pose", I[69], "UpperTorso", { Weight = 0 })
						I[71] = new("Pose", I[70], "LeftUpperArm", { CFrame = CFrame.new(0.0245361, -0.5198517, -1.0101929, 0.8259107, -0.5637961, 0.002719, 0.3317582, 0.4820851, -0.8108832, 0.4558616, 0.6706189, 0.585202) })
						I[72] = new("Pose", I[70], "RightUpperArm", { CFrame = CFrame.new(-0.1828308, -0.201683, -0.8076782, 0.9968121, -0.0634813, 0.0483494, 0.0778258, 0.9072537, -0.4133219, -0.017627, 0.4157673, 0.9093007) })
		I[73] = new("Keyframe", I[1], "Keyframe", { Time = 0.7833334 })
			I[74] = new("Pose", I[73], "HumanoidRootPart", { Weight = 0 })
				I[75] = new("Pose", I[74], "LowerTorso", { Weight = 0 })
					I[76] = new("Pose", I[75], "UpperTorso", { CFrame = CFrame.new(0, -0.0000229, 0, 0.965167, 0.0067808, -0.2615505, 0.087274, 0.9340667, 0.3462722, 0.2466533, -0.3570366, 0.9009368) })
						I[77] = new("Pose", I[76], "LeftUpperArm", { CFrame = CFrame.new(0.0612183, -0.0673599, -0.8763733, 0.9639106, -0.2607698, -0.0536405, 0.1884456, 0.8106169, -0.5544279, 0.1880594, 0.5243103, 0.8305014) })
							I[78] = new("Pose", I[77], "LeftLowerArm", { CFrame = CFrame.new(0.0140076, -0.4094048, 0.068161, 0.734392, -0.6426717, 0.2182733, 0.6066108, 0.7657511, 0.2136596, -0.3044561, -0.0245029, 0.9522113) })
						I[79] = new("Pose", I[76], "RightUpperArm", { CFrame = CFrame.new(-0.1255798, -0.2613144, -1.0508118, 0.9543552, 0.2525828, 0.159405, -0.2370133, 0.9652121, -0.1104171, -0.1817493, 0.0675965, 0.981019) })
							I[80] = new("Pose", I[79], "RightLowerArm", { CFrame = CFrame.new(-0.0923462, -0.1524506, -0.4037476, 0.6289888, 0.7732193, 0.0806673, -0.7184445, 0.617781, -0.3196649, -0.2970057, 0.1431105, 0.9440906) })
		I[81] = new("Keyframe", I[1], "Keyframe", { Time = 0.9166667 })
			I[82] = new("Pose", I[81], "HumanoidRootPart", { Weight = 0 })
				I[83] = new("Pose", I[82], "LowerTorso", { Weight = 0 })
					I[84] = new("Pose", I[83], "UpperTorso")
						I[85] = new("Pose", I[84], "LeftUpperArm", { CFrame = CFrame.new(0.1599884, -0.1088638, -0.4367065, 0.9075896, -0.4181514, -0.0378458, 0.0666834, 0.2325539, -0.9702958, 0.4145312, 0.8781051, 0.2389469) })
							I[86] = new("Pose", I[85], "LeftLowerArm", { CFrame = CFrame.new(0.1083374, -0.1437683, 0, 0.7986388, -0.6018121, 0, 0.6018114, 0.7986385, -0.0000003, -0.0000002, -0.0000001, 1.0000011) })
						I[87] = new("Pose", I[84], "RightUpperArm", { CFrame = CFrame.new(-0.010025, -0.034111, -0.4065552, 0.990269, 0.1017845, 0.0949163, -0.0000001, 0.6820019, -0.7313516, -0.1391731, 0.7242334, 0.6753641) })
							I[88] = new("Pose", I[87], "RightLowerArm", { CFrame = CFrame.new(-0.14888, -0.1186523, -0.1107483, 0.6077385, 0.7941258, 0.0044748, -0.6395416, 0.4927616, -0.5900622, -0.4707876, 0.3557412, 0.8073464) })
								I[89] = new("Pose", I[88], "RightHand", { CFrame = CFrame.new(-0.0541229, -0.0957031, -0.0023041, 1.0000002, 0.0000004, 0.0000001, 0.0000004, 1.0000008, 0, 0.0000001, 0, 1.0000008) })
		I[90] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
