-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~15/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", nil, nil, { "1786651990" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.0253296, -0.7138389) })
					I[5] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(-0.0000054, -0.7107544, -0.0709752, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[6] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(-0.0000054, -0.7107544, -0.0709316, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[7] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, -0.7107544, -0.0709752, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[8] = new("Pose", I[4], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961925, 0.0871797, 0, -0.0871797, 0.9961925) })
					I[9] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, -0.7107544, -0.0709316, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone")
					I[13] = new("Pose", I[12], "Bone.009", { CFrame = CFrame.new(-0.0000109, 0, -0.0000436, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[14] = new("Pose", I[12], "Bone.005", { CFrame = CFrame.new(-0.0000109, -0.0000109, 0.0000436, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[15] = new("Pose", I[12], "Bone.007", { CFrame = CFrame.new(0, 0, -0.0000436, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[16] = new("Pose", I[12], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961967, -0.0871317, 0, 0.0871317, 0.9961967) })
					I[17] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(0, -0.0000109, 0.0000436, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, -0.0253296, -0.7138389) })
					I[21] = new("Pose", I[20], "Bone.009", { CFrame = CFrame.new(-0.0000054, -0.7107544, -0.0709752, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[22] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(-0.0000054, -0.7107544, -0.0709316, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[23] = new("Pose", I[20], "Bone.007", { CFrame = CFrame.new(0, -0.7107544, -0.0709752, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
					I[24] = new("Pose", I[20], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961925, 0.0871797, 0, -0.0871797, 0.9961925) })
					I[25] = new("Pose", I[20], "Bone.003", { CFrame = CFrame.new(0, -0.7107544, -0.0709316, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000002) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
