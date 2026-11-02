-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~27/Walk  Rhino.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk  Rhino", { Priority = Enum.AnimationPriority.Core }, nil, { "1786673817" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961947, 0.0871557, 0, -0.0871557, 0.9961947) })
					I[5] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0.0000268, 0, 0, 0.9866439, -0.1609546, 0.025049, 0.1609568, 0.9396926, -0.3017791, 0.0250344, 0.3017804, 0.9530487) })
						I[6] = new("Pose", I[5], "Bone.008", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.009")
					I[8] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9866439, 0.1609569, 0.0250343, -0.1609546, 0.9396926, 0.3017804, 0.025049, -0.3017792, 0.9530487) })
						I[9] = new("Pose", I[8], "Bone.011", { Weight = 0 })
							I[10] = new("Pose", I[9], "Bone.012")
					I[11] = new("Pose", I[4], "Bone.013", { CFrame = CFrame.new(-0.0000535, 0.0000134, 0.0001071, 0.6863825, 0.5623685, -0.4611081, -0.71089, 0.6525345, -0.2623626, 0.1533445, 0.5078782, 0.8476704) })
						I[12] = new("Pose", I[11], "Bone.014", { CFrame = CFrame.new(-0.0000268, 0, 0.0000535, 0.984624, -0.089229, -0.1501794, 0.0585312, 0.9785253, -0.1976413, 0.1645896, 0.1858121, 0.9687021) })
					I[13] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848076, 0.1736482, 0, -0.1736482, 0.9848076) })
					I[14] = new("Pose", I[4], "Bone.015", { CFrame = CFrame.new(0.0000402, 0.0000134, -0.0001071, 0.5870683, 0.6729916, -0.4499258, -0.8095325, 0.4900086, -0.3233404, 0.0028622, 0.5540524, 0.832477) })
						I[15] = new("Pose", I[14], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 0.9892904, -0.0695542, 0.1283233, 0.0955697, 0.9731704, -0.2092991, -0.1103227, 0.2193214, 0.9693952) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.007", { Weight = 0 })
						I[20] = new("Pose", I[19], "Bone.008", { Weight = 0 })
							I[21] = new("Pose", I[20], "Bone.009", { CFrame = CFrame.new(0, -0.0000535, -0.0000017, 0.9966358, -0.0817155, 0.0063121, 0.0817162, 0.9848078, -0.1532193, 0.0063042, 0.1532197, 0.9881723) })
					I[22] = new("Pose", I[18], "Bone.010", { CFrame = CFrame.new(-0.008138, -0.2625917, 0.015232, 0.99994, -0.0109523, 0.000113, 0.0109523, 0.9997293, -0.0205347, 0.0001119, 0.0205347, 0.9997891) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[24] = new("Pose", I[23], "Mesh", { Weight = 0 })
				I[25] = new("Pose", I[24], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961947, 0.0871557, 0, -0.0871557, 0.9961947) })
					I[26] = new("Pose", I[25], "Bone.007", { CFrame = CFrame.new(0.0000268, 0, 0, 0.9866439, -0.1609546, 0.025049, 0.1609568, 0.9396926, -0.3017791, 0.0250344, 0.3017804, 0.9530487) })
						I[27] = new("Pose", I[26], "Bone.008", { Weight = 0 })
							I[28] = new("Pose", I[27], "Bone.009")
					I[29] = new("Pose", I[25], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9866439, 0.1609569, 0.0250343, -0.1609546, 0.9396926, 0.3017804, 0.025049, -0.3017792, 0.9530487) })
						I[30] = new("Pose", I[29], "Bone.011", { Weight = 0 })
							I[31] = new("Pose", I[30], "Bone.012")
					I[32] = new("Pose", I[25], "Bone.013", { CFrame = CFrame.new(-0.0000535, 0.0000134, 0.0001071, 0.6863825, 0.5623685, -0.4611081, -0.71089, 0.6525345, -0.2623626, 0.1533445, 0.5078782, 0.8476704) })
						I[33] = new("Pose", I[32], "Bone.014", { CFrame = CFrame.new(-0.0000268, 0, 0.0000535, 0.984624, -0.089229, -0.1501794, 0.0585312, 0.9785253, -0.1976413, 0.1645896, 0.1858121, 0.9687021) })
					I[34] = new("Pose", I[25], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848076, 0.1736482, 0, -0.1736482, 0.9848076) })
					I[35] = new("Pose", I[25], "Bone.015", { CFrame = CFrame.new(0.0000402, 0.0000134, -0.0001071, 0.5870683, 0.6729916, -0.4499258, -0.8095325, 0.4900086, -0.3233404, 0.0028622, 0.5540524, 0.832477) })
						I[36] = new("Pose", I[35], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 0.9892904, -0.0695542, 0.1283233, 0.0955697, 0.9731704, -0.2092991, -0.1103227, 0.2193214, 0.9693952) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[38] = new("Pose", I[37], "Mesh", { Weight = 0 })
				I[39] = new("Pose", I[38], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961942, -0.0871603, 0, 0.0871603, 0.9961942) })
					I[40] = new("Pose", I[39], "Bone.007", { CFrame = CFrame.new(0.0000535, -0.0000033, 0, 0.9866383, 0.1609896, 0.025043, -0.1609862, 0.9396601, 0.3018648, 0.0250652, -0.301863, 0.9530218) })
					I[41] = new("Pose", I[39], "Bone.013", { CFrame = CFrame.new(-0.0000803, 0.0000134, 0.0001606, 0.6069546, 0.7729585, 0.1847731, -0.7258191, 0.6338331, -0.267287, -0.323717, 0.0281193, 0.9457359) })
						I[42] = new("Pose", I[41], "Bone.014", { CFrame = CFrame.new(-0.0000268, 0, 0.0000535, 1, 0.0000048, -0.0000016, -0.0000049, 0.9999998, 0.0000117, 0.0000016, -0.0000116, 0.9999999) })
					I[43] = new("Pose", I[39], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.996194, -0.0871623, 0, 0.0871623, 0.996194) })
					I[44] = new("Pose", I[39], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9866431, -0.1609589, 0.0250504, 0.1609613, 0.9396892, -0.3017874, 0.0250357, 0.3017886, 0.9530461) })
					I[45] = new("Pose", I[39], "Bone.015", { CFrame = CFrame.new(0.0000669, 0.0000268, -0.0001606, 0.4713073, 0.8594871, 0.1978669, -0.7984332, 0.511095, -0.3182554, -0.3746652, -0.0079873, 0.9271258) })
						I[46] = new("Pose", I[45], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 1, 0.0000113, 0.0000025, -0.0000112, 1, 0.0000185, -0.0000027, -0.0000184, 1.0000002) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[48] = new("Pose", I[47], "Mesh", { Weight = 0 })
				I[49] = new("Pose", I[48], "Bone", { Weight = 0 })
					I[50] = new("Pose", I[49], "Bone.007", { CFrame = CFrame.new(-0.0066389, -0.2627791, 0.0125818, 0.9999389, -0.0110583, 0.0001144, 0.0110583, 0.9997248, -0.0206913, 0.0001144, 0.0206913, 0.9997858) })
					I[51] = new("Pose", I[49], "Bone.010", { Weight = 0 })
						I[52] = new("Pose", I[51], "Bone.011", { Weight = 0 })
							I[53] = new("Pose", I[52], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 1, 0.0000034, 0, -0.0000035, 0.9999999, 0.0000064, -0.0000001, -0.0000064, 1.0000001) })
		I[54] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
