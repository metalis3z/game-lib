-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~11/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", nil, nil, { "1786651768" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961947, 0.0871558, 0, -0.0871558, 0.9961947) })
					I[5] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[6] = new("Pose", I[5], "Bone.002", { CFrame = CFrame.new(0, -0.4300034, 0.7645992) })
							I[7] = new("Pose", I[6], "Bone.003", { Weight = 0 })
								I[8] = new("Pose", I[7], "Bone.004", { CFrame = CFrame.new(0, 0.0285366, 0.8767245, 0.9961947, -0.0047601, 0.0870256, 0.0047601, 0.9999884, 0.0002075, -0.0870256, 0.0002075, 0.9962059) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { Weight = 0 })
					I[12] = new("Pose", I[11], "Bone.001", { Weight = 0 })
						I[13] = new("Pose", I[12], "Bone.002", { CFrame = CFrame.new(0, 0.0000268, 0.0000268) })
							I[14] = new("Pose", I[13], "Bone.003", { Weight = 0 })
								I[15] = new("Pose", I[14], "Bone.004", { CFrame = CFrame.new(0, -0.0001071, 0.0000067, 0.9961953, 0.0047598, -0.0870198, -0.0047598, 0.9999884, 0.0002075, 0.0870197, 0.0002075, 0.9962064) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.001", { Weight = 0 })
						I[20] = new("Pose", I[19], "Bone.002", { CFrame = CFrame.new(0, -0.4299766, 0.764626) })
							I[21] = new("Pose", I[20], "Bone.003", { Weight = 0 })
								I[22] = new("Pose", I[21], "Bone.004", { CFrame = CFrame.new(0, 0.0285366, 0.8767111, 0.9961947, 0.0047601, -0.0870256, -0.0047601, 0.9999884, 0.0002075, 0.0870256, 0.0002075, 0.9962059) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[24] = new("Pose", I[23], "Mesh", { Weight = 0 })
				I[25] = new("Pose", I[24], "Bone", { Weight = 0 })
					I[26] = new("Pose", I[25], "Bone.001", { Weight = 0 })
						I[27] = new("Pose", I[26], "Bone.002", { CFrame = CFrame.new(0, 0.0000268, 0.0000268) })
							I[28] = new("Pose", I[27], "Bone.003", { Weight = 0 })
								I[29] = new("Pose", I[28], "Bone.004", { CFrame = CFrame.new(0, -0.0001071, 0.0000067, 0.9961947, -0.0047601, 0.0870256, 0.0047601, 0.9999884, 0.0002075, -0.0870256, 0.0002075, 0.9962059) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.001", { Weight = 0 })
						I[34] = new("Pose", I[33], "Bone.002", { CFrame = CFrame.new(0, -0.4299766, 0.764626) })
							I[35] = new("Pose", I[34], "Bone.003", { Weight = 0 })
								I[36] = new("Pose", I[35], "Bone.004", { CFrame = CFrame.new(0, 0.0285366, 0.8766978, 0.9961953, -0.0047598, 0.0870198, 0.0047598, 0.9999884, 0.0002075, -0.0870197, 0.0002075, 0.9962064) })
		I[37] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
