-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~35/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786760294" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0.1754426, 0) })
					I[5] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9990245, -0.0037243, 0.0440058, -0.0037243, 0.9857835, 0.1679797, -0.0440058, -0.1679797, 0.984808) })
						I[6] = new("Pose", I[5], "Bone.005", { CFrame = CFrame.new(0, -0.0000067, -0.0000535, 0.9999498, -0.0017401, 0.0098727, -0.0017401, 0.9397427, 0.3418776, -0.0098727, -0.3418776, 0.9396926) })
					I[7] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, -0.1754493, 0) })
					I[8] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9961271, 0.0147842, 0.0866746, 0.0147842, 0.9435657, -0.3308557, -0.0866746, 0.3308557, 0.9396928) })
						I[9] = new("Pose", I[8], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9999498, 0.0017401, -0.0098727, 0.0017401, 0.9397429, 0.3418776, 0.0098727, -0.3418776, 0.9396927) })
					I[10] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, -0.1754493, 0) })
					I[11] = new("Pose", I[4], "Bone.007")
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[13] = new("Pose", I[12], "Mesh", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { CFrame = CFrame.new(0, 0.1754426, 0) })
					I[15] = new("Pose", I[14], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9990245, -0.0037243, 0.0440058, -0.0037243, 0.9857835, 0.1679797, -0.0440058, -0.1679797, 0.984808) })
						I[16] = new("Pose", I[15], "Bone.005", { CFrame = CFrame.new(0, -0.0000067, -0.0000535, 0.9999498, -0.0017401, 0.0098727, -0.0017401, 0.9397427, 0.3418776, -0.0098727, -0.3418776, 0.9396926) })
					I[17] = new("Pose", I[14], "Bone.010", { CFrame = CFrame.new(0, -0.1754493, 0) })
					I[18] = new("Pose", I[14], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9961271, 0.0147842, 0.0866746, 0.0147842, 0.9435657, -0.3308557, -0.0866746, 0.3308557, 0.9396928) })
						I[19] = new("Pose", I[18], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9999498, 0.0017401, -0.0098727, 0.0017401, 0.9397429, 0.3418776, 0.0098727, -0.3418776, 0.9396927) })
					I[20] = new("Pose", I[14], "Bone.012", { CFrame = CFrame.new(0, -0.1754493, 0) })
					I[21] = new("Pose", I[14], "Bone.007")
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[23] = new("Pose", I[22], "Mesh", { Weight = 0 })
				I[24] = new("Pose", I[23], "Bone")
					I[25] = new("Pose", I[24], "Bone.010", { CFrame = CFrame.new(0, -0.3508852, 0) })
					I[26] = new("Pose", I[24], "Bone.001", { CFrame = CFrame.new(0, -0.0000067, 0, 0.9990243, 0.0037248, -0.0440084, 0.0037248, 0.9857818, 0.1679896, 0.0440084, -0.1679895, 0.9848062) })
					I[27] = new("Pose", I[24], "Bone.004", { CFrame = CFrame.new(-0.0000033, -0.0000067, 0, 0.9961269, -0.0147849, -0.0866766, -0.0147849, 0.9435629, -0.3308633, 0.0866766, 0.3308633, 0.9396898) })
					I[28] = new("Pose", I[24], "Bone.012", { CFrame = CFrame.new(0, -0.3508852, 0) })
					I[29] = new("Pose", I[24], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961943, -0.08716, 0, 0.08716, 0.9961943) })
		I[30] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
