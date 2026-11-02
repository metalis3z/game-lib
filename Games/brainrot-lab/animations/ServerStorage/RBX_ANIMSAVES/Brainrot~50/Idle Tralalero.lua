-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~50/Idle Tralalero.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Tralalero", { Priority = Enum.AnimationPriority.Core }, nil, { "1787543269" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.035", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.1393345, -1.1343384, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, -0.5711746, -0.0171334, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[6] = new("Pose", I[4], "Bone.003", { Weight = 0 })
						I[7] = new("Pose", I[6], "Bone.004", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0, 0, 0.8660256, 0.5000001, 0, -0.5000001, 0.8660256) })
					I[8] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0, 0, 0.996195, -0.0871558, 0, 0.0871558, 0.996195) })
						I[9] = new("Pose", I[8], "Bone.008", { CFrame = CFrame.new(0, 0, 0.0000218, 1, 0, 0, 0, 0.9659292, -0.2588078, 0, 0.2588078, 0.9659292) })
						I[10] = new("Pose", I[8], "Bone.009", { CFrame = CFrame.new(0, 0.0000218, 0.0000218, 1, 0, 0, 0, 0.9659293, -0.2588073, 0, 0.2588073, 0.9659293) })
					I[11] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(-0.2702441, -0.5032893, -0.0142561, 1, 0.0000001, 0, 0.0000001, 1.0000004, 0, 0, 0, 1.0000004) })
					I[12] = new("Pose", I[4], "Bone.018", { CFrame = CFrame.new(0.2702658, -0.5032976, -0.0134713, 1.0000001, -0.0000001, 0, -0.0000001, 1.0000002, 0, 0, 0, 1.0000002) })
					I[13] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[14] = new("Pose", I[13], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9659261, -0.2588191, 0, 0.2588191, 0.9659261) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[16] = new("Pose", I[15], "Cube.035", { Weight = 0 })
				I[17] = new("Pose", I[16], "Bone", { CFrame = CFrame.new(0, -0.0696673, -0.5671692, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[18] = new("Pose", I[17], "Bone.010", { CFrame = CFrame.new(0, -0.0000163, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[19] = new("Pose", I[17], "Bone.003", { Weight = 0 })
						I[20] = new("Pose", I[19], "Bone.004", { CFrame = CFrame.new(0, 0, -0.0000218, 1, 0, 0, 0, 0.8660255, 0.5000003, 0, -0.5000003, 0.8660255) })
					I[21] = new("Pose", I[17], "Bone.007", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0, 0, 0.9848065, 0.1736568, 0, -0.1736568, 0.9848065) })
						I[22] = new("Pose", I[21], "Bone.008", { CFrame = CFrame.new(0, 0.1197597, -0.1317923, 1, 0, 0, 0, 0.9961915, 0.0871937, 0, -0.0871937, 0.9961915) })
						I[23] = new("Pose", I[21], "Bone.009", { CFrame = CFrame.new(0, -0.1114328, -0.138964, 1, 0, 0, 0, 0.9961916, 0.0871937, 0, -0.0871937, 0.9961916) })
					I[24] = new("Pose", I[17], "Bone.014", { CFrame = CFrame.new(-0.0000163, -0.0000163, 0, 1, 0.0000001, 0, 0.0000001, 1.0000004, 0, 0, 0, 1.0000004) })
					I[25] = new("Pose", I[17], "Bone.018", { CFrame = CFrame.new(0.0000054, -0.0000191, 0, 1.0000001, -0.0000001, 0, -0.0000001, 1.0000002, 0, 0, 0, 1.0000002) })
					I[26] = new("Pose", I[17], "Bone.001", { Weight = 0 })
						I[27] = new("Pose", I[26], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1.0000001, 0.0000103, 0, -0.0000103, 1.0000001) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[29] = new("Pose", I[28], "Cube.035", { Weight = 0 })
				I[30] = new("Pose", I[29], "Bone", { CFrame = CFrame.new(0, -0.1393345, -1.1343384, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[31] = new("Pose", I[30], "Bone.010", { CFrame = CFrame.new(0, -0.5711746, -0.0171334, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[32] = new("Pose", I[30], "Bone.003", { Weight = 0 })
						I[33] = new("Pose", I[32], "Bone.004", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0, 0, 0.8660256, 0.5000001, 0, -0.5000001, 0.8660256) })
					I[34] = new("Pose", I[30], "Bone.007", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0, 0, 0.996195, -0.0871558, 0, 0.0871558, 0.996195) })
						I[35] = new("Pose", I[34], "Bone.008", { CFrame = CFrame.new(0, 0, 0.0000218, 1, 0, 0, 0, 0.9659292, -0.2588078, 0, 0.2588078, 0.9659292) })
						I[36] = new("Pose", I[34], "Bone.009", { CFrame = CFrame.new(0, 0.0000218, 0.0000218, 1, 0, 0, 0, 0.9659293, -0.2588073, 0, 0.2588073, 0.9659293) })
					I[37] = new("Pose", I[30], "Bone.014", { CFrame = CFrame.new(-0.2702441, -0.5032893, -0.0142561, 1, 0.0000001, 0, 0.0000001, 1.0000004, 0, 0, 0, 1.0000004) })
					I[38] = new("Pose", I[30], "Bone.018", { CFrame = CFrame.new(0.2702658, -0.5032976, -0.0134713, 1.0000001, -0.0000001, 0, -0.0000001, 1.0000002, 0, 0, 0, 1.0000002) })
					I[39] = new("Pose", I[30], "Bone.001", { Weight = 0 })
						I[40] = new("Pose", I[39], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9659261, -0.2588191, 0, 0.2588191, 0.9659261) })
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[42] = new("Pose", I[41], "Cube.035", { Weight = 0 })
				I[43] = new("Pose", I[42], "Bone", { Weight = 0 })
					I[44] = new("Pose", I[43], "Bone.003", { Weight = 0 })
						I[45] = new("Pose", I[44], "Bone.004", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0, 0, 1.0000002, -0.0000047, 0, 0.0000047, 1.0000002) })
		I[46] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[47] = new("Pose", I[46], "Cube.035", { Weight = 0 })
				I[48] = new("Pose", I[47], "Bone", { Weight = 0 })
					I[49] = new("Pose", I[48], "Bone.003", { Weight = 0 })
						I[50] = new("Pose", I[49], "Bone.004", { CFrame = CFrame.new(0, 0, -0.0000327, 1, 0, 0, 0, 1.0000002, -0.0000042, 0, 0.0000042, 1.0000002) })
		I[51] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
