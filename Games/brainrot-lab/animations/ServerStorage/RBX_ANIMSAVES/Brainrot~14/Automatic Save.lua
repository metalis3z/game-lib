-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~14/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786648641" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[6] = new("Pose", I[5], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[8] = new("Pose", I[7], "Mesh", { Weight = 0 })
				I[9] = new("Pose", I[8], "Bone", { Weight = 0 })
					I[10] = new("Pose", I[9], "Bone.001", { Weight = 0 })
						I[11] = new("Pose", I[10], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848017, -0.1736824, 0, 0.1736824, 0.9848017) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[13] = new("Pose", I[12], "Mesh", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { Weight = 0 })
					I[15] = new("Pose", I[14], "Bone.001", { Weight = 0 })
						I[16] = new("Pose", I[15], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848017, 0.1736824, 0, -0.1736824, 0.9848017) })
		I[17] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
