-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~30/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786747958" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(-0.0012716, -0.0006358, 0, 0.9999999, 0, 0, 0, 0.9999999, 0, 0, 0, 0.9999999) })
					I[5] = new("Pose", I[4], "Bone.001")
						I[6] = new("Pose", I[5], "Bone.002", { CFrame = CFrame.new(0.0012716, 0, 0, 0.965926, 0.0747759, 0.2477802, -0.0750023, 0.9971468, -0.0085391, -0.2477118, -0.010336, 0.9687785) })
							I[7] = new("Pose", I[6], "Bone.005", { CFrame = CFrame.new(-0.0012716, -0.0101725, 0.0006358, 0.9659306, 0.2582572, -0.0167644, -0.2582029, 0.9660758, 0.0053639, 0.0175809, -0.0008524, 0.9998453) })
					I[8] = new("Pose", I[4], "Bone.003", { Weight = 0 })
						I[9] = new("Pose", I[8], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9063079, -0.4226184, 0, 0.4226184, 0.9063079, 0, 0, 0, 1) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { Weight = 0 })
					I[13] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(-0.3051758, -43.0908203, -25.3601074, 0.9999977, -0.002077, -0.0001868, 0.0020779, 0.9848076, 0.1736357, -0.0001767, -0.1736357, 0.9848099) })
						I[14] = new("Pose", I[13], "Bone.002", { CFrame = CFrame.new(0.7870992, 7.9549155, 66.1856308, 0.9999949, -0.0030913, -0.0004109, 0.0030923, 0.9659303, 0.2587844, -0.0004031, -0.2587844, 0.9659349) })
							I[15] = new("Pose", I[14], "Bone.005", { CFrame = CFrame.new(-0.0012716, -0.0101725, 0, 0.9959592, 0.009304, -0.0893228, -0.0103349, 0.9998856, -0.0110842, 0.0892094, 0.0119626, 0.9959414) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(-0.0012716, -0.0006358, 0, 0.9999999, 0, 0, 0, 0.9999999, 0, 0, 0, 0.9999999) })
					I[19] = new("Pose", I[18], "Bone.001")
						I[20] = new("Pose", I[19], "Bone.002", { CFrame = CFrame.new(0.0012716, 0, 0, 0.965926, -0.0750023, -0.2477118, 0.0747759, 0.9971468, -0.010336, 0.2477802, -0.0085391, 0.9687784) })
							I[21] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(-0.0025431, -0.0203451, 0.0006358, 0.9662648, -0.2489764, -0.0659019, 0.2471543, 0.9683574, -0.0346229, 0.0724369, 0.0171671, 0.9972255) })
					I[22] = new("Pose", I[18], "Bone.003", { Weight = 0 })
						I[23] = new("Pose", I[22], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 1.0000001, 0.0000084, 0, -0.0000084, 1.0000001, 0, 0, 0, 1) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[25] = new("Pose", I[24], "Mesh", { Weight = 0 })
				I[26] = new("Pose", I[25], "Bone", { Weight = 0 })
					I[27] = new("Pose", I[26], "Bone.001", { CFrame = CFrame.new(-0.3051758, -43.0908203, -25.3601074, 0.9999977, -0.002077, -0.0001868, 0.0020779, 0.9848076, 0.1736357, -0.0001767, -0.1736357, 0.9848099) })
						I[28] = new("Pose", I[27], "Bone.002", { CFrame = CFrame.new(0.7870992, 7.9549155, 66.1856308, 0.9999949, -0.0030913, -0.0004109, 0.0030923, 0.9659303, 0.2587844, -0.0004031, -0.2587844, 0.9659349) })
							I[29] = new("Pose", I[28], "Bone.005", { CFrame = CFrame.new(-0.0012716, -0.0101725, 0, 0.9959592, 0.009304, -0.0893228, -0.0103349, 0.9998856, -0.0110842, 0.0892094, 0.0119626, 0.9959414) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { CFrame = CFrame.new(-0.0012716, -0.0006358, 0, 0.9999999, 0, 0, 0, 0.9999999, 0, 0, 0, 0.9999999) })
					I[33] = new("Pose", I[32], "Bone.001")
						I[34] = new("Pose", I[33], "Bone.002", { CFrame = CFrame.new(0.0012716, 0, 0, 0.965926, 0.0747759, 0.2477802, -0.0750023, 0.9971468, -0.0085391, -0.2477118, -0.010336, 0.9687785) })
							I[35] = new("Pose", I[34], "Bone.005", { CFrame = CFrame.new(-0.0012716, -0.0101725, 0.0006358, 0.9659306, 0.2582572, -0.0167644, -0.2582029, 0.9660758, 0.0053639, 0.0175809, -0.0008524, 0.9998453) })
					I[36] = new("Pose", I[32], "Bone.003", { Weight = 0 })
						I[37] = new("Pose", I[36], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9063079, -0.4226184, 0, 0.4226184, 0.9063079, 0, 0, 0, 1) })
		I[38] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
