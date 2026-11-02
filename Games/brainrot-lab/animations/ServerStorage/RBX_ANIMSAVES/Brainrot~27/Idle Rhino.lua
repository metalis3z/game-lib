-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~27/Idle Rhino.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Rhino", { Priority = Enum.AnimationPriority.Core }, nil, { "1786674102" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.3508785, 0) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(-0.0098781, -0.3502494, 0.0185247, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Bone.006")
					I[7] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(-0.0098781, -0.3502494, 0.0185515, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
					I[8] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0.0000535, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
						I[9] = new("Pose", I[8], "Bone.002")
					I[10] = new("Pose", I[4], "Bone.005")
					I[11] = new("Pose", I[4], "Bone.015", { CFrame = CFrame.new(0.0000268, 0.0000134, -0.0001071, 0.7952563, 0.6038293, -0.0543846, -0.5979239, 0.7663063, -0.2350781, -0.1002717, 0.2194652, 0.9704538) })
					I[12] = new("Pose", I[4], "Bone.013", { CFrame = CFrame.new(-0.0000268, -0.0000134, 0.0001071, 0.7961069, 0.5966323, -0.1012093, -0.6026189, 0.7663059, -0.2227683, -0.0553535, 0.2383381, 0.9696034) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[14] = new("Pose", I[13], "Mesh", { Weight = 0 })
				I[15] = new("Pose", I[14], "Bone")
					I[16] = new("Pose", I[15], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
					I[17] = new("Pose", I[15], "Bone.007", { CFrame = CFrame.new(0.0000268, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
					I[18] = new("Pose", I[15], "Bone.001", { CFrame = CFrame.new(0, 0.0001071, 0.0000067, 1, 0, 0, 0, 0.9999999, -0.0000073, 0, 0.0000073, 0.9999999) })
					I[19] = new("Pose", I[15], "Bone.015", { CFrame = CFrame.new(0.0000535, 0.0000268, -0.0001606, 0.4242106, 0.8866885, -0.183926, -0.8700814, 0.342796, -0.3541883, -0.2510055, 0.3102809, 0.9169089) })
					I[20] = new("Pose", I[15], "Bone.013", { CFrame = CFrame.new(-0.0000535, -0.0000134, 0.0001606, 0.4266026, 0.8681387, -0.2536635, -0.8849744, 0.3427945, -0.3151388, -0.1866297, 0.3589247, 0.9145174) })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[22] = new("Pose", I[21], "Mesh", { Weight = 0 })
				I[23] = new("Pose", I[22], "Bone", { CFrame = CFrame.new(0, -0.3508785, 0) })
					I[24] = new("Pose", I[23], "Bone.010", { CFrame = CFrame.new(-0.0098781, -0.3502494, 0.0185247, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
					I[25] = new("Pose", I[23], "Bone.007", { CFrame = CFrame.new(-0.0098781, -0.3502494, 0.0185515, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
					I[26] = new("Pose", I[23], "Bone.001", { CFrame = CFrame.new(0, 0.0000535, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
						I[27] = new("Pose", I[26], "Bone.002")
					I[28] = new("Pose", I[23], "Bone.015", { CFrame = CFrame.new(0.0000268, 0.0000134, -0.0001071, 0.7952563, 0.6038293, -0.0543846, -0.5979239, 0.7663063, -0.2350781, -0.1002717, 0.2194652, 0.9704538) })
					I[29] = new("Pose", I[23], "Bone.013", { CFrame = CFrame.new(-0.0000268, -0.0000134, 0.0001071, 0.7961069, 0.5966323, -0.1012093, -0.6026189, 0.7663059, -0.2227683, -0.0553535, 0.2383381, 0.9696034) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.006", { CFrame = CFrame.new(0, -1.6666681, 0) })
					I[34] = new("Pose", I[32], "Bone.005", { CFrame = CFrame.new(0, -1.6666681, 0) })
					I[35] = new("Pose", I[32], "Bone.001", { Weight = 0 })
						I[36] = new("Pose", I[35], "Bone.002", { CFrame = CFrame.new(0, -0.0000535, -0.0000268, 1, 0, 0, 0, 0.9063078, 0.4226183, 0, -0.4226183, 0.9063078) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[38] = new("Pose", I[37], "Mesh", { Weight = 0 })
				I[39] = new("Pose", I[38], "Bone", { Weight = 0 })
					I[40] = new("Pose", I[39], "Bone.006", { CFrame = CFrame.new(0, -0.5263144, 0) })
					I[41] = new("Pose", I[39], "Bone.005", { CFrame = CFrame.new(0, -0.5263144, 0) })
					I[42] = new("Pose", I[39], "Bone.001", { Weight = 0 })
						I[43] = new("Pose", I[42], "Bone.002", { CFrame = CFrame.new(0, -0.0001071, -0.0000803, 1, 0, 0, 0, 1.0000001, -0.0000127, 0, 0.0000127, 1.0000001) })
		I[44] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
