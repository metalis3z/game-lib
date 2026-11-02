-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~23/Walk Gangster.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Gangster", { Priority = Enum.AnimationPriority.Core }, nil, { "1786668325" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9999999, 0, 0, 0, 0.9999999) })
					I[5] = new("Pose", I[4], "Bone.002")
						I[6] = new("Pose", I[5], "Bone.003")
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[8] = new("Pose", I[7], "Mesh", { Weight = 0 })
				I[9] = new("Pose", I[8], "Bone", { Weight = 0 })
					I[10] = new("Pose", I[9], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9993915, -0.0348796, 0, 0.0348796, 0.9993915) })
						I[11] = new("Pose", I[10], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.984808, -0.1736482, 0, 0.1736482, 0.984808) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[13] = new("Pose", I[12], "Mesh", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { CFrame = CFrame.new(0, 2.7082307, -2.349592, 1, 0, 0, 0, 0.9063114, 0.4226106, 0, -0.4226106, 0.9063114) })
					I[15] = new("Pose", I[14], "Bone.002", { Weight = 0 })
						I[16] = new("Pose", I[15], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.999848, 0.0174611, 0, -0.0174611, 0.999848) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[18] = new("Pose", I[17], "Mesh", { Weight = 0 })
				I[19] = new("Pose", I[18], "Bone", { CFrame = CFrame.new(0, -0.0740433, -1.1405292, 1, 0, 0, 0, 0.9762988, 0.2164272, 0, -0.2164272, 0.9762988) })
					I[20] = new("Pose", I[19], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396961, -0.3420109, 0, 0.3420109, 0.9396961) })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 0.7333333 })
			I[22] = new("Pose", I[21], "Mesh", { Weight = 0 })
				I[23] = new("Pose", I[22], "Bone", { CFrame = CFrame.new(0, -0.2775846, -4.2767334, 1, 0, 0, 0, 0.9999999, 0, 0, 0, 0.9999999) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[25] = new("Pose", I[24], "Mesh", { Weight = 0 })
				I[26] = new("Pose", I[25], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9999999, 0, 0, 0, 0.9999999) })
		I[27] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
