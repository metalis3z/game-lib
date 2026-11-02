-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~39/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1787409619" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0.0000008, 0, 0, 1, 0.0000241, 0, -0.0000241, 1, 0, 0, 0, 1) })
					I[5] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(0, -0.0000134, -0.0000535, 1, -0.000051, -0.0004293, 0.0000568, 0.9999068, 0.0136607, 0.0004285, -0.0136607, 0.9999068) })
						I[6] = new("Pose", I[5], "Bone.010")
					I[7] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(-0.8826206, 0.5172203, -0.0000535, -0.2048979, 0.7375355, -0.6434734, -0.1739103, 0.6195279, 0.765467, 0.963209, 0.2687491, 0.001325) })
						I[8] = new("Pose", I[7], "Bone.005", { CFrame = CFrame.new(0, 0, 0.0000268, 0.9332076, -0.3343601, -0.1316318, 0.3483142, 0.7516632, 0.5600711, -0.0883226, -0.5685117, 0.8179203) })
					I[9] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(-0.0000067, -0.0000402, -0.0001071, 0.9816235, -0.0272274, -0.188876, 0.0255429, 0.9996096, -0.0113472, 0.1891112, 0.0063142, 0.9819357) })
						I[10] = new("Pose", I[9], "Bone.008")
					I[11] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0.0000033, 0.0000067, 0, 0.9999999, 0, 0, 0, 0.9999999, 0, 0, 0, 1) })
						I[12] = new("Pose", I[11], "Bone.013", { CFrame = CFrame.new(0.0000033, 0, 0, 0.9848077, 0.1736481, 0, -0.1736481, 0.9848077, 0, 0, 0, 1) })
					I[13] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(1.056196, 0.340092, 0, -0.16839, -0.798721, 0.5776585, -0.1942152, 0.6014229, 0.774965, -0.9663979, 0.0183063, -0.2563973) })
						I[14] = new("Pose", I[13], "Bone.002", { CFrame = CFrame.new(0, -0.0000134, 0, 0.9358, 0.3519826, -0.0196658, -0.3047528, 0.8357527, 0.456775, 0.1772124, -0.4214568, 0.8893647) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[16] = new("Pose", I[15], "Mesh", { Weight = 0 })
				I[17] = new("Pose", I[16], "Bone", { CFrame = CFrame.new(0.0000008, 0, 0, 1, 0.0000241, 0, -0.0000241, 1, 0, 0, 0, 1) })
					I[18] = new("Pose", I[17], "Bone.009", { CFrame = CFrame.new(0, -0.0000134, -0.0000535, 1, -0.000051, -0.0004293, 0.0000568, 0.9999068, 0.0136607, 0.0004285, -0.0136607, 0.9999068) })
						I[19] = new("Pose", I[18], "Bone.010")
					I[20] = new("Pose", I[17], "Bone.004", { CFrame = CFrame.new(-0.8826206, 0.5172203, -0.0000535, -0.2048979, 0.7375355, -0.6434734, -0.1739103, 0.6195279, 0.765467, 0.963209, 0.2687491, 0.001325) })
						I[21] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(0, 0, 0.0000268, 0.9332076, -0.3343601, -0.1316318, 0.3483142, 0.7516632, 0.5600711, -0.0883226, -0.5685117, 0.8179203) })
					I[22] = new("Pose", I[17], "Bone.007", { CFrame = CFrame.new(-0.0000067, -0.0000402, -0.0001071, 0.9816235, -0.0272274, -0.188876, 0.0255429, 0.9996096, -0.0113472, 0.1891112, 0.0063142, 0.9819357) })
						I[23] = new("Pose", I[22], "Bone.008")
					I[24] = new("Pose", I[17], "Bone.012", { CFrame = CFrame.new(0.0000033, 0.0000067, 0, 0.9999999, 0, 0, 0, 0.9999999, 0, 0, 0, 1) })
						I[25] = new("Pose", I[24], "Bone.013", { CFrame = CFrame.new(0.0000033, 0, 0, 0.9848077, 0.1736481, 0, -0.1736481, 0.9848077, 0, 0, 0, 1) })
					I[26] = new("Pose", I[17], "Bone.001", { CFrame = CFrame.new(1.056196, 0.340092, 0, -0.16839, -0.798721, 0.5776585, -0.1942152, 0.6014229, 0.774965, -0.9663979, 0.0183063, -0.2563973) })
						I[27] = new("Pose", I[26], "Bone.002", { CFrame = CFrame.new(0, -0.0000134, 0, 0.9358, 0.3519826, -0.0196658, -0.3047528, 0.8357527, 0.456775, 0.1772124, -0.4214568, 0.8893647) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[29] = new("Pose", I[28], "Mesh", { Weight = 0 })
				I[30] = new("Pose", I[29], "Bone", { CFrame = CFrame.new(0.0000008, -0.7017571, 0) })
					I[31] = new("Pose", I[30], "Bone.007", { CFrame = CFrame.new(-0.0060031, -0.7017169, 0.0097442, 0.9816272, -0.0272246, -0.1888572, 0.0255405, 0.9996096, -0.0113458, 0.1890924, 0.0063138, 0.9819393) })
					I[32] = new("Pose", I[30], "Bone.001", { CFrame = CFrame.new(1.056196, 0.3400911, 0, -0.1113264, -0.9271678, 0.3577234, -0.2303208, 0.3742319, 0.8982778, -0.9667256, 0.0176109, -0.2552079) })
					I[33] = new("Pose", I[30], "Bone.004", { CFrame = CFrame.new(-0.8826206, 0.5172194, -0.0000535, -0.2419205, 0.8730117, -0.4234678, -0.1155346, 0.407409, 0.9059082, 0.963393, 0.2680829, 0.0023025) })
					I[34] = new("Pose", I[30], "Bone.009", { CFrame = CFrame.new(-0.0059973, -0.7016768, 0.0098513, 1, -0.0000508, -0.0004283, 0.0000567, 0.9999073, 0.0136291, 0.0004275, -0.0136291, 0.9999073) })
					I[35] = new("Pose", I[30], "Bone.012", { Weight = 0 })
						I[36] = new("Pose", I[35], "Bone.013", { CFrame = CFrame.new(0.0000017, 0, 0, 0.9848065, -0.1736553, 0, 0.1736553, 0.9848065, 0, 0, 0, 1) })
		I[37] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
