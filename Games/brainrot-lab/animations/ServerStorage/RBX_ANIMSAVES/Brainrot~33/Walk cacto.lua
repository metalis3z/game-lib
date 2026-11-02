-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~33/Walk cacto.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk cacto", { Priority = Enum.AnimationPriority.Core }, nil, { "1786752313" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077) })
					I[5] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0.6171962, -1.5992955, -0.0000272, 0.9980341, 0.0050943, -0.0624671, 0.0050992, 0.9867867, 0.161945, 0.0624667, -0.1619452, 0.9848209) })
					I[6] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[7] = new("Pose", I[6], "Bone.006", { CFrame = CFrame.new(0, 0.0000054, 0.0000436, 0.9850385, 0.1711837, -0.0198828, -0.1715727, 0.9849718, -0.0198428, 0.0161872, 0.0229573, 0.9996056) })
						I[8] = new("Pose", I[6], "Bone.005", { CFrame = CFrame.new(0, 0.0000054, 0.0000436, 0.9850529, -0.1710945, 0.0199445, 0.1714956, 0.9849718, -0.0204933, -0.0161385, 0.0236073, 0.9995911) })
					I[9] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0.0000109, 0.0000872, -0.0000109, 1, 0, 0.0000066, 0, 1.0000001, 0.000017, -0.0000066, -0.000017, 1.0000001) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { Weight = 0 })
					I[13] = new("Pose", I[12], "Bone.008", { CFrame = CFrame.new(0.3291975, -0.8530099, 0.4285485, 0.9977622, 0.0058003, -0.0666122, 0.0058004, 0.9849664, 0.1726488, 0.0666122, -0.1726488, 0.9827287) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0.0000073, 0, -0.0000073, 1) })
					I[17] = new("Pose", I[16], "Bone.008", { CFrame = CFrame.new(0, 0, -0.0000109, 1, 0, 0.0000037, 0, 1.0000001, -0.0000096, -0.0000037, 0.0000096, 1.0000002) })
					I[18] = new("Pose", I[16], "Bone.001", { Weight = 0 })
						I[19] = new("Pose", I[18], "Bone.006", { CFrame = CFrame.new(0.0000054, 0.0000054, 0.0000436, 0.9998488, -0.0024759, -0.0172166, 0.0020462, 0.9996874, -0.024926, 0.0172729, 0.024887, 0.9995412) })
						I[20] = new("Pose", I[18], "Bone.005", { CFrame = CFrame.new(-0.0000031, 0, 0.0000436, 0.9998486, 0.002571, 0.0172155, -0.0021416, 0.9996871, -0.024918, -0.0172742, 0.0248773, 0.9995412) })
					I[21] = new("Pose", I[16], "Bone.007", { CFrame = CFrame.new(-0.5400522, -1.3994054, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[23] = new("Pose", I[22], "Mesh", { Weight = 0 })
				I[24] = new("Pose", I[23], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077) })
					I[25] = new("Pose", I[24], "Bone.008", { CFrame = CFrame.new(0.6171962, -1.5992955, -0.0000272, 0.9980341, 0.0050943, -0.0624671, 0.0050992, 0.9867867, 0.161945, 0.0624667, -0.1619452, 0.9848209) })
					I[26] = new("Pose", I[24], "Bone.001", { Weight = 0 })
						I[27] = new("Pose", I[26], "Bone.006", { CFrame = CFrame.new(0, 0.0000054, 0.0000436, 0.9850385, 0.1711837, -0.0198828, -0.1715727, 0.9849718, -0.0198428, 0.0161872, 0.0229573, 0.9996056) })
						I[28] = new("Pose", I[26], "Bone.005", { CFrame = CFrame.new(0, 0.0000054, 0.0000436, 0.9850529, -0.1710945, 0.0199445, 0.1714956, 0.9849718, -0.0204933, -0.0161385, 0.0236073, 0.9995911) })
					I[29] = new("Pose", I[24], "Bone.007", { CFrame = CFrame.new(0.0000109, 0.0000872, -0.0000109, 1, 0, 0.0000066, 0, 1.0000001, 0.000017, -0.0000066, -0.000017, 1.0000001) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.007", { CFrame = CFrame.new(-0.2520425, -0.6530762, 0.4285649, 0.9977612, -0.0058025, -0.0666245, -0.0058025, 0.9849607, -0.1726808, 0.0666245, 0.1726808, 0.9827222) })
		I[34] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
