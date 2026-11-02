-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~28/Idle Bicus Dicus.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Bicus Dicus", { Priority = Enum.AnimationPriority.Core }, nil, { "1786674798" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.2857154, 0) })
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, -0.0000027, -0.0000436, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077) })
					I[6] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.4225682, -0.9063312, 0, 0.9063312, 0.4225682, 0, 0, 0, 1.0000002) })
					I[7] = new("Pose", I[4], "Bone.007")
					I[8] = new("Pose", I[4], "Bone.011")
					I[9] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, -0.0000054, 0, 0.4225682, 0.9063312, -0.0000708, -0.9063312, 0.4225682, -0.0001105, -0.0000702, 0.0001108, 1.0000002) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, -0.0714302, 0) })
					I[13] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0, 0.0000027, -0.0000872, 1, 0, 0, 0, 0.9961941, 0.087163, 0, -0.087163, 0.9961941) })
					I[14] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(0.0000027, 0, 0, 0.1735656, -0.9848223, 0, 0.9848223, 0.1735656, 0, 0, 0, 1.0000002) })
					I[15] = new("Pose", I[12], "Bone.007", { CFrame = CFrame.new(0, 0.2142852, 0) })
					I[16] = new("Pose", I[12], "Bone.011", { CFrame = CFrame.new(0, 0.2142852, 0) })
					I[17] = new("Pose", I[12], "Bone.005", { CFrame = CFrame.new(-0.0000027, -0.0000054, 0, 0.1735657, 0.9848223, -0.0001012, -0.9848223, 0.1735656, -0.00012, -0.0001006, 0.0001205, 1.0000002) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, -0.2857154, 0) })
					I[21] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, -0.0000027, -0.0000436, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077) })
					I[22] = new("Pose", I[20], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.4225682, -0.9063312, 0, 0.9063312, 0.4225682, 0, 0, 0, 1.0000002) })
					I[23] = new("Pose", I[20], "Bone.007")
					I[24] = new("Pose", I[20], "Bone.011")
					I[25] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(0, -0.0000054, 0, 0.4225682, 0.9063312, -0.0000708, -0.9063312, 0.4225682, -0.0001105, -0.0000702, 0.0001108, 1.0000002) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
