-- Generated from animations/ReplicatedStorage/Items/Normal/BlueberrinniOctopusini/Model/Brainrot/AnimSaves/Idle_Walk.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle/Walk", nil, nil, { "1787409758" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.5, 0) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0.000061, 0, 0) })
					I[6] = new("Pose", I[4], "Bone.001")
					I[7] = new("Pose", I[4], "Bone.004")
					I[8] = new("Pose", I[4], "Bone.016", { CFrame = CFrame.new(0, -0.000061, -0.000061) })
					I[9] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(-0.0001221, -0.000061, 0.0000305) })
					I[10] = new("Pose", I[4], "Bone.013", { CFrame = CFrame.new(-0.0001221, 0.000061, 0) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, 2.3999996, 0) })
					I[14] = new("Pose", I[13], "Bone.010", { CFrame = CFrame.new(0.000061, 0.000061, 0, 0.8660073, 0.5000314, 0, -0.5000314, 0.8660073, 0, 0, 0, 1) })
					I[15] = new("Pose", I[13], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.8660073, -0.5000314, 0, 0.5000314, 0.8660073, 0, 0, 0, 1) })
					I[16] = new("Pose", I[13], "Bone.004", { CFrame = CFrame.new(0.1117554, 0.2174683, 0.0000305, 0.8660073, -0.5000314, 0, 0.5000314, 0.8660073, 0, 0, 0, 1) })
					I[17] = new("Pose", I[13], "Bone.016", { CFrame = CFrame.new(0, 0.0000305, 0, 1, 0, 0, 0, 0.8660073, 0.5000314, 0, -0.5000314, 0.8660073) })
					I[18] = new("Pose", I[13], "Bone.007", { CFrame = CFrame.new(0.000061, 0, 0.0000305, 0.8660073, -0.5000314, 0, 0.5000314, 0.8660073, 0, 0, 0, 1) })
					I[19] = new("Pose", I[13], "Bone.013", { CFrame = CFrame.new(0, 0, 0.0000916, 1, 0, 0, 0, 0.8660073, -0.5000314, 0, 0.5000314, 0.8660073) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.5666667 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, 2.3999996, 0) })
					I[23] = new("Pose", I[22], "Bone.010", { CFrame = CFrame.new(0.0001221, 0.000061, 0, 0.8191557, 0.5735713, 0, -0.5735713, 0.8191557, 0, 0, 0, 1) })
					I[24] = new("Pose", I[22], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.8191557, -0.5735713, 0, 0.5735713, 0.8191557, 0, 0, 0, 1) })
					I[25] = new("Pose", I[22], "Bone.004", { CFrame = CFrame.new(0.1118774, 0.2175598, 0.0000916, 0.8191557, -0.5735713, 0, 0.5735713, 0.8191557, 0, 0, 0, 1) })
					I[26] = new("Pose", I[22], "Bone.016", { CFrame = CFrame.new(-0.000061, 0.000061, 0, 1, 0, 0, 0, 0.8191557, 0.5735713, 0, -0.5735713, 0.8191557) })
					I[27] = new("Pose", I[22], "Bone.007", { CFrame = CFrame.new(0.0001221, -0.0000305, -0.000061, 0.8660195, -0.4981048, -0.0436101, 0.5000102, 0.8627262, 0.0754539, 0.0000397, -0.0871501, 0.9961952) })
					I[28] = new("Pose", I[22], "Bone.013", { CFrame = CFrame.new(0, 0, 0.0001221, 1, 0, 0, 0, 0.7660612, -0.6427676, 0, 0.6427676, 0.7660612) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.7679167 })
			I[30] = new("Pose", I[29], "Mesh", { Weight = 0 })
				I[31] = new("Pose", I[30], "Bone", { CFrame = CFrame.new(0, -0.5, 0) })
					I[32] = new("Pose", I[31], "Bone.010", { CFrame = CFrame.new(0.000061, 0, 0) })
					I[33] = new("Pose", I[31], "Bone.001")
					I[34] = new("Pose", I[31], "Bone.004")
					I[35] = new("Pose", I[31], "Bone.016", { CFrame = CFrame.new(0, -0.000061, -0.000061) })
					I[36] = new("Pose", I[31], "Bone.007", { CFrame = CFrame.new(-0.0001221, -0.000061, 0.0000305) })
					I[37] = new("Pose", I[31], "Bone.013", { CFrame = CFrame.new(-0.0001221, 0.000061, 0) })
		I[38] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
