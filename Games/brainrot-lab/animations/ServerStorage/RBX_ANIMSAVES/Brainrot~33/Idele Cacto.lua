-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~33/Idele Cacto.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idele Cacto", { Priority = Enum.AnimationPriority.Core }, nil, { "1786752552" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0.2142879, 0) })
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848078, 0.1736482, 0, -0.1736482, 0.9848078) })
						I[6] = new("Pose", I[5], "Bone.006", { CFrame = CFrame.new(-0.0000109, 0.0000054, 0, 0.9934894, 0.0251043, -0.111125, -0.0395205, 0.9907925, -0.1294934, 0.106851, 0.133042, 0.9853339) })
						I[7] = new("Pose", I[5], "Bone.005", { CFrame = CFrame.new(-0.0000109, 0, 0, 0.9935031, -0.0245969, 0.1111163, 0.0390275, 0.9907949, -0.1296238, -0.1069051, 0.1331183, 0.9853176) })
					I[8] = new("Pose", I[4], "Bone.007")
					I[9] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0, 0, -0.0000054, 0.9980307, 0.0051031, 0.0625204, 0.005103, 0.9867771, -0.1620028, -0.0625204, 0.1620028, 0.984808) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, -0.0714275, 0) })
					I[13] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077) })
						I[14] = new("Pose", I[13], "Bone.006", { CFrame = CFrame.new(-0.0000163, -0.0000054, 0, 0.990918, 0.0801333, 0.1079837, -0.0944222, 0.9864092, 0.1344679, -0.0957407, -0.1434427, 0.9850169) })
						I[15] = new("Pose", I[13], "Bone.005", { CFrame = CFrame.new(-0.0000109, -0.0000054, 0, 0.9908736, -0.0806792, -0.1079842, 0.0949327, 0.9864066, 0.1341272, 0.095695, -0.1431543, 0.9850633) })
					I[16] = new("Pose", I[12], "Bone.007", { CFrame = CFrame.new(0, 0, 0.2142879, 0.9980307, -0.0051031, -0.0625204, -0.005103, 0.9867771, -0.1620028, 0.0625204, 0.1620028, 0.984808) })
					I[17] = new("Pose", I[12], "Bone.008", { CFrame = CFrame.new(0, 0, 0.2142879, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, 0.2142879, 0) })
					I[21] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848078, 0.1736482, 0, -0.1736482, 0.9848078) })
						I[22] = new("Pose", I[21], "Bone.006", { CFrame = CFrame.new(-0.0000109, 0.0000054, 0, 0.9934894, 0.0251043, -0.111125, -0.0395205, 0.9907925, -0.1294934, 0.106851, 0.133042, 0.9853339) })
						I[23] = new("Pose", I[21], "Bone.005", { CFrame = CFrame.new(-0.0000109, 0, 0, 0.9935031, -0.0245969, 0.1111163, 0.0390275, 0.9907949, -0.1296238, -0.1069051, 0.1331183, 0.9853176) })
					I[24] = new("Pose", I[20], "Bone.007")
					I[25] = new("Pose", I[20], "Bone.008", { CFrame = CFrame.new(0, 0, -0.0000054, 0.9980307, 0.0051031, 0.0625204, 0.005103, 0.9867771, -0.1620028, -0.0625204, 0.1620028, 0.984808) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
