-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~3/Clip de animação sem título.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Clip de animação sem título", { Priority = Enum.AnimationPriority.Core }, nil, { "1786566555" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.984871, -0.061491, 0.1620129, -0.068137, 0.7222074, 0.6883122, -0.1593319, -0.6889378, 0.7070913) })
					I[6] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9848726, 0.061531, 0.1619885, 0.0680866, 0.7222282, -0.6882958, -0.1593442, 0.6889127, 0.7071133) })
					I[7] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0.0000109, 0.0000272, 0, 0.886562, 0.4400587, -0.1426758, -0.4400572, 0.7071069, -0.5534887, -0.1426804, 0.5534877, 0.8205453) })
					I[8] = new("Pose", I[4], "Bone.011", { CFrame = CFrame.new(0, 0.0000272, 0, 0.886562, -0.4400572, -0.1426805, 0.4400587, 0.7071069, 0.5534877, -0.1426758, -0.5534889, 0.8205452) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { Weight = 0 })
					I[12] = new("Pose", I[11], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9848818, -0.0679766, -0.1593337, -0.0615964, 0.7222548, -0.6888788, 0.1619072, 0.6882785, 0.7071484) })
					I[13] = new("Pose", I[11], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9848732, 0.0680835, -0.1593412, 0.0615281, 0.7222409, 0.6888998, 0.1619854, -0.6882828, 0.7071266) })
					I[14] = new("Pose", I[11], "Bone.008", { CFrame = CFrame.new(0.0000327, 0.0000599, 0.0000218, 0.8865603, -0.4400574, -0.14269, 0.4400564, 0.7070743, 0.5535311, -0.1426928, -0.5535304, 0.8205141) })
					I[15] = new("Pose", I[11], "Bone.011", { CFrame = CFrame.new(-0.0000109, 0.0000381, 0, 0.8865697, 0.4400446, -0.1426712, -0.4400446, 0.7071203, -0.5534815, -0.1426709, 0.5534816, 0.8205508) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.984871, -0.061491, 0.1620129, -0.068137, 0.7222074, 0.6883122, -0.1593319, -0.6889378, 0.7070913) })
					I[20] = new("Pose", I[18], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9848726, 0.061531, 0.1619885, 0.0680866, 0.7222282, -0.6882958, -0.1593442, 0.6889127, 0.7071133) })
					I[21] = new("Pose", I[18], "Bone.008", { CFrame = CFrame.new(0.0000109, 0.0000272, 0, 0.886562, 0.4400587, -0.1426758, -0.4400572, 0.7071069, -0.5534887, -0.1426804, 0.5534877, 0.8205453) })
					I[22] = new("Pose", I[18], "Bone.011", { CFrame = CFrame.new(0, 0.0000272, 0, 0.886562, -0.4400572, -0.1426805, 0.4400587, 0.7071069, 0.5534877, -0.1426758, -0.5534889, 0.8205452) })
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
