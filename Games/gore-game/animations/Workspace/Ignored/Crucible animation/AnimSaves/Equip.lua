-- Generated from animations/Workspace/Ignored/Crucible animation/AnimSaves/Equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Equip", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.3037249, -0.1331213, -0.2216445, 0.9682317, -0.017524, -0.24944, 0.0423446, 0.9946249, 0.0944898, 0.2464434, -0.1020505, 0.9637694) })
						I[6] = new("Pose", I[5], "Handle", { Weight = 0 })
							I[7] = new("Pose", I[6], "Blade", { CFrame = CFrame.new(404.9552307, 14.1824188, -567.9248657, 0.9997024, 0.0203297, 0.0134832, -0.0202384, 0.9997716, -0.00687, -0.0136198, 0.0065951, 0.9998855), EasingStyle = Enum.PoseEasingStyle.Constant })
							I[8] = new("Pose", I[6], "Outer", { CFrame = CFrame.new(404.9549866, 14.1820002, -567.9249878, 0.9997024, 0.0203297, 0.0134832, -0.0202384, 0.9997716, -0.00687, -0.0136198, 0.0065951, 0.9998855), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0414067, -0.0213102, -0.1874526, 0.8604566, 0.3706856, -0.3495805, -0.4792155, 0.8218564, -0.3080659, 0.1731094, 0.4326017, 0.8848101) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.2102894, -0.0223001, 0.2271275, -0.364946, -0.8431296, 0.394901, 0.9209819, -0.3890687, 0.0204438, 0.1364068, 0.3711576, 0.9184961) })
						I[14] = new("Pose", I[13], "Handle", { Weight = 0 })
							I[15] = new("Pose", I[14], "Blade", { CFrame = CFrame.new(404.9552307, 14.1824188, -567.9248657, 0.9997024, 0.0203297, 0.0134832, -0.0202384, 0.9997716, -0.00687, -0.0136198, 0.0065951, 0.9998855), EasingStyle = Enum.PoseEasingStyle.Constant })
							I[16] = new("Pose", I[14], "Outer", { CFrame = CFrame.new(404.9549866, 14.1820002, -567.9249878, 0.9997024, 0.0203297, 0.0134832, -0.0202384, 0.9997716, -0.00687, -0.0136198, 0.0065951, 0.9998855), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.7404286, -0.0361862, -0.909355, -0.5071579, 0.391891, -0.767602, -0.8614191, -0.2022178, 0.465903, 0.0273605, 0.8975131, 0.4401384) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.6666667 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { Weight = 0 })
					I[21] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.0042661, -0.3046323, 0.2606636, 0.0350441, -0.8576466, 0.5130441, 0.9588563, -0.1158584, -0.2591745, 0.2817207, 0.501018, 0.8182997) })
						I[22] = new("Pose", I[21], "Handle", { Weight = 0 })
							I[23] = new("Pose", I[22], "Blade")
							I[24] = new("Pose", I[22], "Outer")
					I[25] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.5193157, -0.4071516, -0.5546213, -0.0884041, 0.3354184, -0.9379121, -0.979406, 0.142318, 0.1432113, 0.1815174, 0.9312572, 0.3159293) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.2491936, -0.148557, -0.1556088, 0.9625754, -0.1542848, -0.222811, 0.1870567, 0.9731295, 0.1342711, 0.196108, -0.1709243, 0.9655706) })
					I[30] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.1089398, -0.0396983, -0.299795, 0.7965968, 0.428836, -0.4260673, -0.5692951, 0.7692289, -0.2901551, 0.2033143, 0.4736946, 0.8568995) })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { Weight = 0 })
				I[33] = new("Pose", I[32], "Torso", { Weight = 0 })
					I[34] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(-0.1559562, -0.1669804, -0.0513115, 0.8907938, -0.4161047, -0.1826015, 0.4471354, 0.8742574, 0.1890606, 0.0809718, -0.2500616, 0.9648382) })
					I[35] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(-0.2328411, -0.0730692, -0.5036758, 0.6421679, 0.5200261, -0.5631992, -0.7264723, 0.6473455, -0.2306122, 0.2446602, 0.5572402, 0.793489) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { Weight = 0 })
					I[39] = new("Pose", I[38], "Right Arm", { CFrame = CFrame.new(-0.0546812, -0.1703883, 0.0443265, 0.6906997, -0.710344, -0.135445, 0.7203118, 0.6592672, 0.2156795, -0.0639122, -0.2465324, 0.9670248) })
					I[40] = new("Pose", I[38], "Left Arm", { CFrame = CFrame.new(-0.384643, -0.1132505, -0.7491652, 0.3912249, 0.5873774, -0.7084708, -0.8826033, 0.4575325, -0.1080527, 0.2606807, 0.6675715, 0.6974194) })
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[42] = new("Pose", I[41], "HumanoidRootPart", { Weight = 0 })
				I[43] = new("Pose", I[42], "Torso", { Weight = 0 })
					I[44] = new("Pose", I[43], "Right Arm", { CFrame = CFrame.new(0.034529, -0.1486687, 0.1063162, 0.3864043, -0.9180828, -0.0884055, 0.9040312, 0.3579966, 0.2335939, -0.1828097, -0.170183, 0.968307) })
					I[45] = new("Pose", I[43], "Left Arm", { CFrame = CFrame.new(-0.5358793, -0.1520695, -0.9863325, 0.0887665, 0.5871692, -0.8045824, -0.9695148, 0.2361504, 0.0653754, 0.2283888, 0.7742513, 0.5902315) })
		I[46] = new("Keyframe", I[1], "Keyframe", { Time = 0.3666667 })
			I[47] = new("Pose", I[46], "HumanoidRootPart", { Weight = 0 })
				I[48] = new("Pose", I[47], "Torso", { Weight = 0 })
					I[49] = new("Pose", I[48], "Right Arm", { CFrame = CFrame.new(0.1079483, -0.1111531, 0.1436622, 0.064752, -0.9973049, -0.0344959, 0.9698234, 0.05475, 0.2375816, -0.2350527, -0.0488389, 0.9707549) })
					I[50] = new("Pose", I[48], "Left Arm", { CFrame = CFrame.new(-0.6580828, -0.1813543, -1.1652482, -0.1856622, 0.5258214, -0.8300853, -0.9695755, 0.0391255, 0.2416457, 0.15954, 0.8496947, 0.5025594) })
		I[51] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[52] = new("Pose", I[51], "HumanoidRootPart", { Weight = 0 })
				I[53] = new("Pose", I[52], "Torso", { Weight = 0 })
					I[54] = new("Pose", I[53], "Right Arm", { CFrame = CFrame.new(0.1632597, -0.0696884, 0.1682934, -0.1943117, -0.9796582, 0.0501271, 0.9604351, -0.1796077, 0.2128507, -0.1995177, 0.0895032, 0.9757981) })
					I[55] = new("Pose", I[53], "Left Arm", { CFrame = CFrame.new(-0.7227858, -0.1929323, -1.2359828, -0.3768282, 0.4503213, -0.8094512, -0.9220817, -0.0992296, 0.3740574, 0.0881245, 0.8873355, 0.4526255) })
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[57] = new("Pose", I[56], "HumanoidRootPart", { Weight = 0 })
				I[58] = new("Pose", I[57], "Torso", { Weight = 0 })
					I[59] = new("Pose", I[58], "Right Arm", { CFrame = CFrame.new(0.1981458, -0.0361217, 0.1921389, -0.3485914, -0.9178979, 0.1895978, 0.9343532, -0.3243614, 0.1475593, -0.0739462, 0.2285893, 0.9707105) })
					I[60] = new("Pose", I[58], "Left Arm", { CFrame = CFrame.new(-0.7382236, -0.0827062, -1.1045215, -0.4768902, 0.4044256, -0.7803946, -0.8779535, -0.1766351, 0.4449692, 0.0421119, 0.8973517, 0.4393024) })
		I[61] = new("Keyframe", I[1], "Keyframe", { Time = 0.7333333 })
			I[62] = new("Pose", I[61], "HumanoidRootPart", { Weight = 0 })
				I[63] = new("Pose", I[62], "Torso", { Weight = 0 })
					I[64] = new("Pose", I[63], "Right Arm", { CFrame = CFrame.new(-0.0131747, -0.3288986, 0.2577214, 0.0319468, -0.8582687, 0.5122051, 0.9612514, -0.1140099, -0.2509932, 0.273816, 0.5003763, 0.8213698) })
					I[65] = new("Pose", I[63], "Left Arm", { CFrame = CFrame.new(-0.5216243, -0.4539592, -0.5206251, -0.093567, 0.3212917, -0.9423465, -0.9769168, 0.1529377, 0.1491435, 0.1920388, 0.934549, 0.2995653) })
		I[66] = new("Keyframe", I[1], "Keyframe", { Time = 0.8333333 })
			I[67] = new("Pose", I[66], "HumanoidRootPart", { Weight = 0 })
				I[68] = new("Pose", I[67], "Torso", { Weight = 0 })
					I[69] = new("Pose", I[68], "Right Arm", { CFrame = CFrame.new(-0.0203513, -0.3382284, 0.2500384, 0.0220007, -0.85976, 0.5102242, 0.9671906, -0.1108954, -0.2285707, 0.2530974, 0.4985127, 0.8291121) })
					I[70] = new("Pose", I[68], "Left Arm", { CFrame = CFrame.new(-0.5296276, -0.4743326, -0.5067069, -0.1108977, 0.3104669, -0.9440932, -0.9750063, 0.1500335, 0.1638677, 0.1925211, 0.9386694, 0.2860689) })
		I[71] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[72] = new("Pose", I[71], "HumanoidRootPart", { Weight = 0 })
				I[73] = new("Pose", I[72], "Torso", { Weight = 0 })
					I[74] = new("Pose", I[73], "Right Arm", { CFrame = CFrame.new(-0.0223162, -0.3417962, 0.2393297, 0.004605, -0.8615773, 0.5076056, 0.9745496, -0.1099029, -0.1953832, 0.224125, 0.4955865, 0.8391436) })
					I[75] = new("Pose", I[73], "Left Arm", { CFrame = CFrame.new(-0.5449417, -0.4840744, -0.5086713, -0.1389601, 0.3013447, -0.9433353, -0.9724162, 0.1386837, 0.1875459, 0.1873411, 0.9433759, 0.273761) })
		I[76] = new("Keyframe", I[1], "Keyframe", { Time = 0.9666666 })
			I[77] = new("Pose", I[76], "HumanoidRootPart", { Weight = 0 })
				I[78] = new("Pose", I[77], "Torso", { Weight = 0 })
					I[79] = new("Pose", I[78], "Right Arm", { CFrame = CFrame.new(-0.0237657, -0.3478703, 0.2275589, -0.0225976, -0.8625866, 0.5054045, 0.9809148, -0.1167837, -0.1554593, 0.1931201, 0.4922458, 0.848763) })
					I[80] = new("Pose", I[78], "Left Arm", { CFrame = CFrame.new(-0.5680782, -0.497388, -0.5217209, -0.1767485, 0.2965392, -0.9385225, -0.9672045, 0.1243939, 0.2214539, 0.1824163, 0.9468848, 0.2648275) })
		I[81] = new("Keyframe", I[1], "Keyframe", { Time = 1.0666667 })
			I[82] = new("Pose", I[81], "HumanoidRootPart", { Weight = 0 })
				I[83] = new("Pose", I[82], "Torso", { Weight = 0 })
					I[84] = new("Pose", I[83], "Right Arm", { CFrame = CFrame.new(-0.0252555, -0.3541906, 0.2195698, -0.0481941, -0.8618018, 0.5049504, 0.9836103, -0.1288859, -0.1260915, 0.1737469, 0.4905976, 0.8538888) })
					I[85] = new("Pose", I[83], "Left Arm", { CFrame = CFrame.new(-0.5867073, -0.5098829, -0.5340678, -0.2079809, 0.3006925, -0.9307677, -0.9610275, 0.1143643, 0.2516887, 0.1821277, 0.9468396, 0.2651879) })
		I[86] = new("Keyframe", I[1], "Keyframe", { Time = 1.1333333 })
			I[87] = new("Pose", I[86], "HumanoidRootPart", { Weight = 0 })
				I[88] = new("Pose", I[87], "Torso", { Weight = 0 })
					I[89] = new("Pose", I[88], "Right Arm", { CFrame = CFrame.new(-0.0253975, -0.3547929, 0.2189041, -0.0506085, -0.8616542, 0.5049661, 0.9837619, -0.1301852, -0.1235487, 0.1721954, 0.4905138, 0.8542511) })
						I[90] = new("Pose", I[89], "Handle", { CFrame = CFrame.new(-0.0242004, -0.9167709, -0.2770443, 0.0259299, 0.9996639, -0.0000137, 0.9983777, -0.0258962, 0.0507114, 0.050694, -0.0013286, -0.9987136) })
					I[91] = new("Pose", I[88], "Left Arm", { CFrame = CFrame.new(-0.5883591, -0.5110436, -0.5352144, -0.2108066, 0.3012009, -0.929967, -0.9604025, 0.1134786, 0.2544595, 0.1821748, 0.9467844, 0.265352) })
	return I[1]
end

return build
