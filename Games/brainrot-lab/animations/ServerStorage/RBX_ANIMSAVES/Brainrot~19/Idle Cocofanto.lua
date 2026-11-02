-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~19/Idle Cocofanto.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Cocofanto", { Priority = Enum.AnimationPriority.Core }, nil, { "1786653063" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.0555741, -0.8754396) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, -0.862135, -0.1619038, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[6] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0, -0.862135, -0.1618502, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[7] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, -0.0000268, 0.0000535, 0.9848077, 0.1575279, 0.0730662, -0.1575279, 0.9874976, -0.0057991, -0.0730662, -0.0057991, 0.9973104) })
					I[8] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, -0.8621483, -0.1617967, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[9] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(0, -0.8621216, -0.1618502, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, -0.0001606, 0) })
					I[13] = new("Pose", I[12], "Bone.010", { CFrame = CFrame.new(0, 0, -0.0001071, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[14] = new("Pose", I[12], "Bone.008", { CFrame = CFrame.new(0, 0, -0.0000535, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[15] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(0, -0.0000268, 0.0001071, 0.9848064, -0.157535, -0.0730694, 0.1575349, 0.9874966, -0.0057996, 0.0730694, -0.0057995, 0.9973102) })
					I[16] = new("Pose", I[12], "Bone.012", { CFrame = CFrame.new(0, -0.0000134, 0.0000535, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[17] = new("Pose", I[12], "Bone.014", { CFrame = CFrame.new(0, 0.0000268, -0.0000535, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, -0.0555741, -0.8754396) })
					I[21] = new("Pose", I[20], "Bone.010", { CFrame = CFrame.new(0, -0.862135, -0.1619038, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[22] = new("Pose", I[20], "Bone.008", { CFrame = CFrame.new(0, -0.862135, -0.1618502, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[23] = new("Pose", I[20], "Bone.003", { CFrame = CFrame.new(0, 0, 0.0001071, 0.9848077, 0.1575282, 0.0730663, -0.1575282, 0.9874976, -0.0057991, -0.0730663, -0.005799, 0.9973103) })
					I[24] = new("Pose", I[20], "Bone.012", { CFrame = CFrame.new(0, -0.8621483, -0.1617967, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[25] = new("Pose", I[20], "Bone.014", { CFrame = CFrame.new(0, -0.8621216, -0.1618502, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
