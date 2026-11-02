-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~21/Walk LIrililarila.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk LIrililarila", nil, nil, { "1786654675" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(-0.000005, 0, 0, 1, 0.0000103, 0, -0.0000103, 1, 0, 0, 0, 1.0000002) })
					I[5] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, 0.0000099, 1.0000001, 0.000011, 0, -0.000011, 1.0000001, 0, 0, 0, 1.0000005) })
						I[6] = new("Pose", I[5], "Bone.008", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.009", { CFrame = CFrame.new(0.0000495, -0.0001189, 0, 0.7660445, -0.6427876, 0.0000041, 0.6427876, 0.7660445, -0.0000018, -0.000002, 0.000004, 1.0000002) })
					I[8] = new("Pose", I[4], "Bone.001")
					I[9] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3420202, -0.0000018, -0.3420202, 0.9396927, -0.0000013, 0.0000013, 0.0000019, 1.0000005) })
						I[10] = new("Pose", I[9], "Bone.011", { Weight = 0 })
							I[11] = new("Pose", I[10], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5000936, -0.8659717, 0.0000022, 0.8659717, 0.5000936, -0.0000005, -0.0000007, 0.0000022, 1.0000007) })
				I[12] = new("Pose", I[3], "Bone.013")
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[14] = new("Pose", I[13], "Mesh", { Weight = 0 })
				I[15] = new("Pose", I[14], "Bone", { CFrame = CFrame.new(0.004211, 2.5974424, -0.0000644, 0.9397674, -0.3418147, 0, 0.3418147, 0.9397674, 0, 0, 0, 1.0000002) })
					I[16] = new("Pose", I[15], "Bone.007", { CFrame = CFrame.new(0.0000396, -0.000005, 0.000005, 0.9396928, -0.3420202, 0.0000013, 0.3420202, 0.9396928, 0.0000019, -0.0000018, -0.0000013, 1.0000005) })
						I[17] = new("Pose", I[16], "Bone.008", { Weight = 0 })
							I[18] = new("Pose", I[17], "Bone.009", { CFrame = CFrame.new(0, 0, 0, 0.1736482, 0.9848079, 0.0000047, -0.9848079, 0.1736482, 0.000007, 0.0000061, -0.0000059, 1.0000002) })
					I[19] = new("Pose", I[15], "Bone.001", { CFrame = CFrame.new(0.0001783, 0.0001189, -0.0000149, 0.9396698, 0.342083, -0.0000019, -0.342083, 0.9396698, 0.0000013, 0.0000022, -0.0000006, 1.0000002) })
					I[20] = new("Pose", I[15], "Bone.010")
						I[21] = new("Pose", I[20], "Bone.011", { Weight = 0 })
							I[22] = new("Pose", I[21], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5, 0.8660256, 0.0000004, -0.8660256, 0.5, 0.0000066, 0.0000055, -0.0000036, 1.0000007) })
				I[23] = new("Pose", I[14], "Bone.013", { CFrame = CFrame.new(-1.9479728, -0.0185483, -0.0000446, 0.9999999, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[25] = new("Pose", I[24], "Mesh", { Weight = 0 })
				I[26] = new("Pose", I[25], "Bone", { CFrame = CFrame.new(0.4065823, 0.9532979, -0.0000644, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
					I[27] = new("Pose", I[26], "Bone.007", { CFrame = CFrame.new(0.0000396, -0.000005, 0.000005, 0.9396928, -0.3420202, 0.0000013, 0.3420202, 0.9396928, 0.0000019, -0.0000018, -0.0000013, 1.0000005) })
						I[28] = new("Pose", I[27], "Bone.008", { Weight = 0 })
							I[29] = new("Pose", I[28], "Bone.009", { CFrame = CFrame.new(0, 0, 0, 0.1736482, 0.9848079, 0.0000047, -0.9848079, 0.1736482, 0.000007, 0.0000061, -0.0000059, 1.0000002) })
					I[30] = new("Pose", I[26], "Bone.010")
						I[31] = new("Pose", I[30], "Bone.011", { Weight = 0 })
							I[32] = new("Pose", I[31], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5, 0.8660256, 0.0000004, -0.8660256, 0.5, 0.0000066, 0.0000055, -0.0000036, 1.0000007) })
				I[33] = new("Pose", I[25], "Bone.013", { CFrame = CFrame.new(-0.649311, -0.0061877, -0.0000149, 0.939696, 0.3420108, -0.0000013, -0.3420109, 0.9396961, -0.0000078, -0.0000014, 0.0000077, 1) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[35] = new("Pose", I[34], "Mesh", { Weight = 0 })
				I[36] = new("Pose", I[35], "Bone", { CFrame = CFrame.new(-0.000005, 0, 0, 1, 0.0000103, 0, -0.0000103, 1, 0, 0, 0, 1.0000002) })
					I[37] = new("Pose", I[36], "Bone.007", { CFrame = CFrame.new(0, 0, 0.0000099, 1.0000001, 0.000011, 0, -0.000011, 1.0000001, 0, 0, 0, 1.0000005) })
						I[38] = new("Pose", I[37], "Bone.008", { Weight = 0 })
							I[39] = new("Pose", I[38], "Bone.009", { CFrame = CFrame.new(0.0000495, -0.0001189, 0, 0.7660445, -0.6427876, 0.0000041, 0.6427876, 0.7660445, -0.0000018, -0.000002, 0.000004, 1.0000002) })
					I[40] = new("Pose", I[36], "Bone.001")
					I[41] = new("Pose", I[36], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3420202, -0.0000018, -0.3420202, 0.9396927, -0.0000013, 0.0000013, 0.0000019, 1.0000005) })
						I[42] = new("Pose", I[41], "Bone.011", { Weight = 0 })
							I[43] = new("Pose", I[42], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5000936, -0.8659717, 0.0000022, 0.8659717, 0.5000936, -0.0000005, -0.0000007, 0.0000022, 1.0000007) })
				I[44] = new("Pose", I[35], "Bone.013")
		I[45] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
