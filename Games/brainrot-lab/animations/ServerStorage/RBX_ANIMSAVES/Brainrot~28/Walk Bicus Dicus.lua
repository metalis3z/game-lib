-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~28/Walk Bicus Dicus.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Bicus Dicus", { Priority = Enum.AnimationPriority.Core }, nil, { "1786674590" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0.0000027, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848077, -0.1710103, -0.0301524, 0.1710103, 0.9852659, -0.0025979, 0.0301524, -0.0025979, 0.999542) })
					I[6] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, 0.0000054, 0, 0.418889, 0.9080206, 0.0055364, -0.9070067, 0.4186962, -0.04508, -0.0432517, 0.0138619, 0.9989682) })
					I[7] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0, -0.0000109, 0, 0.9292489, 0.3587576, -0.0882587, -0.3587576, 0.8191505, -0.4475331, -0.0882588, 0.4475331, 0.8899016) })
					I[8] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0.0000109, 0, 0, 0.5701917, -0.8214926, -0.0056075, 0.8205306, 0.569831, -0.0449695, 0.0401375, 0.0210401, 0.9989729) })
					I[9] = new("Pose", I[4], "Bone.011", { CFrame = CFrame.new(0, -0.0000109, 0, 0.9985112, -0.0545185, -0.0018574, 0.0545184, 0.9961941, 0.0680091, -0.0018574, -0.0680091, 0.9976831) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0.0000054, 0, 1, 0, 0, 0, 0.9961916, -0.0871904, 0, 0.0871904, 0.9961916) })
					I[13] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0, -0.0000027, 0, 0.9827825, 0.1750849, -0.0590238, -0.1746151, 0.98455, 0.0130664, 0.0603997, -0.0025349, 0.998171) })
					I[14] = new("Pose", I[12], "Bone.005", { CFrame = CFrame.new(0, 0.0000054, 0, 0.1292705, 0.9916011, -0.0040497, -0.9909326, 0.1290303, -0.037469, -0.0366318, 0.0088567, 0.9992898) })
					I[15] = new("Pose", I[12], "Bone.007", { CFrame = CFrame.new(0, -0.0000054, 0, 0.9633437, -0.2643445, -0.045727, 0.2643445, 0.9063013, 0.3297572, -0.0457271, -0.3297572, 0.9429578) })
					I[16] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(0.0000054, 0, 0, 0.2155834, -0.9764563, 0.0075473, 0.9755892, 0.2150481, -0.0444994, 0.0418287, 0.0169564, 0.9989811) })
					I[17] = new("Pose", I[12], "Bone.011", { CFrame = CFrame.new(0, -0.0000082, 0, 0.9866707, 0.1618786, -0.0166278, -0.1618786, 0.9659281, -0.2019359, -0.0166278, 0.2019359, 0.9792577) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, 0.0000027, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
					I[21] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848077, -0.1710103, -0.0301524, 0.1710103, 0.9852659, -0.0025979, 0.0301524, -0.0025979, 0.999542) })
					I[22] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(0, 0.0000054, 0, 0.418889, 0.9080206, 0.0055364, -0.9070067, 0.4186962, -0.04508, -0.0432517, 0.0138619, 0.9989682) })
					I[23] = new("Pose", I[20], "Bone.007", { CFrame = CFrame.new(0, -0.0000109, 0, 0.9292489, 0.3587576, -0.0882587, -0.3587576, 0.8191505, -0.4475331, -0.0882588, 0.4475331, 0.8899016) })
					I[24] = new("Pose", I[20], "Bone.003", { CFrame = CFrame.new(0.0000109, 0, 0, 0.5701917, -0.8214926, -0.0056075, 0.8205306, 0.569831, -0.0449695, 0.0401375, 0.0210401, 0.9989729) })
					I[25] = new("Pose", I[20], "Bone.011", { CFrame = CFrame.new(0, -0.0000109, 0, 0.9985112, -0.0545185, -0.0018574, 0.0545184, 0.9961941, 0.0680091, -0.0018574, -0.0680091, 0.9976831) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[27] = new("Pose", I[26], "Mesh", { Weight = 0 })
				I[28] = new("Pose", I[27], "Bone", { Weight = 0 })
					I[29] = new("Pose", I[28], "Bone.007", { CFrame = CFrame.new(-0.0069972, -0.2139936, -0.0087629, 0.9970846, 0.0762186, -0.0036369, -0.0762186, 0.9925476, -0.0950792, -0.003637, 0.0950792, 0.9954631) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.011", { CFrame = CFrame.new(-0.0031172, -0.1427787, -0.0038801, 0.9980887, 0.061752, -0.0023843, -0.061752, 0.9951144, -0.0770328, -0.0023843, 0.0770328, 0.9970258) })
		I[34] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
