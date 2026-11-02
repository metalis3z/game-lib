-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~18/Idle Glorbo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Glorbo", { Priority = Enum.AnimationPriority.Core }, nil, { "1786652593" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.1312256, -0.7021332) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0.0065272, -0.6893049, -0.18716, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[6] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848078, 0.1736482, 0, -0.1736482, 0.9848078) })
						I[7] = new("Pose", I[6], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, 0.2588191, 0, -0.2588191, 0.965926) })
					I[8] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(-0.0075013, -0.6893049, -0.1870728, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[9] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(-0.0075, -0.6893267, -0.1870292, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[10] = new("Pose", I[4], "Bone.013", { CFrame = CFrame.new(0.0065259, -0.6893158, -0.1870728, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, 0, -0.0000054) })
					I[14] = new("Pose", I[13], "Bone.010", { CFrame = CFrame.new(0.0000014, -0.0000109, -0.0000436, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[15] = new("Pose", I[13], "Bone.001", { CFrame = CFrame.new(0, 0.0000872, 0.0000109, 1, 0, 0, 0, 1, -0.0000023, 0, 0.0000023, 1) })
						I[16] = new("Pose", I[15], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961956, 0.0871459, 0, -0.0871459, 0.9961956) })
					I[17] = new("Pose", I[13], "Bone.004", { CFrame = CFrame.new(-0.0000027, 0, -0.0000436, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[18] = new("Pose", I[13], "Bone.007", { CFrame = CFrame.new(0, -0.0000218, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[19] = new("Pose", I[13], "Bone.013", { CFrame = CFrame.new(-0.000002, -0.0000218, 0.0000436, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, -0.1312256, -0.7021332) })
					I[23] = new("Pose", I[22], "Bone.010", { CFrame = CFrame.new(0.0065272, -0.6893049, -0.18716, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[24] = new("Pose", I[22], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848078, 0.1736482, 0, -0.1736482, 0.9848078) })
						I[25] = new("Pose", I[24], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, 0.2588191, 0, -0.2588191, 0.965926) })
					I[26] = new("Pose", I[22], "Bone.004", { CFrame = CFrame.new(-0.0075013, -0.6893049, -0.1870728, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[27] = new("Pose", I[22], "Bone.007", { CFrame = CFrame.new(-0.0075, -0.6893267, -0.1870292, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[28] = new("Pose", I[22], "Bone.013", { CFrame = CFrame.new(0.0065259, -0.6893158, -0.1870728, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
		I[29] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
