-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~21/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786654319" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(-0.000005, 0, 0, 1, 0.0000103, 0, -0.0000103, 1, 0, 0, 0, 1.0000002) })
					I[5] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, 0.0000099, 1.0000001, 0.000011, 0, -0.000011, 1.0000001, 0, 0, 0, 1.0000005) })
						I[6] = new("Pose", I[5], "Bone.008", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.009", { CFrame = CFrame.new(0.0000495, -0.0001189, 0, 1, -0.0000331, 0.0000019, 0.0000331, 1, -0.0000013, -0.0000019, 0.0000013, 1.0000002) })
					I[8] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3420202, -0.0000018, -0.3420202, 0.9396927, -0.0000013, 0.0000013, 0.0000019, 1.0000005) })
						I[9] = new("Pose", I[8], "Bone.011", { Weight = 0 })
							I[10] = new("Pose", I[9], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5000936, -0.8659717, 0.0000022, 0.8659717, 0.5000936, -0.0000005, -0.0000007, 0.0000022, 1.0000007) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0.0031979, 1.948052, -0.0000099, 0.939704, -0.341989, 0, 0.341989, 0.939704, 0, 0, 0, 1.0000002) })
					I[14] = new("Pose", I[13], "Bone.007", { CFrame = CFrame.new(0.0000396, -0.000005, 0.000005, 0.9396928, -0.3420202, 0.0000013, 0.3420202, 0.9396928, 0.0000019, -0.0000018, -0.0000013, 1.0000005) })
						I[15] = new("Pose", I[14], "Bone.008", { Weight = 0 })
							I[16] = new("Pose", I[15], "Bone.009", { CFrame = CFrame.new(0, 0, 0, 0.1736482, 0.9848079, 0.0000047, -0.9848079, 0.1736482, 0.000007, 0.0000061, -0.0000059, 1.0000002) })
					I[17] = new("Pose", I[13], "Bone.010")
						I[18] = new("Pose", I[17], "Bone.011", { Weight = 0 })
							I[19] = new("Pose", I[18], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5, 0.8660256, 0.0000004, -0.8660256, 0.5, 0.0000066, 0.0000055, -0.0000036, 1.0000007) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(-0.000005, 0, 0, 1, 0.0000103, 0, -0.0000103, 1, 0, 0, 0, 1.0000002) })
					I[23] = new("Pose", I[22], "Bone.007", { CFrame = CFrame.new(0, 0, 0.0000099, 1.0000001, 0.000011, 0, -0.000011, 1.0000001, 0, 0, 0, 1.0000005) })
						I[24] = new("Pose", I[23], "Bone.008", { Weight = 0 })
							I[25] = new("Pose", I[24], "Bone.009", { CFrame = CFrame.new(0.0000495, -0.0001189, 0, 1, -0.0000331, 0.0000019, 0.0000331, 1, -0.0000013, -0.0000019, 0.0000013, 1.0000002) })
					I[26] = new("Pose", I[22], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3420202, -0.0000018, -0.3420202, 0.9396927, -0.0000013, 0.0000013, 0.0000019, 1.0000005) })
						I[27] = new("Pose", I[26], "Bone.011", { Weight = 0 })
							I[28] = new("Pose", I[27], "Bone.012", { CFrame = CFrame.new(0.0000198, 0, 0, 0.5000936, -0.8659717, 0.0000022, 0.8659717, 0.5000936, -0.0000005, -0.0000007, 0.0000022, 1.0000007) })
		I[29] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
