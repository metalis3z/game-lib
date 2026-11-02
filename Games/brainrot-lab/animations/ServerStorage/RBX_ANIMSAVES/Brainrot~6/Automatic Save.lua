-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~6/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1787249718" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.001", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone.L", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.001.L", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0, 0.1736482, 0, 1, 0, -0.1736482, 0, 0.9848077) })
						I[6] = new("Pose", I[5], "Bone.002.R", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.003.R", { CFrame = CFrame.new(20.0557709, -3.5762784, -2.8495786, 0.9921838, 0.1134661, 0.0519353, -0.1245634, 0.9254717, 0.3577521, -0.0074719, -0.3614249, 0.9323716) })
								I[8] = new("Pose", I[7], "Bone.004.R", { CFrame = CFrame.new(0, -0.0019073, 0, 0.9988132, -0.0479893, -0.008335, 0.0479747, 0.9396927, 0.3386388, -0.0084186, -0.3386367, 0.9408798) })
									I[9] = new("Pose", I[8], "Bone.005.R", { Weight = 0 })
										I[10] = new("Pose", I[9], "Bone.006.R")
						I[11] = new("Pose", I[5], "Bone.002.L", { Weight = 0 })
							I[12] = new("Pose", I[11], "Bone.003.L", { CFrame = CFrame.new(30.7922344, 57.9814873, 4.3563843, 0.992184, 0.1134576, -0.0519422, -0.1245579, 0.9254733, -0.3577498, 0.0074816, 0.3614236, 0.932372) })
								I[13] = new("Pose", I[12], "Bone.004.L")
						I[14] = new("Pose", I[5], "Bone.007.L", { Weight = 0 })
							I[15] = new("Pose", I[14], "Bone.008.L", { CFrame = CFrame.new(29.8833828, 62.0222054, 0.0114441, 0.9848313, 0.1630492, 0.0593471, -0.173514, 0.9254389, 0.3368318, -0.000002, -0.3420201, 0.9396925) })
								I[16] = new("Pose", I[15], "Bone.009.L", { CFrame = CFrame.new(0.0114441, 0.005722, 0.0305176, 1, -0.0001322, -0.0000383, 0.0001374, 0.9397231, 0.3419366, -0.0000092, -0.3419366, 0.9397228) })
						I[17] = new("Pose", I[5], "Bone.007.R", { Weight = 0 })
							I[18] = new("Pose", I[17], "Bone.008.R", { CFrame = CFrame.new(18.3563232, -7.3461528, -0.0038147, 0.9848295, 0.1630554, -0.0593651, -0.1735259, 0.9254379, -0.3368286, 0.000017, 0.3420201, 0.9396926) })
								I[19] = new("Pose", I[18], "Bone.009.R")
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[21] = new("Pose", I[20], "Cube.001", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone.L", { Weight = 0 })
					I[23] = new("Pose", I[22], "Bone.001.L", { Weight = 0 })
						I[24] = new("Pose", I[23], "Bone.002.R", { Weight = 0 })
							I[25] = new("Pose", I[24], "Bone.003.R", { CFrame = CFrame.new(-29.783247, -41.2993393, 4.2152405, 0.999503, -0.0076682, 0.0305804, 0.0084164, 0.9996668, -0.0244118, -0.0303831, 0.0246571, 0.9992344) })
								I[26] = new("Pose", I[25], "Bone.004.R", { CFrame = CFrame.new(0, -0.0014305, 0, 0.9999454, -0.0103376, -0.001572, 0.0103355, 0.999946, -0.0013242, 0.0015855, 0.0013079, 0.9999982) })
						I[27] = new("Pose", I[23], "Bone.007.L", { Weight = 0 })
							I[28] = new("Pose", I[27], "Bone.008.L", { CFrame = CFrame.new(-5.5713649, -41.3501244, 0.0038147, 0.9994705, -0.0111106, 0.0305809, 0.0118176, 0.999665, -0.0230287, -0.0303148, 0.0233779, 0.9992669) })
								I[29] = new("Pose", I[28], "Bone.009.L", { CFrame = CFrame.new(0.0114441, 0.0054836, 0.0343323, 0.9999998, 0.0002338, -0.0000554, -0.0002337, 1, -0.0000986, 0.0000554, 0.0000988, 1) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[31] = new("Pose", I[30], "Cube.001", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone.L", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.001.L", { CFrame = CFrame.new(0, 0, 0, 0.9848017, 0, -0.1736824, 0, 1, 0, 0.1736824, 0, 0.9848017) })
						I[34] = new("Pose", I[33], "Bone.002.R", { Weight = 0 })
							I[35] = new("Pose", I[34], "Bone.003.R", { CFrame = CFrame.new(-74.7432709, 42.8726654, 10.585784, 0.9922035, -0.1132901, 0.0519378, 0.1243994, 0.9255258, -0.3576694, -0.0075492, 0.3613419, 0.9324031) })
								I[36] = new("Pose", I[35], "Bone.004.R", { Weight = 0 })
									I[37] = new("Pose", I[36], "Bone.005.R", { Weight = 0 })
										I[38] = new("Pose", I[37], "Bone.006.R", { CFrame = CFrame.new(0, 0, 0.002861, 1.0000005, 0, 0, 0, 0.9981577, 0.0606759, 0, -0.0606756, 0.9981583) })
						I[39] = new("Pose", I[33], "Bone.002.L", { Weight = 0 })
							I[40] = new("Pose", I[39], "Bone.003.L", { CFrame = CFrame.new(-39.4544601, -10.8547201, -5.588531, 0.992193, -0.113385, -0.0519319, 0.1244857, 0.9255132, 0.3576715, 0.0075091, -0.3613438, 0.9324027) })
								I[41] = new("Pose", I[40], "Bone.004.L", { CFrame = CFrame.new(0.0019073, -0.0019073, 0, 0.9988015, 0.0482213, 0.0084192, -0.0482218, 0.939693, 0.3386038, 0.0084166, -0.3386038, 0.9408916) })
						I[42] = new("Pose", I[33], "Bone.007.R", { Weight = 0 })
							I[43] = new("Pose", I[42], "Bone.008.R", { CFrame = CFrame.new(-74.2778778, 46.9105225, 0.0038147, 0.9848582, -0.1628709, -0.0593904, 0.1733613, 0.9254703, 0.3368242, 0.0001052, -0.3420201, 0.9396925) })
								I[44] = new("Pose", I[43], "Bone.009.R", { CFrame = CFrame.new(0, 0.0019073, 0.0038147, 1.0000001, 0.0000436, -0.00012, 0, 0.9396926, 0.3420201, 0.0001277, -0.34202, 0.9396924) })
						I[45] = new("Pose", I[33], "Bone.007.L", { Weight = 0 })
							I[46] = new("Pose", I[45], "Bone.008.L", { CFrame = CFrame.new(-37.9562378, -14.6217337, 0.0076294, 0.9848434, -0.1629704, 0.0593651, 0.173446, 0.9254528, -0.3368286, -0.0000465, 0.3420201, 0.9396926) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[48] = new("Pose", I[47], "Cube.001", { Weight = 0 })
				I[49] = new("Pose", I[48], "Bone.L", { Weight = 0 })
					I[50] = new("Pose", I[49], "Bone.001.L", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0, 0.1736482, 0, 1, 0, -0.1736482, 0, 0.9848077) })
						I[51] = new("Pose", I[50], "Bone.002.R", { Weight = 0 })
							I[52] = new("Pose", I[51], "Bone.003.R", { CFrame = CFrame.new(20.0557709, -3.5762784, -2.8495786, 0.9921838, 0.1134661, 0.0519353, -0.1245634, 0.9254717, 0.3577521, -0.0074719, -0.3614249, 0.9323716) })
								I[53] = new("Pose", I[52], "Bone.004.R", { CFrame = CFrame.new(0, -0.0019073, 0, 0.9988132, -0.0479893, -0.008335, 0.0479747, 0.9396927, 0.3386388, -0.0084186, -0.3386367, 0.9408798) })
									I[54] = new("Pose", I[53], "Bone.005.R", { Weight = 0 })
										I[55] = new("Pose", I[54], "Bone.006.R")
						I[56] = new("Pose", I[50], "Bone.002.L", { Weight = 0 })
							I[57] = new("Pose", I[56], "Bone.003.L", { CFrame = CFrame.new(30.7922344, 57.9814873, 4.3563843, 0.992184, 0.1134576, -0.0519422, -0.1245579, 0.9254733, -0.3577498, 0.0074816, 0.3614236, 0.932372) })
								I[58] = new("Pose", I[57], "Bone.004.L")
						I[59] = new("Pose", I[50], "Bone.007.L", { Weight = 0 })
							I[60] = new("Pose", I[59], "Bone.008.L", { CFrame = CFrame.new(29.8833828, 62.0222054, 0.0114441, 0.9848313, 0.1630492, 0.0593471, -0.173514, 0.9254389, 0.3368318, -0.000002, -0.3420201, 0.9396925) })
								I[61] = new("Pose", I[60], "Bone.009.L", { CFrame = CFrame.new(0.0114441, 0.005722, 0.0305176, 1, -0.0001322, -0.0000383, 0.0001374, 0.9397231, 0.3419366, -0.0000092, -0.3419366, 0.9397228) })
						I[62] = new("Pose", I[50], "Bone.007.R", { Weight = 0 })
							I[63] = new("Pose", I[62], "Bone.008.R", { CFrame = CFrame.new(18.3563232, -7.3461528, -0.0038147, 0.9848295, 0.1630554, -0.0593651, -0.1735259, 0.9254379, -0.3368286, 0.000017, 0.3420201, 0.9396926) })
								I[64] = new("Pose", I[63], "Bone.009.R")
		I[65] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[66] = new("Pose", I[65], "Cube.001", { Weight = 0 })
				I[67] = new("Pose", I[66], "Bone.L", { Weight = 0 })
					I[68] = new("Pose", I[67], "Bone.001.L", { Weight = 0 })
						I[69] = new("Pose", I[68], "Bone.002.L", { Weight = 0 })
							I[70] = new("Pose", I[69], "Bone.003.L", { CFrame = CFrame.new(-2.7103422, -36.6377831, -0.3814697, 0.9995023, 0.007796, -0.0305732, -0.0085467, 0.9996635, -0.0244985, 0.030372, 0.0247477, 0.9992324) })
								I[71] = new("Pose", I[70], "Bone.004.L", { CFrame = CFrame.new(0.0023842, -0.0007153, -0.0038147, 1.0000001, -0.0003126, 0.0000561, 0.0003126, 1, 0.0000337, -0.0000561, -0.0000336, 1.0000002) })
						I[72] = new("Pose", I[68], "Bone.002.R", { Weight = 0 })
							I[73] = new("Pose", I[72], "Bone.003.R", { Weight = 0 })
								I[74] = new("Pose", I[73], "Bone.004.R", { Weight = 0 })
									I[75] = new("Pose", I[74], "Bone.005.R", { Weight = 0 })
										I[76] = new("Pose", I[75], "Bone.006.R", { CFrame = CFrame.new(0.0009537, 0.0038147, 0.0009537, 0.9999999, -0.0000001, 0.0000001, -0.0000001, 0.9848078, -0.1736483, 0, 0.1736482, 0.9848082) })
						I[77] = new("Pose", I[68], "Bone.007.R", { Weight = 0 })
							I[78] = new("Pose", I[77], "Bone.008.R", { Weight = 0 })
								I[79] = new("Pose", I[78], "Bone.009.R", { CFrame = CFrame.new(0.0009537, 0.0016689, 0.0038147, 0.9999443, 0.0104313, 0.0015928, -0.0104315, 0.9999458, 0.0001396, -0.0015912, -0.0001561, 0.9999986) })
		I[80] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
