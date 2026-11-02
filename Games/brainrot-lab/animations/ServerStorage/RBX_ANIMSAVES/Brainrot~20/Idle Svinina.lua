-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~20/Idle Svinina.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Svinina", { Priority = Enum.AnimationPriority.Core }, nil, { "1786654081" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.001", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.0261143, -0.7138116) })
					I[5] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(0, -0.7142313, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[6] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, -0.0000218, 0.0000218, 1, 0, 0, 0, 0.9659258, 0.258819, 0, -0.258819, 0.9659258) })
					I[7] = new("Pose", I[4], "Bone.016", { CFrame = CFrame.new(0, -0.7142367, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[8] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, -0.7142313, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[9] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, -0.7142367, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Cube.001", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, -0.0000436, -0.0000027) })
					I[13] = new("Pose", I[12], "Bone.014", { CFrame = CFrame.new(0, 0.0000163, -0.0000436, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[14] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0, -0.0000436, 0.0000436, 1, 0, 0, 0, 0.9961939, -0.0871651, 0, 0.0871651, 0.9961939) })
					I[15] = new("Pose", I[12], "Bone.016", { CFrame = CFrame.new(0, 0.0000109, -0.0000436, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[16] = new("Pose", I[12], "Bone.012", { CFrame = CFrame.new(0, 0.0000163, -0.0000436, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[17] = new("Pose", I[12], "Bone.010", { CFrame = CFrame.new(0, 0.0000109, -0.0000436, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Cube.001", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, -0.0261143, -0.7138116) })
					I[21] = new("Pose", I[20], "Bone.014", { CFrame = CFrame.new(0, -0.7142313, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[22] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, -0.0000218, 0.0000218, 1, 0, 0, 0, 0.9659258, 0.258819, 0, -0.258819, 0.9659258) })
					I[23] = new("Pose", I[20], "Bone.016", { CFrame = CFrame.new(0, -0.7142367, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[24] = new("Pose", I[20], "Bone.012", { CFrame = CFrame.new(0, -0.7142313, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[25] = new("Pose", I[20], "Bone.010", { CFrame = CFrame.new(0, -0.7142367, -0.0072806, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
