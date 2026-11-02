-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~4/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", { Priority = Enum.AnimationPriority.Core }, nil, { "1786569429" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9999881, 0.0002714, -0.004878, 0.0002714, 0.9938271, 0.1109399, 0.004878, -0.1109399, 0.9938154) })
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, -0.0000268, 1.0000002, 0, 0, 0, 0.9814734, 0.1915998, 0, -0.1915998, 0.9814736) })
						I[6] = new("Pose", I[5], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1.0000002, 0, 0, 0, 0.9793179, 0.2023286, 0, -0.2023287, 0.9793181) })
							I[7] = new("Pose", I[6], "Bone.008", { CFrame = CFrame.new(0, -0.0000067, 0, 0.9732745, -0.2257605, 0.042067, 0.2257652, 0.9070996, -0.355248, 0.0420417, 0.355251, 0.9338257) })
							I[8] = new("Pose", I[6], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9837241, 0.17785, 0.0256306, -0.1778553, 0.9434211, 0.2798653, 0.0255934, -0.2798688, 0.9596975) })
					I[9] = new("Pose", I[4], "Bone.003", { Weight = 0 })
						I[10] = new("Pose", I[9], "Bone.004", { CFrame = CFrame.new(0.0000033, 0, 0, 0.9138756, -0.4059945, 0, 0.4059945, 0.9138756, 0, 0, 0, 1.0000002) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.8666667 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9999886, 0.0002622, 0.0047948, 0.0002622, 0.9940366, -0.1090473, -0.0047948, 0.1090473, 0.9940252) })
					I[14] = new("Pose", I[13], "Bone.001", { CFrame = CFrame.new(0, -0.0000067, -0.0000268, 1.0000002, 0, 0, 0, 0.973294, -0.2295631, 0, 0.2295631, 0.9732943) })
						I[15] = new("Pose", I[14], "Bone.002", { CFrame = CFrame.new(0, 0.0000067, 0, 1.0000002, 0, 0, 0, 0.9539878, 0.2998461, 0, -0.2998461, 0.953988) })
							I[16] = new("Pose", I[15], "Bone.008", { CFrame = CFrame.new(0, -0.0000134, 0, 0.9980509, 0.0609485, 0.0134225, -0.0623126, 0.9851378, 0.1600665, -0.0034673, -0.1605909, 0.9870155) })
							I[17] = new("Pose", I[15], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9986531, -0.05177, -0.0035479, 0.0515945, 0.9979188, -0.0386869, 0.0055434, 0.0384517, 0.9992453) })
					I[18] = new("Pose", I[13], "Bone.003", { Weight = 0 })
						I[19] = new("Pose", I[18], "Bone.004", { CFrame = CFrame.new(0.00001, 0, 0, 0.7066177, -0.7075956, 0, 0.7075956, 0.7066177, 0, 0, 0, 1.0000002) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1.6 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9999881, 0.0002714, -0.004878, 0.0002714, 0.9938271, 0.1109399, 0.004878, -0.1109399, 0.9938154) })
					I[23] = new("Pose", I[22], "Bone.001", { CFrame = CFrame.new(0, 0, -0.0000268, 1.0000002, 0, 0, 0, 0.9814734, 0.1915998, 0, -0.1915998, 0.9814736) })
						I[24] = new("Pose", I[23], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1.0000002, 0, 0, 0, 0.9793179, 0.2023286, 0, -0.2023287, 0.9793181) })
							I[25] = new("Pose", I[24], "Bone.008", { CFrame = CFrame.new(0, -0.0000067, 0, 0.9732745, -0.2257605, 0.042067, 0.2257652, 0.9070996, -0.355248, 0.0420417, 0.355251, 0.9338257) })
							I[26] = new("Pose", I[24], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9837241, 0.17785, 0.0256306, -0.1778553, 0.9434211, 0.2798653, 0.0255934, -0.2798688, 0.9596975) })
					I[27] = new("Pose", I[22], "Bone.003", { Weight = 0 })
						I[28] = new("Pose", I[27], "Bone.004", { CFrame = CFrame.new(0.0000033, 0, 0, 0.9138756, -0.4059945, 0, 0.4059945, 0.9138756, 0, 0, 0, 1.0000002) })
		I[29] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
