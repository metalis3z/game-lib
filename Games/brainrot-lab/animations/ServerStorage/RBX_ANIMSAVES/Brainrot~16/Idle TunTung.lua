-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~16/Idle TunTung.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle TunTung", { Priority = Enum.AnimationPriority.Core }, nil, { "1786651347" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, 0.0871557, 0, -0.0871557, 0.9961947, 0, 0, 0, 1) })
					I[5] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0.0051008, -0.0447083, 0.0079782, 0.9943556, -0.10444, 0.0186848, 0.10444, 0.9945308, 0.0009787, -0.0186848, 0.0009782, 0.9998251) })
						I[6] = new("Pose", I[5], "Bone.013", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.9981304, 0.0100655, 0.0602827, -0.0100451, 0.9999499, -0.0006418, -0.060286, 0.000035, 0.9981816) })
					I[8] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9659258, 0.258819, 0, -0.258819, 0.9659258, 0, 0, 0, 1) })
					I[9] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(-0.0051008, 0.0448063, -0.0080218, 0.9999999, 0, 0, 0, 1, 0, 0, 0, 1.0000001) })
						I[10] = new("Pose", I[9], "Bone.010", { Weight = 0 })
							I[11] = new("Pose", I[10], "Bone.011")
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[13] = new("Pose", I[12], "Mesh", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947, 0, 0, 0, 1) })
					I[15] = new("Pose", I[14], "Bone.012", { CFrame = CFrame.new(0.0110245, 0.1725333, -0.0307792, 0.9986659, 0.0508288, -0.0090935, -0.0508288, 0.9987074, 0.0002312, 0.0090935, 0.0002314, 0.9999588) })
						I[16] = new("Pose", I[15], "Bone.013", { Weight = 0 })
							I[17] = new("Pose", I[16], "Bone.014", { CFrame = CFrame.new(-0.0165285, -0.0223214, -0.1337978, 0.9990531, 0.0071632, 0.0429135, -0.0071529, 0.999975, -0.0003946, -0.0429152, 0.0000872, 0.9990791) })
					I[18] = new("Pose", I[14], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9659258, -0.258819, 0, 0.258819, 0.9659258, 0, 0, 0, 1) })
					I[19] = new("Pose", I[14], "Bone.009", { CFrame = CFrame.new(0, 0, 0, 0.9931113, 0.1153433, -0.0206355, -0.1153433, 0.9933249, 0.001194, 0.0206354, 0.0011945, 0.9997864) })
						I[20] = new("Pose", I[19], "Bone.010", { Weight = 0 })
							I[21] = new("Pose", I[20], "Bone.011", { CFrame = CFrame.new(-0.0017875, -0.0129918, -0.0779506, 1.0000002, 0, 0, 0, 1.0000006, -0.0000001, 0, -0.0000001, 1.0000002) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 1.2 })
			I[23] = new("Pose", I[22], "Mesh", { Weight = 0 })
				I[24] = new("Pose", I[23], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, 0.0871557, 0, -0.0871557, 0.9961947, 0, 0, 0, 1) })
					I[25] = new("Pose", I[24], "Bone.012", { CFrame = CFrame.new(0.0051008, -0.0447083, 0.0079782, 0.9943556, -0.10444, 0.0186848, 0.10444, 0.9945308, 0.0009787, -0.0186848, 0.0009782, 0.9998251) })
						I[26] = new("Pose", I[25], "Bone.013", { Weight = 0 })
							I[27] = new("Pose", I[26], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.9981304, 0.0100655, 0.0602827, -0.0100451, 0.9999499, -0.0006418, -0.060286, 0.000035, 0.9981816) })
					I[28] = new("Pose", I[24], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9659258, 0.258819, 0, -0.258819, 0.9659258, 0, 0, 0, 1) })
					I[29] = new("Pose", I[24], "Bone.009", { CFrame = CFrame.new(-0.0051008, 0.0448063, -0.0080218, 0.9999999, 0, 0, 0, 1, 0, 0, 0, 1.0000001) })
						I[30] = new("Pose", I[29], "Bone.010", { Weight = 0 })
							I[31] = new("Pose", I[30], "Bone.011")
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[33] = new("Pose", I[32], "Mesh", { Weight = 0 })
				I[34] = new("Pose", I[33], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000046, 0, 0.0000046, 1, 0, 0, 0, 1) })
					I[35] = new("Pose", I[34], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000241, 0, 0.0000241, 1, 0, 0, 0, 1) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[37] = new("Pose", I[36], "Mesh", { Weight = 0 })
				I[38] = new("Pose", I[37], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000046, 0, 0.0000046, 1, 0, 0, 0, 1) })
					I[39] = new("Pose", I[38], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000241, 0, 0.0000241, 1, 0, 0, 0, 1) })
		I[40] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
