-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~47/Walk Cavallo Virtuosso.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Cavallo Virtuosso", { Priority = Enum.AnimationPriority.Core }, nil, { "1787508507" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, 0.2588191, 0, -0.2588191, 0.965926) })
					I[5] = new("Pose", I[4], "Bone.002", { Weight = 0 })
						I[6] = new("Pose", I[5], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660255, -0.5000001, 0, 0.5000001, 0.8660255) })
					I[7] = new("Pose", I[4], "Bone.009", { Weight = 0 })
						I[8] = new("Pose", I[7], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, -0.2588191, 0, 0.2588191, 0.965926) })
					I[9] = new("Pose", I[4], "Bone.007", { Weight = 0 })
						I[10] = new("Pose", I[9], "Bone.008", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, -0.2588191, 0, 0.2588191, 0.965926) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, -0.5714307, -2.8571429) })
					I[14] = new("Pose", I[13], "Bone.002", { Weight = 0 })
						I[15] = new("Pose", I[14], "Bone.003", { CFrame = CFrame.new(0, 0.0000218, 0, 1, 0, 0, 0, 0.9659249, 0.2588232, 0, -0.2588232, 0.9659249) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1.2 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, 0.2588191, 0, -0.2588191, 0.965926) })
					I[19] = new("Pose", I[18], "Bone.002", { Weight = 0 })
						I[20] = new("Pose", I[19], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660255, -0.5000001, 0, 0.5000001, 0.8660255) })
					I[21] = new("Pose", I[18], "Bone.009", { Weight = 0 })
						I[22] = new("Pose", I[21], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, -0.2588191, 0, 0.2588191, 0.965926) })
					I[23] = new("Pose", I[18], "Bone.007", { Weight = 0 })
						I[24] = new("Pose", I[23], "Bone.008", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.965926, -0.2588191, 0, 0.2588191, 0.965926) })
		I[25] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[26] = new("Pose", I[25], "Mesh", { Weight = 0 })
				I[27] = new("Pose", I[26], "Bone", { CFrame = CFrame.new(0, 2.8571429, -1.5238299, 1, 0, 0, 0, 0.9659317, 0.2587973, 0, -0.2587973, 0.9659317) })
					I[28] = new("Pose", I[27], "Bone.009", { Weight = 0 })
						I[29] = new("Pose", I[28], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660205, 0.5000086, 0, -0.5000086, 0.8660205) })
					I[30] = new("Pose", I[27], "Bone.007", { Weight = 0 })
						I[31] = new("Pose", I[30], "Bone.008", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660205, 0.5000086, 0, -0.5000086, 0.8660205) })
		I[32] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
