-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~10/Idle Quesadilha.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Quesadilha", { Priority = Enum.AnimationPriority.Core }, nil, { "1786645997" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.051", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961947, 0.0871557, 0, -0.0871557, 0.9961947) })
					I[5] = new("Pose", I[4], "Bone.L", { CFrame = CFrame.new(0, 0, 0, 0.5000001, 0.8660256, -0.0000199, -0.8660256, 0.5, 0.000032, 0.0000377, 0.0000013, 1.0000002) })
					I[6] = new("Pose", I[4], "Bone.R", { CFrame = CFrame.new(-0.0000044, 0.0000022, 0, 0.5000001, -0.8660256, 0.0000199, 0.8660256, 0.5, 0.000032, -0.0000377, 0.0000013, 1.0000002) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848085, -0.1736437, 0, 0.1736437, 0.9848085) })
					I[8] = new("Pose", I[4], "Bone.1.L", { CFrame = CFrame.new(0, 0, 0, 0.9999633, -0.0003722, -0.0085682, -0.0003724, 0.9962316, -0.0867336, 0.0085682, 0.0867335, 0.9961947) })
					I[9] = new("Pose", I[4], "Bone.1.R", { CFrame = CFrame.new(0, 0, 0, 0.9999633, 0.0003722, 0.0085682, 0.0003724, 0.9962316, -0.0867336, -0.0085682, 0.0867335, 0.9961947) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Cube.051", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, -0.0000579, 0, 0.0000579, 1) })
					I[13] = new("Pose", I[12], "Bone.L", { CFrame = CFrame.new(0, 0, 0, 0.6427519, 0.7660747, -0.0000191, -0.7660745, 0.6427518, 0.0000255, 0.0000318, -0.0000017, 1.0000002) })
					I[14] = new("Pose", I[12], "Bone.R", { CFrame = CFrame.new(-0.0000088, 0.0000044, 0, 0.6427519, -0.7660747, 0.0000191, 0.7660745, 0.6427518, 0.0000255, -0.0000318, -0.0000017, 1.0000002) })
					I[15] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0, 0, 0.0000088, 1, 0, 0, 0, 0.9990497, 0.0435852, 0, -0.0435852, 0.9990497) })
					I[16] = new("Pose", I[12], "Bone.1.L", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0.0000006, 0, 1.0000001, 0.0000058, -0.0000006, -0.0000059, 1) })
					I[17] = new("Pose", I[12], "Bone.1.R", { CFrame = CFrame.new(0, 0, 0, 1, 0, -0.0000006, 0, 1.0000001, 0.0000058, 0.0000006, -0.0000059, 1) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Cube.051", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961947, 0.0871557, 0, -0.0871557, 0.9961947) })
					I[21] = new("Pose", I[20], "Bone.L", { CFrame = CFrame.new(0, 0, 0, 0.5000001, 0.8660256, -0.0000199, -0.8660256, 0.5, 0.000032, 0.0000377, 0.0000013, 1.0000002) })
					I[22] = new("Pose", I[20], "Bone.R", { CFrame = CFrame.new(-0.0000044, 0.0000022, 0, 0.5000001, -0.8660256, 0.0000199, 0.8660256, 0.5, 0.000032, -0.0000377, 0.0000013, 1.0000002) })
					I[23] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848085, -0.1736437, 0, 0.1736437, 0.9848085) })
					I[24] = new("Pose", I[20], "Bone.1.L", { CFrame = CFrame.new(0, 0, 0, 0.9999633, -0.0003722, -0.0085682, -0.0003724, 0.9962316, -0.0867336, 0.0085682, 0.0867335, 0.9961947) })
					I[25] = new("Pose", I[20], "Bone.1.R", { CFrame = CFrame.new(0, 0, 0, 0.9999633, 0.0003722, 0.0085682, 0.0003724, 0.9962316, -0.0867336, -0.0085682, 0.0867335, 0.9961947) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
