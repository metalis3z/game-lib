-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~35/Walk Talpa de ferru.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Talpa de ferru", { Priority = Enum.AnimationPriority.Core }, nil, { "1786757747" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.3508785, 0) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9892193, -0.1446069, -0.023107, 0.1446069, 0.9396926, 0.3099461, -0.0231069, -0.3099461, 0.9504733) })
						I[6] = new("Pose", I[5], "Bone.011")
					I[7] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9961271, -0.0147842, 0.0866745, -0.0147842, 0.9435657, 0.3308554, -0.0866745, -0.3308554, 0.9396929) })
						I[8] = new("Pose", I[7], "Bone.005", { CFrame = CFrame.new(0.0000134, 0, 0.0001606, 0.9999502, -0.0017344, 0.0098431, -0.0017344, 0.9397739, 0.3417926, -0.0098432, -0.3417926, 0.939724) })
					I[9] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[10] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9961271, 0.0147842, 0.0866745, 0.0147842, 0.9435657, -0.3308554, -0.0866745, 0.3308554, 0.9396929) })
						I[11] = new("Pose", I[10], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9999498, 0.0017401, -0.0098727, 0.0017401, 0.9397428, 0.3418779, 0.0098727, -0.3418778, 0.9396926) })
					I[12] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.9892193, 0.1446069, -0.023107, -0.1446069, 0.9396926, -0.3099461, -0.0231069, 0.3099461, 0.9504733) })
						I[13] = new("Pose", I[12], "Bone.013")
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { Weight = 0 })
					I[17] = new("Pose", I[16], "Bone.010", { CFrame = CFrame.new(0, -0.175456, 0, 0.9892193, 0.1446069, -0.023107, -0.1446069, 0.9396926, -0.3099461, -0.0231069, 0.3099461, 0.9504733) })
						I[18] = new("Pose", I[17], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9892195, -0.1446069, -0.0231069, 0.1446069, 0.9396926, 0.3099461, -0.0231069, -0.3099461, 0.9504732) })
					I[19] = new("Pose", I[16], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000073, 0, 0.0000073, 1, 0, 0, 0, 1) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone")
					I[23] = new("Pose", I[22], "Bone.010", { CFrame = CFrame.new(0, 0.3508652, 0, 0.9892193, 0.1446069, -0.023107, -0.1446069, 0.9396926, -0.3099461, -0.0231069, 0.3099461, 0.9504733) })
					I[24] = new("Pose", I[22], "Bone.004", { CFrame = CFrame.new(-0.0000033, -0.0000067, 0, 0.9961269, -0.014785, -0.086677, -0.0147851, 0.9435624, -0.3308651, 0.086677, 0.3308649, 0.9396893) })
					I[25] = new("Pose", I[22], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[26] = new("Pose", I[22], "Bone.001", { CFrame = CFrame.new(0, -0.0000067, 0, 0.9961267, 0.0147859, -0.0866793, 0.0147859, 0.9435593, 0.3308737, 0.0866793, -0.3308737, 0.9396859) })
					I[27] = new("Pose", I[22], "Bone.012", { CFrame = CFrame.new(0, 0.3508652, 0, 0.9892193, -0.1446069, -0.023107, 0.1446069, 0.9396926, 0.3099461, -0.0231069, -0.3099461, 0.9504733) })
						I[28] = new("Pose", I[27], "Bone.013", { CFrame = CFrame.new(0, 0, 0, 0.9892195, -0.1446069, -0.0231069, 0.1446069, 0.9396926, 0.3099461, -0.0231069, -0.3099461, 0.9504732) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[30] = new("Pose", I[29], "Mesh", { Weight = 0 })
				I[31] = new("Pose", I[30], "Bone", { CFrame = CFrame.new(0, -0.3508785, 0) })
					I[32] = new("Pose", I[31], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9892193, -0.1446069, -0.023107, 0.1446069, 0.9396926, 0.3099461, -0.0231069, -0.3099461, 0.9504733) })
					I[33] = new("Pose", I[31], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9961271, -0.0147842, 0.0866745, -0.0147842, 0.9435657, 0.3308554, -0.0866745, -0.3308554, 0.9396929) })
					I[34] = new("Pose", I[31], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[35] = new("Pose", I[31], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9961271, 0.0147842, 0.0866745, 0.0147842, 0.9435657, -0.3308554, -0.0866745, 0.3308554, 0.9396929) })
					I[36] = new("Pose", I[31], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.9892193, 0.1446069, -0.023107, -0.1446069, 0.9396926, -0.3099461, -0.0231069, 0.3099461, 0.9504733) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[38] = new("Pose", I[37], "Mesh", { Weight = 0 })
				I[39] = new("Pose", I[38], "Bone", { Weight = 0 })
					I[40] = new("Pose", I[39], "Bone.010", { Weight = 0 })
						I[41] = new("Pose", I[40], "Bone.011", { CFrame = CFrame.new(0, 0.0000067, 0, 1, 0.0000043, 0, -0.0000044, 1, -0.0000094, 0, 0.0000093, 1) })
					I[42] = new("Pose", I[39], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 1, 0.0000073, 0, -0.0000073, 1, 0, 0, 0, 1) })
					I[43] = new("Pose", I[39], "Bone.012", { CFrame = CFrame.new(0, -0.3508852, 0) })
						I[44] = new("Pose", I[43], "Bone.013", { CFrame = CFrame.new(0, 0, 0, 1, 0.0000043, 0, -0.0000043, 1, -0.0000094, 0, 0.0000093, 1) })
		I[45] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
