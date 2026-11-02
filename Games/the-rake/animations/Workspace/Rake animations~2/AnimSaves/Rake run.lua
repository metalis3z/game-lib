-- Generated from animations/Workspace/Rake animations~2/AnimSaves/Rake run.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Rake run", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8443952, -0.5357207, 0, 0.5357207, 0.8443952), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.000001, 0, 0.9490575, 0.3151026, 0, -0.3151026, 0.9490575, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.7879556, 0.7916814, 0, 0.9997759, 0.0211704, 0, -0.0211704, 0.9997759, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0000003, -0.0000023, 0.0000012, -0.3444175, 0.9384945, -0.0245827, -0.9230525, -0.33374, 0.1912882, 0.1713187, 0.0885741, 0.9812259), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000005, -0.0000013, 0.0000009, -0.3957374, -0.9136206, 0.0932156, 0.8650003, -0.3367213, 0.3720123, -0.3084904, 0.2278506, 0.9235354), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, -0.0000003, 1, 0, 0, 0, 0.8719336, 0.4896241, 0, -0.4896241, 0.8719336), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0.0033833, -0.0668804, 0.1628106, 0.9963334, -0.080396, 0.0292617, 0.0835621, 0.8410299, -0.5344961, 0.0183613, 0.5349814, 0.8446643), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[13] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.0905829, 0.0022178, -0.0043165, -0.3924876, 0.9149349, -0.0940618, -0.9187195, -0.3851329, 0.0873313, 0.0436762, 0.1206928, 0.9917285), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[14] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(-0.0772216, 0.0368035, -0.0428471, -0.4430925, -0.8934602, -0.073468, 0.8959876, -0.4440659, -0.0034062, -0.0295814, -0.0673357, 0.9972917), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[15] = new("Pose", I[12], "Head", { CFrame = CFrame.new(-0.0007971, -0.0005389, -0.0008105, 0.9971858, 0.0685676, 0.030314, -0.073703, 0.8226033, 0.5638188, 0.0137233, -0.5644663, 0.825342), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(0.0041068, -0.0788263, 0.1919223, 0.9934847, -0.1070926, 0.0389785, 0.1113101, 0.8384153, -0.5335444, 0.0244585, 0.534407, 0.8448733), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(0.0493569, 0.0240201, 0, 0.5054711, -0.8628436, 0, 0.8628436, 0.5054711, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(0.2671419, -0.0834075, 0.0000005, 0.3559663, -0.9344987, 0, 0.9344987, 0.3559663, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.2355315, -0.0701422, 0.0109998, -0.4517904, 0.8899995, -0.0615318, -0.8889326, -0.4432731, 0.115359, 0.0753941, 0.1068157, 0.9914162), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[22] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.2462305, -0.1874651, 0.0126148, -0.4364097, -0.8841754, -0.1666746, 0.8954409, -0.4449074, 0.0155813, -0.0879313, -0.1424475, 0.9858888), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[23] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0, -0.0000004, -0.0000005, 0.9936767, 0.1036437, 0.0431824, -0.1107988, 0.8428919, 0.5265517, 0.0181756, -0.5280067, 0.8490458), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0.0026071, -0.06087, 0.1513362, 0.9983697, -0.0497273, 0.0280214, 0.0558739, 0.7510771, -0.657846, 0.0116667, 0.6583391, 0.7526311), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[27] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.045889, -0.0099186, -0.007944, -0.4721673, 0.8573049, -0.2051494, -0.8776169, -0.4790203, 0.0181116, -0.0827435, 0.1885943, 0.9785631), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[28] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(-0.1949901, 0.0036229, -0.0191791, -0.4444999, -0.895532, 0.0210276, 0.8753473, -0.4292567, 0.2224984, -0.1902282, 0.117307, 0.9747063), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[29] = new("Pose", I[26], "Head", { CFrame = CFrame.new(0.0014144, -0.0016078, -0.0026799, 0.9984131, 0.0490318, 0.0276974, -0.055989, 0.8115212, 0.5816344, 0.0060416, -0.5822622, 0.8129787), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[32] = new("Pose", I[31], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660254, -0.4999998, 0, 0.4999998, 0.8660254), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[33] = new("Pose", I[32], "Left Leg", { CFrame = CFrame.new(-0.6752823, 1.0013828, 0, 0.9466665, -0.322215, 0, 0.322215, 0.9466665, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[34] = new("Pose", I[32], "Right Leg", { CFrame = CFrame.new(-0.0030593, -0.0715659, 0, 0.9442181, -0.3293207, 0, 0.3293207, 0.9442181, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[35] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(0.0000002, -0.0000031, 0.0000009, -0.3543538, 0.9280523, 0.1146824, -0.9207641, -0.3676837, 0.1303904, 0.1631759, -0.0593911, 0.9848076), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[36] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(0, 0.0000001, 0.0000004, -0.2802705, -0.9590938, -0.039843, 0.898887, -0.2767882, 0.3396915, -0.3368241, 0.0593912, 0.9396926), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[37] = new("Pose", I[32], "Head", { CFrame = CFrame.new(0, -0.0000001, -0.0000004, 1, 0, 0, 0, 0.8719338, 0.489624, 0, -0.489624, 0.8719338), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { CFrame = CFrame.new(-0.0028692, -0.0614071, 0.1503497, 0.9967197, 0.0761941, -0.0272822, -0.0791351, 0.8469297, -0.5257829, -0.0169555, 0.5262172, 0.8501812), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[41] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(0.0580205, 0.0702138, -0.0063772, -0.2379986, 0.9684802, 0.0735033, -0.958995, -0.2463094, 0.140215, 0.1539, -0.0371183, 0.987389), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[42] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.2123911, -0.0028582, 0.0067182, -0.3604734, -0.9318748, -0.0408456, 0.91388, -0.3616026, 0.1845722, -0.1867681, 0.0292054, 0.9819698), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[43] = new("Pose", I[40], "Head", { CFrame = CFrame.new(0.00093, -0.0006869, -0.0012593, 0.9974894, -0.0654648, -0.0270046, 0.0695536, 0.8339975, 0.5473668, -0.0133115, -0.5478708, 0.836457), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[46] = new("Pose", I[45], "Torso", { CFrame = CFrame.new(-0.0032113, -0.0651763, 0.1586346, 0.9941711, 0.1013111, -0.0368742, -0.1053009, 0.8390455, -0.5337737, -0.0231381, 0.5345453, 0.8448229), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[47] = new("Pose", I[46], "Left Leg", { CFrame = CFrame.new(-0.5288861, -0.2885391, 0, 0.2741292, 0.9616928, 0, -0.9616928, 0.2741292, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[48] = new("Pose", I[46], "Right Leg", { CFrame = CFrame.new(0.2825568, -0.1348733, 0.0000005, 0.5156428, 0.8568036, 0, -0.8568036, 0.5156428, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[49] = new("Pose", I[46], "Left Arm", { CFrame = CFrame.new(0.2075893, -0.1685899, 0.0100224, -0.4274427, 0.9022025, 0.0576491, -0.8935572, -0.4313093, 0.1246116, 0.1372895, 0.0017515, 0.9905294), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[50] = new("Pose", I[46], "Right Arm", { CFrame = CFrame.new(0.3171606, -0.0018577, 0.0121824, -0.3995154, -0.9160098, -0.0362399, 0.9100041, -0.4010544, 0.1051092, -0.1108153, 0.0090143, 0.9938002), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[51] = new("Pose", I[46], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0000012, 0.9943607, -0.0990747, -0.0378286, 0.1046522, 0.8589554, 0.5012419, -0.0171673, -0.5023741, 0.8644798), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[52] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[53] = new("Pose", I[52], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[54] = new("Pose", I[53], "Torso", { CFrame = CFrame.new(-0.0025698, -0.0717448, 0.1744198, 0.9985417, 0.0507295, -0.018464, -0.0527273, 0.8430566, -0.5352339, -0.0115859, 0.535427, 0.844502), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[55] = new("Pose", I[54], "Left Arm", { CFrame = CFrame.new(0.1855435, -0.060544, 0.0060923, -0.4623352, 0.8813407, 0.0973885, -0.8510695, -0.4718938, 0.2302107, 0.2488511, 0.0235502, 0.9682554), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[56] = new("Pose", I[54], "Right Arm", { CFrame = CFrame.new(0.0873811, 0.0127333, 0.0154188, -0.3819699, -0.9236807, -0.0302193, 0.899386, -0.3790482, 0.217778, -0.2126118, 0.0560058, 0.9755304), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[57] = new("Pose", I[54], "Head", { CFrame = CFrame.new(-0.0011678, -0.001193, -0.0020089, 0.998586, -0.046863, -0.0250976, 0.0528092, 0.8202996, 0.5694907, -0.0061004, -0.5700108, 0.8216145), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[58] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[59] = new("Pose", I[58], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[60] = new("Pose", I[59], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8443952, -0.5357207, 0, 0.5357207, 0.8443952), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[61] = new("Pose", I[60], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.000001, 0, 0.9490575, 0.3151028, 0, -0.3151028, 0.9490575, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[62] = new("Pose", I[60], "Right Leg", { CFrame = CFrame.new(0.787956, 0.7916815, 0, 0.9322414, 0.361837, 0, -0.361837, 0.9322414, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[63] = new("Pose", I[60], "Left Arm", { CFrame = CFrame.new(-0.0000004, -0.0000019, 0.0000009, -0.3411086, 0.9379111, 0.0629887, -0.877607, -0.3417534, 0.3361699, 0.3368241, 0.0593911, 0.9396926), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[64] = new("Pose", I[60], "Right Arm", { CFrame = CFrame.new(0, -0.0000003, 0.0000006, -0.4034739, -0.9149846, -0.0034247, 0.7895122, -0.3500323, 0.5041309, -0.4624707, 0.2006998, 0.8636205), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[65] = new("Pose", I[60], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8719335, 0.4896243, 0, -0.4896243, 0.8719335), EasingDirection = Enum.PoseEasingDirection.InOut })
	return I[1]
end

return build
