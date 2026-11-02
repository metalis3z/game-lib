-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~15/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786649695" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(-0.0000054, 0, 0, 1, 0, 0, 0, 0.9396929, 0.3420202, 0, -0.3420202, 0.9396929) })
						I[6] = new("Pose", I[5], "Bone.010", { CFrame = CFrame.new(0, 0.0000436, 0.0000218, 1, 0, 0, 0, 0.9396851, -0.3420413, 0, 0.3420413, 0.9396851) })
					I[7] = new("Pose", I[4], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.0818505, 0.3320817, 0.0818505, 0.996546, 0.0140131, -0.3320817, 0.0140131, 0.9431465) })
					I[8] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(-0.0000054, -0.0000109, 0, 1, 0, 0, 0, 0.9396929, -0.3420202, 0, 0.3420202, 0.9396929) })
						I[9] = new("Pose", I[8], "Bone.006")
					I[10] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396929, -0.3420202, 0, 0.3420202, 0.9396929) })
						I[11] = new("Pose", I[10], "Bone.008")
					I[12] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396929, 0.3420202, 0, -0.3420202, 0.9396929) })
						I[13] = new("Pose", I[12], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396929, -0.3420202, 0, 0.3420202, 0.9396929) })
					I[14] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[15] = new("Pose", I[14], "Bone.002", { CFrame = CFrame.new(0, 0.0000109, -0.0000872, 0.9396926, -0.3079025, -0.1489086, 0.3402624, 0.8856913, 0.3158673, 0.0346307, -0.3474862, 0.9370453) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.009", { CFrame = CFrame.new(-0.0000109, 0.0000109, 0, 1, 0, 0, 0, 0.9396892, -0.3420302, 0, 0.3420302, 0.9396892) })
						I[20] = new("Pose", I[19], "Bone.010", { CFrame = CFrame.new(0, 0.0000872, 0.0000163, 1, 0, 0, 0, 0.9396971, 0.3420089, 0, -0.3420089, 0.9396971) })
					I[21] = new("Pose", I[18], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9396893, 0.0818526, -0.3320904, -0.0818526, 0.9965459, 0.0140138, 0.3320904, 0.0140138, 0.9431434) })
					I[22] = new("Pose", I[18], "Bone.005", { CFrame = CFrame.new(-0.0000109, -0.0000109, 0, 1, 0, 0, 0, 0.9396892, 0.3420302, 0, -0.3420302, 0.9396892) })
						I[23] = new("Pose", I[22], "Bone.006", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396928, -0.3420202, 0, 0.3420202, 0.9396928) })
					I[24] = new("Pose", I[18], "Bone.007", { CFrame = CFrame.new(0, 0.0000109, 0, 1, 0, 0, 0, 0.9396815, 0.3420513, 0, -0.3420513, 0.9396815) })
						I[25] = new("Pose", I[24], "Bone.008", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396927, -0.3420202, 0, 0.3420202, 0.9396927) })
					I[26] = new("Pose", I[18], "Bone.003", { CFrame = CFrame.new(0, -0.0000109, 0, 1, 0, 0, 0, 0.9396892, -0.3420302, 0, 0.3420302, 0.9396892) })
						I[27] = new("Pose", I[26], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396892, 0.3420306, 0, -0.3420306, 0.9396892) })
					I[28] = new("Pose", I[18], "Bone.001", { Weight = 0 })
						I[29] = new("Pose", I[28], "Bone.002", { CFrame = CFrame.new(0, 0.0000109, -0.0001308, 0.9396926, 0.3402624, 0.0346307, -0.3402624, 0.9403109, -0.006075, -0.0346307, -0.006075, 0.9993817) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.009", { CFrame = CFrame.new(-0.0000054, 0, 0, 1, 0, 0, 0, 0.9396929, 0.3420202, 0, -0.3420202, 0.9396929) })
						I[34] = new("Pose", I[33], "Bone.010", { CFrame = CFrame.new(0, 0.0000436, 0.0000218, 1, 0, 0, 0, 0.9396851, -0.3420413, 0, 0.3420413, 0.9396851) })
					I[35] = new("Pose", I[32], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9396926, -0.0818504, 0.3320817, 0.0818504, 0.996546, 0.0140131, -0.3320817, 0.0140131, 0.9431465) })
					I[36] = new("Pose", I[32], "Bone.005", { CFrame = CFrame.new(-0.0000054, -0.0000109, 0, 1, 0, 0, 0, 0.9396929, -0.3420202, 0, 0.3420202, 0.9396929) })
						I[37] = new("Pose", I[36], "Bone.006")
					I[38] = new("Pose", I[32], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396929, -0.3420202, 0, 0.3420202, 0.9396929) })
						I[39] = new("Pose", I[38], "Bone.008")
					I[40] = new("Pose", I[32], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396929, 0.3420202, 0, -0.3420202, 0.9396929) })
						I[41] = new("Pose", I[40], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396929, -0.3420202, 0, 0.3420202, 0.9396929) })
					I[42] = new("Pose", I[32], "Bone.001", { Weight = 0 })
						I[43] = new("Pose", I[42], "Bone.002", { CFrame = CFrame.new(0, 0.0000218, -0.0001744, 0.9396926, -0.3079025, -0.1489086, 0.3402624, 0.8856913, 0.3158673, 0.0346307, -0.3474862, 0.9370453) })
		I[44] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
