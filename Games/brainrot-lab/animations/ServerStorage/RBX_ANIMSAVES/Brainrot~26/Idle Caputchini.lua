-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~26/Idle Caputchini.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Caputchini", { Priority = Enum.AnimationPriority.Core }, nil, { "1786673012" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.1754359, 0) })
					I[5] = new("Pose", I[4], "Bone.003")
					I[6] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9848128, -0.1728865, -0.0159411, 0.1729361, 0.9849314, 0.0017875, 0.0153919, -0.0045172, 0.9998714) })
						I[7] = new("Pose", I[6], "Bone.008", { CFrame = CFrame.new(0.0001205, 0, 0.0000535, 0.8660348, 0.4999782, -0.0024033, -0.4999782, 0.865992, -0.0089273, -0.0023822, 0.008933, 0.9999574) })
					I[8] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9848083, 0.1729456, 0.015578, -0.1729311, 0.9849312, -0.0022839, -0.0157383, -0.0004447, 0.9998762) })
						I[9] = new("Pose", I[8], "Bone.006", { CFrame = CFrame.new(0.0000134, -0.0000067, 0, 0.9396948, -0.3420145, -0.0003525, 0.3420144, 0.9396927, 0.0019805, -0.0003461, -0.0019815, 0.999998) })
					I[10] = new("Pose", I[4], "Bone.001")
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone")
					I[14] = new("Pose", I[13], "Bone.003", { CFrame = CFrame.new(0.005809, 0.1752218, 0.0064248, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
					I[15] = new("Pose", I[13], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 1.0000001, 0.0000073, 0.0000007, -0.0000073, 1, -0.0000001, -0.0000006, 0.0000001, 1) })
						I[16] = new("Pose", I[15], "Bone.008", { CFrame = CFrame.new(0.0001205, -0.0000134, -0.0000535, 0.9396936, 0.3420157, -0.0010865, -0.3420156, 0.9396743, -0.0061264, -0.0010744, 0.0061286, 0.9999808) })
					I[17] = new("Pose", I[13], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 1.0000001, -0.0000079, -0.0000007, 0.0000079, 1, 0.0000001, 0.0000007, 0, 1.0000001) })
						I[18] = new("Pose", I[17], "Bone.006", { CFrame = CFrame.new(0, -0.0000067, 0, 0.9396948, -0.3420145, -0.0003525, 0.3420144, 0.9396927, 0.0019805, -0.0003461, -0.0019816, 0.999998) })
					I[19] = new("Pose", I[13], "Bone.001", { CFrame = CFrame.new(0.0058358, 0.1752218, 0.0064248, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1.5833334 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, -0.1754359, 0) })
					I[23] = new("Pose", I[22], "Bone.003")
					I[24] = new("Pose", I[22], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9848128, -0.1728865, -0.0159411, 0.1729361, 0.9849314, 0.0017875, 0.0153919, -0.0045172, 0.9998714) })
						I[25] = new("Pose", I[24], "Bone.008", { CFrame = CFrame.new(0.0001205, 0, 0.0000535, 0.8660348, 0.4999782, -0.0024033, -0.4999782, 0.865992, -0.0089273, -0.0023822, 0.008933, 0.9999574) })
					I[26] = new("Pose", I[22], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9848083, 0.1729456, 0.015578, -0.1729311, 0.9849312, -0.0022839, -0.0157383, -0.0004447, 0.9998762) })
						I[27] = new("Pose", I[26], "Bone.006", { CFrame = CFrame.new(0.0000134, -0.0000067, 0, 0.9396948, -0.3420145, -0.0003525, 0.3420144, 0.9396927, 0.0019805, -0.0003461, -0.0019815, 0.999998) })
					I[28] = new("Pose", I[22], "Bone.001")
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[30] = new("Pose", I[29], "Mesh", { Weight = 0 })
				I[31] = new("Pose", I[30], "Bone", { Weight = 0 })
					I[32] = new("Pose", I[31], "Bone.007", { Weight = 0 })
						I[33] = new("Pose", I[32], "Bone.008", { CFrame = CFrame.new(0.0001205, -0.0000134, 0, 0.9848021, 0.1736815, -0.0002761, -0.1736816, 0.9847969, -0.0031397, -0.0002734, 0.0031399, 0.9999952) })
					I[34] = new("Pose", I[31], "Bone.005", { Weight = 0 })
						I[35] = new("Pose", I[34], "Bone.006", { CFrame = CFrame.new(0, -0.0000067, 0, 1, 0.0000102, 0, -0.0000103, 0.9999999, -0.0000001, 0, 0.0000001, 0.9999999) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 1.1666666 })
			I[37] = new("Pose", I[36], "Mesh", { Weight = 0 })
				I[38] = new("Pose", I[37], "Bone", { Weight = 0 })
					I[39] = new("Pose", I[38], "Bone.007", { Weight = 0 })
						I[40] = new("Pose", I[39], "Bone.008", { CFrame = CFrame.new(0.0001205, -0.0000134, 0, 0.9848021, 0.1736815, -0.0002761, -0.1736816, 0.9847969, -0.0031397, -0.0002734, 0.0031399, 0.9999952) })
					I[41] = new("Pose", I[38], "Bone.005", { Weight = 0 })
						I[42] = new("Pose", I[41], "Bone.006", { CFrame = CFrame.new(0, -0.0000067, 0, 1, 0.0000102, 0, -0.0000103, 0.9999999, -0.0000001, 0, 0.0000001, 0.9999999) })
		I[43] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
