-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~32/Idle TRICK TRACK.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle TRICK TRACK", { Priority = Enum.AnimationPriority.Core }, nil, { "1786751271" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.064", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0.142855, 0) })
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, -0.0657, -0.027771, 1, 0, 0, 0, 0.984814, -0.173614, 0, 0.173614, 0.984814) })
					I[6] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(-0.0026267, 0.357072, 0.0065831, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000001) })
					I[7] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0.0026212, 0.3570611, 0.0064959, 1, 0, 0, 0, 1, 0, 0, 0, 0.9999998) })
					I[8] = new("Pose", I[4], "Bone.006", { CFrame = CFrame.new(0.0000054, 0, 0, 0.9848077, -0.1489165, 0.0893172, 0.1489165, 0.988827, 0.0067013, -0.0893172, 0.0067013, 0.9959807) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Cube.064", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone")
					I[12] = new("Pose", I[11], "Bone.001", { CFrame = CFrame.new(0, -0.0657436, -0.027771, 1, 0, 0, 0, 0.984814, 0.173614, 0, -0.173614, 0.984814) })
					I[13] = new("Pose", I[11], "Bone.004", { CFrame = CFrame.new(-0.001564, 0.2142389, 0.0039673, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000001) })
					I[14] = new("Pose", I[11], "Bone.002", { CFrame = CFrame.new(0.0015804, 0.2142334, 0.0038801, 1, 0, 0, 0, 1, 0, 0, 0, 0.9999998) })
					I[15] = new("Pose", I[11], "Bone.006", { CFrame = CFrame.new(0.0000109, 0, 0, 0.9848065, 0.1489227, -0.0893208, -0.1489227, 0.9888262, 0.0067019, 0.0893208, 0.0067019, 0.9959804) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Cube.064", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, 0.142855, 0) })
					I[19] = new("Pose", I[18], "Bone.001", { CFrame = CFrame.new(0, -0.0657, -0.027771, 1, 0, 0, 0, 0.984814, -0.173614, 0, 0.173614, 0.984814) })
					I[20] = new("Pose", I[18], "Bone.004", { CFrame = CFrame.new(-0.0026267, 0.357072, 0.0065831, 1, 0, 0, 0, 1.0000002, 0, 0, 0, 1.0000001) })
					I[21] = new("Pose", I[18], "Bone.002", { CFrame = CFrame.new(0.0026212, 0.3570611, 0.0064959, 1, 0, 0, 0, 1, 0, 0, 0, 0.9999998) })
					I[22] = new("Pose", I[18], "Bone.006", { CFrame = CFrame.new(0.0000109, 0, 0, 0.9848077, -0.1489169, 0.0893173, 0.1489169, 0.988827, 0.0067013, -0.0893173, 0.0067014, 0.9959807) })
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
