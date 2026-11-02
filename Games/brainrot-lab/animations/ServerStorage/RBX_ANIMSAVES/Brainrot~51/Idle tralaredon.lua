-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~51/Idle tralaredon.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle tralaredon", { Priority = Enum.AnimationPriority.Core }, nil, { "1787511268" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.009", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.1283046, -0.8474841, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[5] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(0.0000054, 0, -0.0000218, 1, 0, 0, 0, 0.965926, 0.2588191, 0, -0.2588191, 0.965926) })
					I[6] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.743687, -0.6588486, -0.1133523, 0.5987154, 0.7318196, -0.3255458, 0.2974387, 0.1742384, 0.9387074) })
					I[7] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, 0.0000436, 0.0000109, 1, 0, 0, 0, 0.9659259, 0.2588188, 0, -0.2588188, 0.9659259) })
					I[8] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0.0000436, 0, 0, 0.7175502, 0.6793908, 0.1534595, -0.6472691, 0.7318067, -0.2133113, -0.2572244, 0.053732, 0.9648569) })
				I[9] = new("Pose", I[3], "Bone.004", { CFrame = CFrame.new(0, -0.6131418, 0.5989293) })
				I[10] = new("Pose", I[3], "Bone.002", { CFrame = CFrame.new(0, 0.1298305, 0.8472443, 0.9961947, -0.0861496, 0.0132046, 0.0861496, 0.996282, 0.0005699, -0.0132046, 0.0005699, 0.9999126) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[12] = new("Pose", I[11], "Cube.009", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, -0.1283046, -0.8474841, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[14] = new("Pose", I[13], "Bone.009", { CFrame = CFrame.new(0.0000054, 0, -0.0000218, 1, 0, 0, 0, 0.965926, 0.2588191, 0, -0.2588191, 0.965926) })
					I[15] = new("Pose", I[13], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.743687, -0.6588486, -0.1133523, 0.5987154, 0.7318196, -0.3255458, 0.2974387, 0.1742384, 0.9387074) })
					I[16] = new("Pose", I[13], "Bone.003", { CFrame = CFrame.new(0, 0.0000436, 0.0000109, 1, 0, 0, 0, 0.9659259, 0.2588188, 0, -0.2588188, 0.9659259) })
					I[17] = new("Pose", I[13], "Bone.005", { CFrame = CFrame.new(0.0000436, 0, 0, 0.7175502, 0.6793908, 0.1534595, -0.6472691, 0.7318067, -0.2133113, -0.2572244, 0.053732, 0.9648569) })
				I[18] = new("Pose", I[12], "Bone.004", { CFrame = CFrame.new(0, -0.6131418, 0.5989293) })
				I[19] = new("Pose", I[12], "Bone.002", { CFrame = CFrame.new(0, 0.1298305, 0.8472443, 0.9961947, -0.0861496, 0.0132046, 0.0861496, 0.996282, 0.0005699, -0.0132046, 0.0005699, 0.9999126) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[21] = new("Pose", I[20], "Cube.009", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, -0.0427682, -0.2824947, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[23] = new("Pose", I[22], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9701783, -0.233661, -0.0644749, 0.2266644, 0.9687976, -0.1002741, 0.0858932, 0.0826696, 0.9928688) })
					I[24] = new("Pose", I[22], "Bone.003", { CFrame = CFrame.new(0, 0.0000872, 0.0000218, 1, 0, 0, 0, 0.9659232, -0.2588288, 0, 0.2588288, 0.9659232) })
					I[25] = new("Pose", I[22], "Bone.005", { CFrame = CFrame.new(0.0000436, 0.0000218, 0, 0.967136, 0.2446817, 0.0691291, -0.2409443, 0.9687948, -0.0581596, -0.0812025, 0.039592, 0.9959112) })
				I[26] = new("Pose", I[21], "Bone.004", { CFrame = CFrame.new(0, -0.2044242, 0.199585, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077) })
				I[27] = new("Pose", I[21], "Bone.002", { CFrame = CFrame.new(0, 0.0432914, 0.2824102, 0.9848077, 0.1716437, -0.0263086, -0.1716437, 0.9851564, 0.0022751, 0.0263086, 0.0022752, 0.9996513) })
		I[28] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
