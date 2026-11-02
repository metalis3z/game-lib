-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", nil, nil, { "1786565371" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.005")
						I[6] = new("Pose", I[5], "Bone.006", { CFrame = CFrame.new(0, -0.0000054, 0, 0.9997265, -0.0233641, -0.0010171, 0.0232861, 0.9985238, -0.0490735, 0.0021621, 0.0490364, 0.9987947) })
						I[7] = new("Pose", I[5], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9998804, 0.0151368, 0.0032523, -0.0153626, 0.996084, 0.08707, -0.0019215, -0.0871096, 0.9961972) })
					I[8] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(-0.0000218, 0, -0.0000109, 0.9889029, -0.1479769, 0.0131939, 0.145122, 0.9431701, -0.2989477, 0.0317934, 0.297545, 0.9541785) })
						I[9] = new("Pose", I[8], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9934872, 0.1131637, 0.0133111, -0.1131626, 0.9662629, 0.2313661, 0.0133203, -0.2313655, 0.9727756) })
					I[10] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(-0.0000218, 0.0000054, -0.0000109, 0.9932825, 0.114189, 0.0187362, -0.1155877, 0.9714653, 0.2071112, 0.0054484, -0.2078855, 0.9781383) })
						I[11] = new("Pose", I[10], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9894709, -0.1431268, 0.021504, 0.143131, 0.9456112, -0.2921191, 0.0214759, 0.2921213, 0.9561405) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[13] = new("Pose", I[12], "Mesh", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { Weight = 0 })
					I[15] = new("Pose", I[14], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9904574, 0.1378196, 0, -0.1378196, 0.9904574) })
						I[16] = new("Pose", I[15], "Bone.006", { CFrame = CFrame.new(0, -0.0000027, 0, 0.9971108, 0.0749639, 0.0122701, -0.0758564, 0.9911466, 0.1089704, -0.0039926, -0.1095864, 0.9939694) })
						I[17] = new("Pose", I[15], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9999346, 0.0108246, -0.0037591, -0.0109375, 0.9994457, -0.0314465, 0.0034166, 0.0314856, 0.9994988) })
					I[18] = new("Pose", I[14], "Bone.001", { CFrame = CFrame.new(-0.0000436, 0, -0.0000218, 0.9995629, -0.0295507, -0.000964, 0.0294394, 0.9977578, -0.0601051, 0.0027381, 0.0600506, 0.9981917) })
					I[19] = new("Pose", I[14], "Bone.003", { CFrame = CFrame.new(-0.0000654, 0.0000163, -0.0000327, 0.9998741, 0.0158352, 0.0011435, -0.0158615, 0.9994649, 0.0286162, -0.0006896, -0.0286307, 0.9995902) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { Weight = 0 })
					I[23] = new("Pose", I[22], "Bone.005")
						I[24] = new("Pose", I[23], "Bone.006", { CFrame = CFrame.new(0, -0.0000054, 0, 0.9997265, -0.0233641, -0.0010171, 0.0232861, 0.9985238, -0.0490735, 0.0021621, 0.0490364, 0.9987947) })
						I[25] = new("Pose", I[23], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9998804, 0.0151368, 0.0032523, -0.0153626, 0.996084, 0.08707, -0.0019215, -0.0871096, 0.9961972) })
					I[26] = new("Pose", I[22], "Bone.001", { CFrame = CFrame.new(-0.0000218, 0, -0.0000109, 0.9889029, -0.1479769, 0.0131939, 0.145122, 0.9431701, -0.2989477, 0.0317934, 0.297545, 0.9541785) })
						I[27] = new("Pose", I[26], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9934872, 0.1131637, 0.0133111, -0.1131626, 0.9662629, 0.2313661, 0.0133203, -0.2313655, 0.9727756) })
					I[28] = new("Pose", I[22], "Bone.003", { CFrame = CFrame.new(-0.0000218, 0.0000054, -0.0000109, 0.9932825, 0.114189, 0.0187362, -0.1155877, 0.9714653, 0.2071112, 0.0054484, -0.2078855, 0.9781383) })
						I[29] = new("Pose", I[28], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9894709, -0.1431268, 0.021504, 0.143131, 0.9456112, -0.2921191, 0.0214759, 0.2921213, 0.9561405) })
		I[30] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
