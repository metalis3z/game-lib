-- Generated from animations/Workspace/MafiaMember/AnimSaves/Imported Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Imported Animation Clip", { Loop = false, Priority = Enum.AnimationPriority.Idle }, nil, { "1597719077" })
		I[2] = new("Keyframe", I[1], "Keyframe", { Time = -0.0333333 })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso")
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm")
							I[7] = new("Pose", I[6], "LeftLowerArm")
								I[8] = new("Pose", I[7], "LeftHand")
						I[9] = new("Pose", I[5], "Head")
						I[10] = new("Pose", I[5], "RightUpperArm")
							I[11] = new("Pose", I[10], "RightLowerArm")
								I[12] = new("Pose", I[11], "RightHand")
					I[13] = new("Pose", I[4], "RightUpperLeg")
						I[14] = new("Pose", I[13], "RightLowerLeg")
							I[15] = new("Pose", I[14], "RightFoot")
					I[16] = new("Pose", I[4], "LeftUpperLeg")
						I[17] = new("Pose", I[16], "LeftLowerLeg")
							I[18] = new("Pose", I[17], "LeftFoot")
		I[19] = new("Keyframe", I[1], "Keyframe")
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { CFrame = CFrame.new(-0.0001254, -0.0358085, 0.0023947, 1, 0.0001522, -0.0000114, -0.0001522, 1, -0.0003462, 0.0000114, 0.0003462, 1) })
					I[22] = new("Pose", I[21], "UpperTorso")
						I[23] = new("Pose", I[22], "LeftUpperArm", { CFrame = CFrame.new(0.0002191, 0.0000762, 0.0000064, 0.2678735, -0.1618413, -0.9497637, 0.1300692, 0.9828405, -0.1307926, 0.9546338, -0.0884991, 0.2843275) })
							I[24] = new("Pose", I[23], "LeftLowerArm", { CFrame = CFrame.new(0.0000316, -0.000101, -0.0000641, 0.9999999, 0.0000001, 0.0000002, 0, 0.8303138, -0.557296, -0.0000002, 0.557296, 0.8303139) })
								I[25] = new("Pose", I[24], "LeftHand", { CFrame = CFrame.new(-0.0000401, -0.0000381, 0.0000303, 0.9992364, -0.0390577, -0.0010017, 0.0385046, 0.9887875, -0.1442791, 0.0066257, 0.1441304, 0.9895366) })
						I[26] = new("Pose", I[22], "Head")
						I[27] = new("Pose", I[22], "RightUpperArm", { CFrame = CFrame.new(0.0000581, 0.0000363, -0.0000004, -0.1944582, -0.9809108, 0, 0.9809108, -0.1944582, 0, 0, 0, 1) })
							I[28] = new("Pose", I[27], "RightLowerArm", { CFrame = CFrame.new(-0.0000376, -0.0000015, -0.0000283, 0.6360728, -0.7074628, -0.3080712, -0.0000007, 0.3992473, -0.9168434, 0.7716292, 0.5831792, 0.2539499) })
								I[29] = new("Pose", I[28], "RightHand")
					I[30] = new("Pose", I[21], "RightUpperLeg", { CFrame = CFrame.new(-0.0000022, 0.0000048, -0.0000009, 0.9999999, -0.0001536, 0.0005138, 0.0001898, 0.9974629, -0.0711894, -0.0005015, 0.0711894, 0.9974628) })
						I[31] = new("Pose", I[30], "RightLowerLeg", { CFrame = CFrame.new(-0.0000002, 0.0000067, 0.000001, 1.0000001, 0, 0, 0, 0.9854873, 0.1697497, 0, -0.1697497, 0.9854873) })
							I[32] = new("Pose", I[31], "RightFoot", { CFrame = CFrame.new(-0.0000013, -0.0000016, 0.0000003, 0.9999999, 0.0000378, -0.0004901, -0.0000861, 0.9951056, -0.0988182, 0.0004839, 0.0988183, 0.9951054) })
					I[33] = new("Pose", I[21], "LeftUpperLeg", { CFrame = CFrame.new(-0.0000007, -0.0000061, -0.0000008, 0.9999999, -0.0002919, -0.0004487, 0.0002593, 0.9974794, -0.0709571, 0.0004683, 0.070957, 0.9974794) })
						I[34] = new("Pose", I[33], "LeftLowerLeg", { CFrame = CFrame.new(-0.0000015, -0.0000111, 0.0000005, 1, -0.0000002, 0, 0.0000002, 0.9855742, 0.1692446, -0.0000001, -0.1692446, 0.9855742) })
							I[35] = new("Pose", I[34], "LeftFoot", { CFrame = CFrame.new(0.0000032, -0.000008, -0.0000003, 0.9999999, 0.0001072, 0.0004797, -0.0000594, 0.9951332, -0.0985402, -0.0004879, 0.0985401, 0.995133) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 1.1666666 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "LowerTorso", { CFrame = CFrame.new(0.3273461, -0.4538062, 0.2402361, 0.9340918, 0.0250739, -0.3561514, 0.00169, 0.9972093, 0.0746383, 0.357029, -0.070321, 0.9314426), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[39] = new("Pose", I[38], "UpperTorso", { CFrame = CFrame.new(0.0000106, -0.0000029, -0.0001094, 0.8921036, -0.0703029, -0.4463281, 0.0243386, 0.9938638, -0.1079004, 0.451175, 0.0853954, 0.8883404) })
						I[40] = new("Pose", I[39], "LeftUpperArm", { CFrame = CFrame.new(0.0004466, 0.0000522, 0.0000234, 0.2678764, -0.4716636, -0.8401046, 0.1300692, 0.881694, -0.4535394, 0.954633, 0.0122207, 0.2975338) })
							I[41] = new("Pose", I[40], "LeftLowerArm", { CFrame = CFrame.new(-0.0000318, -0.0000793, -0.0000654, 1.0000002, 0.0000001, 0, 0, 0.9942266, -0.1073029, 0, 0.1073028, 0.9942266) })
						I[42] = new("Pose", I[39], "RightUpperArm", { CFrame = CFrame.new(0.0002122, -0.0000211, 0.0000627, 0.38351, -0.6274688, 0.677645, 0.551944, -0.43257, -0.7129104, 0.7404577, 0.6474304, 0.1804327), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[43] = new("Pose", I[42], "RightLowerArm", { CFrame = CFrame.new(-0.0001331, 0.0000455, -0.0000564, 0.9568898, -0.2887516, -0.0313636, 0.1805808, 0.6760221, -0.714412, 0.2274897, 0.6779498, 0.6990217) })
								I[44] = new("Pose", I[43], "RightHand", { CFrame = CFrame.new(-0.0000033, 0.0000019, -0.0000006, 0.9882002, 0.1514116, 0.0231281, -0.1504015, 0.9877948, -0.0405065, -0.028979, 0.03655, 0.9989116), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[45] = new("Pose", I[38], "RightUpperLeg", { CFrame = CFrame.new(0.0892922, -0.0074926, -0.0084197, 0.98669, 0.1245034, -0.1046028, -0.1625589, 0.7386903, -0.6541493, -0.0041747, 0.6624467, 0.7490974), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[46] = new("Pose", I[45], "RightLowerLeg", { CFrame = CFrame.new(-0.0000525, -0.0000027, -0.0000648, 0.9876634, 0.0000001, -0.1565917, 0.1419082, 0.4227841, 0.8950508, 0.0662045, -0.9062303, 0.4175683), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[47] = new("Pose", I[46], "RightFoot", { CFrame = CFrame.new(-0.0000019, -0.0000002, 0.0000015, 0.9730042, -0.132517, 0.1889496, 0.1897069, 0.9254971, -0.3278204, -0.1314305, 0.3548157, 0.925652), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[48] = new("Pose", I[38], "LeftUpperLeg", { CFrame = CFrame.new(0.0000006, 0, 0.0000016, 0.9504911, 0.2753722, -0.1440038, -0.3058027, 0.7464809, -0.5909747, -0.0552419, 0.6057528, 0.7937328), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[49] = new("Pose", I[48], "LeftLowerLeg", { CFrame = CFrame.new(-0.0000014, 0, -0.0000073, 1, 0, 0, 0, 0.3509181, 0.9364063, 0, -0.9364061, 0.3509181), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[50] = new("Pose", I[49], "LeftFoot", { CFrame = CFrame.new(-0.000001, -0.0000042, -0.0000009, 0.8732794, -0.3676734, 0.3196863, 0.4822145, 0.7460471, -0.4592197, -0.0696583, 0.5551846, 0.8288053), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[51] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[52] = new("Pose", I[51], "HumanoidRootPart", { Weight = 0 })
				I[53] = new("Pose", I[52], "LowerTorso", { CFrame = CFrame.new(-0.1294984, -0.0568325, 0.033294, 0.9340896, 0.0250726, -0.3561572, 0.0016803, 0.9972115, 0.0746082, 0.3570347, -0.0702892, 0.9314427) })
					I[54] = new("Pose", I[53], "RightUpperLeg", { CFrame = CFrame.new(-0.0000067, -0.0000074, -0.0000283, 0.9734523, -0.1599677, -0.1637094, 0.0008496, 0.7177536, -0.6962966, 0.228888, 0.6776724, 0.6988349) })
						I[55] = new("Pose", I[54], "RightLowerLeg", { CFrame = CFrame.new(-0.0001334, -0.0000622, 0.0000532, 0.9970759, -0.076419, 0.0000002, 0.0661932, 0.8636559, 0.499717, -0.038188, -0.4982556, 0.8661889) })
							I[56] = new("Pose", I[55], "RightFoot", { CFrame = CFrame.new(-0.0000529, 0.0000009, -0.0000562, 0.9995664, -0.0207367, 0.0209056, 0.0181593, 0.9929986, 0.1167206, -0.0231797, -0.1162904, 0.9929451) })
					I[57] = new("Pose", I[53], "UpperTorso", { CFrame = CFrame.new(-0.0000057, -0.0000042, -0.0000033, 0.9999719, 0.0075025, 0.0000001, -0.0074814, 0.9971654, -0.0748683, -0.0005618, 0.0748662, 0.9971934) })
						I[58] = new("Pose", I[57], "RightUpperArm", { Weight = 0 })
							I[59] = new("Pose", I[58], "RightLowerArm", { CFrame = CFrame.new(-0.0000445, -0.0000237, -0.0000249, 0.6360727, -0.6652476, -0.3909689, -0.0000014, 0.5066789, -0.8621348, 0.7716291, 0.5483811, 0.3222836) })
					I[60] = new("Pose", I[53], "LeftUpperLeg", { CFrame = CFrame.new(0.0000034, -0.0000053, -0.0000023, 0.9810892, -0.1752694, 0.0821275, 0.1834919, 0.9772422, -0.1064359, -0.0616035, 0.1194928, 0.9909221) })
						I[61] = new("Pose", I[60], "LeftLowerLeg", { CFrame = CFrame.new(0.0000024, -0.00001, 0.0000006, 1.0000001, -0.0000002, 0, 0.0000002, 0.9854724, 0.1698367, -0.0000001, -0.1698367, 0.9854723) })
							I[62] = new("Pose", I[61], "LeftFoot", { CFrame = CFrame.new(0.0000038, -0.0000088, -0.0000014, 0.9554945, 0.1020998, 0.2767783, -0.0525452, 0.9820994, -0.1808869, -0.2902923, 0.1582931, 0.9437551) })
		I[63] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 })
			I[64] = new("Pose", I[63], "HumanoidRootPart", { Weight = 0 })
				I[65] = new("Pose", I[64], "LowerTorso", { CFrame = CFrame.new(-0.1357383, -0.2842765, 0.0495622, 0.9340885, 0.0250933, -0.3561589, 0.001675, 0.9972083, 0.0746518, 0.3570379, -0.070328, 0.9314386) })
					I[66] = new("Pose", I[65], "RightUpperLeg", { CFrame = CFrame.new(0.0000008, -0.0000002, 0.0000027, 0.9627481, -0.2084065, 0.1722878, 0.2682183, 0.8168149, -0.5107566, -0.0342823, 0.5379406, 0.8422853) })
						I[67] = new("Pose", I[66], "RightLowerLeg", { CFrame = CFrame.new(-0.0000002, -0.0000008, -0.0000014, 1, 0, 0, 0, 0.7234278, 0.6904002, 0, -0.6904001, 0.7234277) })
							I[68] = new("Pose", I[67], "RightFoot", { CFrame = CFrame.new(-0.0000049, 0, -0.0000007, 0.9687474, 0.180223, 0.1704343, -0.1371823, 0.9617226, -0.2372148, -0.2066621, 0.2064207, 0.9563897) })
					I[69] = new("Pose", I[65], "UpperTorso", { CFrame = CFrame.new(-0.0000057, -0.0000042, -0.0000033, 0.9999719, 0.0075025, 0.0000001, -0.0074814, 0.9971654, -0.0748683, -0.0005618, 0.0748662, 0.9971934) })
						I[70] = new("Pose", I[69], "RightUpperArm", { Weight = 0 })
							I[71] = new("Pose", I[70], "RightLowerArm", { CFrame = CFrame.new(-0.0001331, 0.0000455, -0.0000564, 0.9568898, -0.2887516, -0.0313636, 0.1805808, 0.6760221, -0.714412, 0.2274897, 0.6779498, 0.6990217) })
					I[72] = new("Pose", I[65], "LeftUpperLeg", { CFrame = CFrame.new(0.0000042, -0.0000006, 0.0000009, 0.9758824, -0.1836401, 0.1180258, 0.2135461, 0.9152699, -0.3415835, -0.0452971, 0.3585492, 0.9324111) })
						I[73] = new("Pose", I[72], "LeftLowerLeg", { CFrame = CFrame.new(0.0000062, -0.0000003, -0.0000021, 1.0000001, 0, 0, 0, 0.7077491, 0.7064641, 0, -0.7064639, 0.707749) })
							I[74] = new("Pose", I[73], "LeftFoot", { CFrame = CFrame.new(0.0000035, -0.0000007, 0.0000009, 0.9481943, 0.1339569, 0.2880681, 0.0353139, 0.8566936, -0.5146155, -0.3157223, 0.4981283, 0.8075813) })
		I[75] = new("Keyframe", I[1], "Keyframe", { Time = 1.8 })
			I[76] = new("Pose", I[75], "HumanoidRootPart", { Weight = 0 })
				I[77] = new("Pose", I[76], "LowerTorso", { CFrame = CFrame.new(0.3662134, -0.4507933, 0.255367, 0.8949975, 0.1482204, 0.4207259, -0.1874812, 0.980822, 0.0532827, -0.4047596, -0.126566, 0.9056218), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[78] = new("Pose", I[77], "RightUpperLeg", { CFrame = CFrame.new(-0.0000049, -0.0000001, -0.0000035, 0.9974687, -0.0699088, 0.0130043, 0.0658348, 0.8388114, -0.540427, 0.0268725, 0.5399151, 0.8412906), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[79] = new("Pose", I[78], "RightLowerLeg", { CFrame = CFrame.new(-0.0000002, -0.0000004, -0.0000019, 1, 0, 0, 0, 0.2588409, 0.96592, 0, -0.96592, 0.258841), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[80] = new("Pose", I[79], "RightFoot", { CFrame = CFrame.new(0.0000024, 0.0000001, 0.0000024, 0.7531349, -0.0422272, -0.6565096, -0.3860686, 0.7796565, -0.4930384, 0.5326716, 0.6247822, 0.5708839), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[81] = new("Pose", I[77], "UpperTorso", { CFrame = CFrame.new(-0.000054, -0.0000394, -0.000137, 0.9696, -0.1180909, 0.2143137, 0.1355347, 0.9883974, -0.0685619, -0.2037305, 0.0955247, 0.9743556), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[82] = new("Pose", I[81], "RightUpperArm", { CFrame = CFrame.new(0.0001736, -0.0000049, 0.0000491, 0.500995, -0.5792264, 0.6430404, 0.5447896, -0.3662591, -0.7543597, 0.6724643, 0.7282522, 0.1320625) })
					I[83] = new("Pose", I[77], "LeftUpperLeg", { CFrame = CFrame.new(0.0000003, -0.0000005, -0.0000033, 0.9973968, -0.0720985, 0.0013097, 0.0435297, 0.587502, -0.8080511, 0.0574898, 0.8060045, 0.589111), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[84] = new("Pose", I[83], "LeftLowerLeg", { CFrame = CFrame.new(0.0000024, 0.0000042, 0.0000011, 1.0000001, 0, 0, 0, 0.6783057, 0.7347799, 0, -0.7347799, 0.6783057), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[85] = new("Pose", I[84], "LeftFoot", { CFrame = CFrame.new(0.000002, -0.0000001, -0.0000024, 0.9167214, -0.2004366, -0.3456116, 0.2153641, 0.9765216, 0.0049137, 0.3365123, -0.0789369, 0.9383649), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[86] = new("Keyframe", I[1], "Keyframe", { Time = 2.4000001 })
			I[87] = new("Pose", I[86], "HumanoidRootPart", { Weight = 0 })
				I[88] = new("Pose", I[87], "LowerTorso", { CFrame = CFrame.new(0.2694824, -0.4373321, 0.2464004, 0.8240187, 0.1482195, -0.546831, -0.051719, 0.980822, 0.1879183, 0.564197, -0.1265666, 0.8158816) })
					I[89] = new("Pose", I[88], "UpperTorso", { CFrame = CFrame.new(-0.0000363, -0.0000787, -0.0002694, 0.9502219, -0.2417695, -0.1965348, 0.2219615, 0.9679416, -0.1175672, 0.2186583, 0.0680918, 0.9734228) })
						I[90] = new("Pose", I[89], "Head", { CFrame = CFrame.new(-0.0000142, -0.0000013, -0.0000153, 0.994121, 0.1082753, -0.0000002, -0.1082753, 0.9941209, 0.0000001, 0, 0, 0.9999999) })
						I[91] = new("Pose", I[89], "RightUpperArm", { CFrame = CFrame.new(0.0001411, -0.0000115, -0.0000157, 0.463607, -0.6513165, 0.6007128, 0.5255433, -0.3437025, -0.7782501, 0.7133535, 0.6765024, 0.1829522) })
							I[92] = new("Pose", I[91], "RightLowerArm", { CFrame = CFrame.new(-0.0001322, 0.0000636, -0.0000589, 0.9079201, -0.4153056, -0.0565905, 0.2812893, 0.7038257, -0.6523082, 0.310737, 0.5763253, 0.7558385) })
					I[93] = new("Pose", I[88], "RightUpperLeg", { CFrame = CFrame.new(-0.0000006, 0.0000011, -0.0000024, 0.9945774, 0.0979293, 0.0350082, -0.0297546, 0.5904981, -0.8064902, -0.0996513, 0.8010755, 0.59021) })
						I[94] = new("Pose", I[93], "RightLowerLeg", { CFrame = CFrame.new(-0.000004, 0.000001, -0.0000011, 1.0000001, 0, 0, 0, 0.4287211, 0.9034369, 0, -0.903437, 0.428721) })
							I[95] = new("Pose", I[94], "RightFoot", { CFrame = CFrame.new(-0.0000024, 0.0000004, -0.0000041, 0.9726598, -0.1443074, 0.1819568, 0.1808791, 0.9621519, -0.2038302, -0.1456558, 0.2311697, 0.9619486) })
					I[96] = new("Pose", I[88], "LeftUpperLeg", { CFrame = CFrame.new(0.0000034, 0.0000015, 0.0000007, 0.9759477, 0.2141573, -0.0407768, -0.1976069, 0.7900206, -0.5803611, -0.092074, 0.5744599, 0.8133379) })
						I[97] = new("Pose", I[96], "LeftLowerLeg", { CFrame = CFrame.new(0.0000005, -0.0000001, -0.0000051, 1.0000002, 0, 0, 0, 0.4030948, 0.9151584, 0, -0.9151584, 0.4030948) })
							I[98] = new("Pose", I[97], "LeftFoot", { CFrame = CFrame.new(-0.000001, -0.0000014, 0.0000008, 0.7992908, -0.3178061, 0.510033, 0.5615237, 0.6973026, -0.4454884, -0.2140684, 0.6424704, 0.7358034) })
	return I[1]
end

return build
