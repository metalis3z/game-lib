-- Generated from animations/ServerStorage/RBX_ANIMSAVES/TemplateR6/Run.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Run", nil, { ["ViralWorkerRef"] = "vw_67f22f49fd" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_2d658fb0f3" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_393fbbdaa4" })
				I[4] = new("IntValue", I[3], "Null", nil, { ["ViralWorkerRef"] = "vw_780014d2c9" })
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9634047, -0.2680513, 0, 0.2680513, 0.9634047) }, { ["ViralWorkerRef"] = "vw_62a720243a" })
					I[6] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.2287438, 0.0348907, 0, 0.9233143, 0.3840453, 0, -0.3840453, 0.9233143, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_a6aaadac05" })
					I[7] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0.0755502, -0.3737117, -0.0000002, 0.0601215, -0.9936478, -0.0951306, 0.9809808, 0.0411949, 0.1896844, -0.1845605, -0.1047253, 0.9772257) }, { ["ViralWorkerRef"] = "vw_7518d25cf9" })
					I[8] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.0000001, 0.0000001, 0, 0.6744267, 0.7383418, 0, -0.7383418, 0.6744267, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_99bbdc6b46" })
					I[9] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.7014422, -0.6757728, 0.226517, 0.643073, 0.73711, 0.2076678, -0.3073042, 0, 0.9516113) }, { ["ViralWorkerRef"] = "vw_e7187aa9bf" })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 }, { ["ViralWorkerRef"] = "vw_f537f0eee0" })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_33a5f1b1d5" })
				I[12] = new("IntValue", I[11], "Null", nil, { ["ViralWorkerRef"] = "vw_48ce6d1458" })
				I[13] = new("Pose", I[11], "Torso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_c7f9231c9c" })
					I[14] = new("IntValue", I[13], "Null", nil, { ["ViralWorkerRef"] = "vw_b8ed9b72c0" })
					I[15] = new("Pose", I[13], "Left Leg", { CFrame = CFrame.new(-0.08381, -0.0097594, 0, 0.6502372, 0.7597314, 0, -0.7597314, 0.6502372, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_2b0806cb32" })
					I[16] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.07555, -0.3737116, -0.0000001, -0.3482261, -0.9325713, -0.0951306, 0.9133142, -0.360385, 0.1896844, -0.2111778, -0.0208311, 0.9772257) }, { ["ViralWorkerRef"] = "vw_9570a295d5" })
					I[17] = new("Pose", I[13], "Right Leg", { CFrame = CFrame.new(0.4937404, 0.1521068, 0, 0.5819644, 0.8132144, 0, -0.8132144, 0.5819644, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_9b83279eec" })
					I[18] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-0.1530979, -0.3688695, -0.0000001, 0.323589, -0.918684, 0.226517, 0.9054679, 0.3701379, 0.2076678, -0.2746236, 0.1379049, 0.9516113) }, { ["ViralWorkerRef"] = "vw_287c5c423b" })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.2166667 }, { ["ViralWorkerRef"] = "vw_90ca9616ec" })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_bbce1fc12b" })
				I[21] = new("IntValue", I[20], "Null", nil, { ["ViralWorkerRef"] = "vw_e5b607c3a1" })
				I[22] = new("Pose", I[20], "Torso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_6595a7bf47" })
					I[23] = new("IntValue", I[22], "Null", nil, { ["ViralWorkerRef"] = "vw_74bafda745" })
					I[24] = new("Pose", I[22], "Left Leg", { CFrame = CFrame.new(-0.207538, -0.1276112, 0, 0.4260042, -0.9047216, 0, 0.9047216, 0.4260042, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_fb8a682c6d" })
					I[25] = new("Pose", I[22], "Right Leg", { CFrame = CFrame.new(0.7678894, 0.2365633, 0, 0.9962369, 0.0866758, 0, -0.0866758, 0.9962369, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_5e09e00cb8" })
					I[26] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-0.1530981, -0.3688698, 0, 0.8131783, 0.5361266, 0.226517, -0.5780985, 0.7890987, 0.2076679, -0.067408, -0.2998201, 0.9516113) }, { ["ViralWorkerRef"] = "vw_bec332dba1" })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.3166667 }, { ["ViralWorkerRef"] = "vw_859d44b10f" })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_fcb1ff28fe" })
				I[29] = new("IntValue", I[28], "Null", nil, { ["ViralWorkerRef"] = "vw_3e84edf398" })
				I[30] = new("Pose", I[28], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9377601, -0.3472839, 0, 0.3472839, 0.9377601) }, { ["ViralWorkerRef"] = "vw_ec7fdf1e4b" })
					I[31] = new("Pose", I[30], "Left Leg", { CFrame = CFrame.new(-0.0383029, -0.2284712, 0, 0.5350932, -0.8447934, 0, 0.8447934, 0.5350932, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_fee2aefdc1" })
					I[32] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(0.0755498, -0.3737119, -0.0000001, 0.6597403, 0.7454484, -0.0951306, -0.7231104, 0.6641774, 0.1896844, 0.2045834, -0.0563525, 0.9772256) }, { ["ViralWorkerRef"] = "vw_0e58a117b2" })
					I[33] = new("Pose", I[30], "Right Leg", { CFrame = CFrame.new(0.7678897, 0.2365635, 0, 0.9366177, -0.3503539, 0, 0.3503539, 0.9366177, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_99112e2743" })
					I[34] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.153098, -0.3688694, -0.0000001, -0.3432815, 0.9115086, 0.226517, -0.897294, -0.3895353, 0.2076678, 0.2775274, -0.1319638, 0.9516113) }, { ["ViralWorkerRef"] = "vw_724f458c82" })
		I[35] = new("Keyframe", I[1], "Keyframe", { Time = 0.4166667 }, { ["ViralWorkerRef"] = "vw_45ea8b9d13" })
			I[36] = new("Pose", I[35], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_af098fe9e6" })
				I[37] = new("IntValue", I[36], "Null", nil, { ["ViralWorkerRef"] = "vw_751ad24e76" })
				I[38] = new("Pose", I[36], "Torso", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_1f740c6e2f" })
					I[39] = new("IntValue", I[38], "Null", nil, { ["ViralWorkerRef"] = "vw_111fde40c9" })
					I[40] = new("Pose", I[38], "Left Leg", { CFrame = CFrame.new(-0.4937404, 0.1521068, 0, 0.5819644, -0.8132144, 0, 0.8132144, 0.5819644, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_0bc8512707" })
					I[41] = new("Pose", I[38], "Right Arm", { CFrame = CFrame.new(0.1530979, -0.3688695, -0.0000001, 0.323589, 0.918684, -0.226517, -0.9054679, 0.3701379, 0.2076678, 0.2746236, 0.1379049, 0.9516113) }, { ["ViralWorkerRef"] = "vw_5b4cc6d188" })
					I[42] = new("Pose", I[38], "Right Leg", { CFrame = CFrame.new(0.08381, -0.0097594, 0, 0.6502372, -0.7597314, 0, 0.7597314, 0.6502372, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_008e4aad4c" })
					I[43] = new("Pose", I[38], "Left Arm", { CFrame = CFrame.new(-0.07555, -0.3737116, -0.0000001, -0.3482261, 0.9325713, 0.0951306, -0.9133142, -0.360385, 0.1896844, 0.2111778, -0.0208311, 0.9772257) }, { ["ViralWorkerRef"] = "vw_1d445d61f3" })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.5166667 }, { ["ViralWorkerRef"] = "vw_458c0ec5bd" })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_3b88e13154" })
				I[46] = new("IntValue", I[45], "Null", nil, { ["ViralWorkerRef"] = "vw_29bd59547f" })
				I[47] = new("Pose", I[45], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8382093, -0.5453488, 0, 0.5453488, 0.8382093) }, { ["ViralWorkerRef"] = "vw_2e02feda5d" })
					I[48] = new("Pose", I[47], "Left Leg", { CFrame = CFrame.new(-0.7678894, 0.2365633, 0, 0.9921613, 0.1249655, 0, -0.1249655, 0.9921613, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_f897b443bf" })
					I[49] = new("Pose", I[47], "Right Arm", { CFrame = CFrame.new(0.1530981, -0.3688698, 0, 0.8131783, -0.5361266, -0.226517, 0.5780985, 0.7890987, 0.2076679, 0.067408, -0.2998201, 0.9516113) }, { ["ViralWorkerRef"] = "vw_759fa5a039" })
					I[50] = new("Pose", I[47], "Right Leg", { CFrame = CFrame.new(0.0383028, -0.2284711, 0, 0.4260041, 0.9047216, 0, -0.9047216, 0.4260041, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_dcca6eb717" })
		I[51] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 }, { ["ViralWorkerRef"] = "vw_7a8530982d" })
			I[52] = new("Pose", I[51], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_fac5beb8f2" })
				I[53] = new("IntValue", I[52], "Null", nil, { ["ViralWorkerRef"] = "vw_c0ea33657c" })
				I[54] = new("Pose", I[52], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9634047, -0.2680513, 0, 0.2680513, 0.9634047) }, { ["ViralWorkerRef"] = "vw_e95c6852fc" })
					I[55] = new("Pose", I[54], "Left Leg", { CFrame = CFrame.new(-0.2287438, 0.0348907, 0, 0.9233143, 0.3840453, 0, -0.3840453, 0.9233143, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_d831a79288" })
					I[56] = new("Pose", I[54], "Right Arm", { CFrame = CFrame.new(0.0755502, -0.3737117, -0.0000002, 0.0601215, -0.9936478, -0.0951306, 0.9809808, 0.0411949, 0.1896844, -0.1845605, -0.1047253, 0.9772257) }, { ["ViralWorkerRef"] = "vw_f541967f95" })
					I[57] = new("Pose", I[54], "Right Leg", { CFrame = CFrame.new(0.0000001, 0.0000001, 0, 0.6744267, 0.7383418, 0, -0.7383418, 0.6744267, 0, 0, 0, 1) }, { ["ViralWorkerRef"] = "vw_789db33cbe" })
					I[58] = new("Pose", I[54], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.7014422, -0.6757728, 0.226517, 0.643073, 0.73711, 0.2076678, -0.3073042, 0, 0.9516113) }, { ["ViralWorkerRef"] = "vw_0a4f05b3af" })
		I[59] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 }, { ["ViralWorkerRef"] = "vw_2c68c57756" })
			I[60] = new("Pose", I[59], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_b5310cd8b0" })
				I[61] = new("IntValue", I[60], "Null", nil, { ["ViralWorkerRef"] = "vw_361b6abeec" })
				I[62] = new("Pose", I[60], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9556774, -0.2944158, 0, 0.2944158, 0.9556774) }, { ["ViralWorkerRef"] = "vw_2765fb837f" })
		I[63] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 }, { ["ViralWorkerRef"] = "vw_bef5fc4cf7" })
			I[64] = new("Pose", I[63], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_0da1712365" })
				I[65] = new("IntValue", I[64], "Null", nil, { ["ViralWorkerRef"] = "vw_b18e216a90" })
				I[66] = new("Pose", I[64], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8430226, -0.5378782, 0, 0.5378782, 0.8430226) }, { ["ViralWorkerRef"] = "vw_88f6027739" })
		I[67] = new("Keyframe", I[1], "Keyframe", { Time = 0.3833333 }, { ["ViralWorkerRef"] = "vw_89f1fcbb6c" })
			I[68] = new("Pose", I[67], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_a980a7c098" })
				I[69] = new("IntValue", I[68], "Null", nil, { ["ViralWorkerRef"] = "vw_94662c80a7" })
				I[70] = new("Pose", I[68], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9125615, -0.4089395, 0, 0.4089395, 0.9125615) }, { ["ViralWorkerRef"] = "vw_c1dbd0a005" })
	return I[1]
end

return build
