-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~17/Idle Patapim.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Patapim", { Priority = Enum.AnimationPriority.Core }, nil, { "1787505033" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.3815351, -0.1952253, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[5] = new("Pose", I[4], "Bone.010")
					I[6] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0.0000014, -0.000049, 0, -0.0382097, 0.2329681, -0.9717335, 0.2169178, 0.951189, 0.2195133, 0.9754418, -0.2023987, -0.0868796) })
						I[7] = new("Pose", I[6], "Bone.006", { CFrame = CFrame.new(0.0000872, 0, -0.0000054, 0.9984516, 0.0537498, -0.0143185, -0.0537497, 0.8660255, -0.4971026, -0.0143189, 0.4971026, 0.8675736) })
					I[8] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(0, -0.0144305, 0.4283306, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[9] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0, -0.0144305, 0.4283306, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[10] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(-0.0000041, 0.0000054, 0, 0.1594783, -0.2467189, 0.9558747, -0.3441612, 0.8936262, 0.2880719, -0.9252674, -0.3749161, 0.0576029) })
						I[11] = new("Pose", I[10], "Bone.003", { CFrame = CFrame.new(0, -0.0000109, 0.0000109, 0.9975626, -0.0674445, 0.0178977, 0.0674402, 0.8660253, -0.4954308, 0.0179143, 0.4954303, 0.8684628) })
					I[12] = new("Pose", I[4], "Bone.013")
						I[13] = new("Pose", I[12], "Bone.014", { Weight = 0 })
							I[14] = new("Pose", I[13], "Bone.015", { CFrame = CFrame.new(-0.0000007, 0, -0.0000163, 1.0000001, 0, -0.0000001, 0, 0.9396936, -0.3420205, -0.0000001, 0.3420204, 0.9396936) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[16] = new("Pose", I[15], "Mesh", { Weight = 0 })
				I[17] = new("Pose", I[16], "Bone", { CFrame = CFrame.new(0, -0.0000218, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[18] = new("Pose", I[17], "Bone.010", { CFrame = CFrame.new(0.1425185, 0.4040064, -0.0119455, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
					I[19] = new("Pose", I[17], "Bone.005", { Weight = 0 })
						I[20] = new("Pose", I[19], "Bone.006", { CFrame = CFrame.new(0.0001308, 0.0000054, 0, 0.9996503, 0.0264453, -0.0002313, -0.0260913, 0.9847639, -0.1719289, -0.0043189, 0.1718748, 0.9851094) })
					I[21] = new("Pose", I[17], "Bone.002", { Weight = 0 })
						I[22] = new("Pose", I[21], "Bone.003", { CFrame = CFrame.new(-0.0000872, -0.0000218, 0.0000436, 0.9541909, -0.2977216, -0.0296923, 0.2799863, 0.9235012, -0.2622095, 0.1054865, 0.2418843, 0.9645543) })
					I[23] = new("Pose", I[17], "Bone.013", { CFrame = CFrame.new(-0.1428631, 0.404001, -0.0069754, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
						I[24] = new("Pose", I[23], "Bone.014", { Weight = 0 })
							I[25] = new("Pose", I[24], "Bone.015", { CFrame = CFrame.new(-0.0000007, 0, -0.0000054, 1.0000001, 0, -0.0000001, 0, 1.0000011, 0.0000134, -0.0000001, -0.0000133, 1.0000013) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[27] = new("Pose", I[26], "Mesh", { Weight = 0 })
				I[28] = new("Pose", I[27], "Bone", { CFrame = CFrame.new(0, -0.3815351, -0.1952253, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[29] = new("Pose", I[28], "Bone.010")
					I[30] = new("Pose", I[28], "Bone.005", { CFrame = CFrame.new(0.0000014, -0.000049, 0, -0.0382097, 0.2329681, -0.9717335, 0.2169178, 0.951189, 0.2195133, 0.9754418, -0.2023987, -0.0868796) })
						I[31] = new("Pose", I[30], "Bone.006", { CFrame = CFrame.new(0.0000872, 0, -0.0000054, 0.9984516, 0.0537498, -0.0143185, -0.0537497, 0.8660255, -0.4971026, -0.0143189, 0.4971026, 0.8675736) })
					I[32] = new("Pose", I[28], "Bone.002", { CFrame = CFrame.new(-0.0000041, 0.0000054, 0, 0.1594783, -0.2467189, 0.9558747, -0.3441612, 0.8936262, 0.2880719, -0.9252674, -0.3749161, 0.0576029) })
						I[33] = new("Pose", I[32], "Bone.003", { CFrame = CFrame.new(0, -0.0000109, 0.0000109, 0.9975626, -0.0674445, 0.0178977, 0.0674402, 0.8660253, -0.4954308, 0.0179143, 0.4954303, 0.8684628) })
					I[34] = new("Pose", I[28], "Bone.013")
						I[35] = new("Pose", I[34], "Bone.014", { Weight = 0 })
							I[36] = new("Pose", I[35], "Bone.015", { CFrame = CFrame.new(-0.0000014, 0, -0.0000272, 1.0000001, 0, -0.0000001, 0, 0.9396936, -0.3420205, -0.0000001, 0.3420204, 0.9396936) })
		I[37] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
