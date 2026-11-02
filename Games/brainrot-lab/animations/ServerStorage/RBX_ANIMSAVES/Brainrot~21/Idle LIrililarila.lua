-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~21/Idle LIrililarila.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle LIrililarila", nil, nil, { "1786654640" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0.6493457, -0.0010701, -0.000005, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
					I[5] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0.0117711, -0.6492417, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000005) })
					I[6] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0.0118107, -0.6492466, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000005) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(-0.0000396, 0.0000396, -0.0000149, 0.9659259, -0.2588191, 0.0000017, 0.2588191, 0.9659259, 0.0000001, -0.0000017, 0.0000004, 1.0000002) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[9] = new("Pose", I[8], "Mesh", { Weight = 0 })
				I[10] = new("Pose", I[9], "Bone", { CFrame = CFrame.new(-0.000005, 0, -0.0000149, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
					I[11] = new("Pose", I[10], "Bone.007", { CFrame = CFrame.new(-0.0000793, 0.0000198, 0.000005, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000005) })
					I[12] = new("Pose", I[10], "Bone.010", { CFrame = CFrame.new(0.0000396, 0.0000149, 0.000005, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000005) })
					I[13] = new("Pose", I[10], "Bone.001", { CFrame = CFrame.new(-0.0000793, 0.0000793, -0.0000149, 0.9848061, 0.1736584, -0.0000011, -0.1736584, 0.9848061, 0.0000002, 0.0000011, 0, 1.0000002) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { CFrame = CFrame.new(0.6493457, -0.0010701, -0.000005, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
					I[17] = new("Pose", I[16], "Bone.007", { CFrame = CFrame.new(0.0117711, -0.6492417, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000005) })
					I[18] = new("Pose", I[16], "Bone.010", { CFrame = CFrame.new(0.0118107, -0.6492466, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000005) })
					I[19] = new("Pose", I[16], "Bone.001", { CFrame = CFrame.new(-0.0000396, 0.0000396, -0.0000149, 0.9659259, -0.2588191, 0.0000017, 0.2588191, 0.9659259, 0.0000001, -0.0000017, 0.0000004, 1.0000002) })
		I[20] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
