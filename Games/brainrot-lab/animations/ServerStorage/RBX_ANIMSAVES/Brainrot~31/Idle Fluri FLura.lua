-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~31/Idle Fluri FLura.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Fluri FLura", { Priority = Enum.AnimationPriority.Core }, nil, { "1787318781" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0.3508785, 0) })
					I[5] = new("Pose", I[4], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1556049, 0.0770767, -0.1556049, 0.987801, -0.0060427, -0.0770767, -0.0060427, 0.997007) })
						I[6] = new("Pose", I[5], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.9981818, 0.0542228, 0.0263294, -0.0599249, 0.9398317, 0.3363414, -0.0065079, -0.3373077, 0.941372) })
						I[7] = new("Pose", I[5], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.9981818, -0.0495602, -0.0343094, 0.0582256, 0.9400136, 0.3361314, 0.0155926, -0.3375178, 0.9411901) })
					I[8] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.4996919, 0.8662001, -0.0023329, -0.8363879, 0.4831909, 0.2588086, 0.2253072, -0.1273733, 0.9659261) })
						I[9] = new("Pose", I[8], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 1.0000002, -0.0000053, -0.0000007, 0.0000053, 0.965926, 0.2588191, -0.0000007, -0.2588191, 0.965926) })
					I[10] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, -0.0000067, 0, 0.4996919, -0.8662001, 0.0023329, 0.8363879, 0.4831909, 0.2588086, -0.2253072, -0.1273733, 0.9659261) })
						I[11] = new("Pose", I[10], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.965926, -0.2588191, 0, 0.2588191, 0.965926, 0, 0, 0, 1.0000002) })
					I[12] = new("Pose", I[4], "Bone.008")
					I[13] = new("Pose", I[4], "Bone.005")
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { Weight = 0 })
					I[17] = new("Pose", I[16], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9999323, 0.0104223, 0.0051625, -0.0108325, 0.9961384, 0.0871278, -0.0042345, -0.0871778, 0.9961838) })
						I[18] = new("Pose", I[17], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.998417, 0.0505895, 0.0245765, -0.0504614, 0.9987092, -0.0058052, -0.0248385, 0.0045559, 0.9996812) })
						I[19] = new("Pose", I[17], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.998417, -0.0462376, -0.0320217, 0.046071, 0.9989206, -0.0059229, 0.032261, 0.0044382, 0.9994698) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone")
					I[23] = new("Pose", I[22], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9848064, -0.1556119, -0.0770801, 0.1556119, 0.9877998, -0.0060432, 0.0770801, -0.0060432, 0.9970067) })
						I[24] = new("Pose", I[23], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.9999372, 0.0089245, 0.0067715, -0.0103343, 0.9681839, 0.2500265, -0.0043247, -0.2500807, 0.9682155) })
						I[25] = new("Pose", I[23], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.9996549, -0.0199045, -0.0171433, 0.0224744, 0.9858996, 0.1658229, 0.0136009, -0.1661509, 0.9860066) })
					I[26] = new("Pose", I[22], "Bone.001", { CFrame = CFrame.new(0, 0.0000067, 0, 0.9061815, -0.4228826, -0.0023329, 0.4079283, 0.8755642, -0.2588086, 0.1114882, 0.2335759, 0.9659261) })
					I[27] = new("Pose", I[22], "Bone.003", { CFrame = CFrame.new(-0.0000033, -0.0000067, 0, 0.906159, 0.4229307, 0.0023329, -0.4079748, 0.8755425, -0.2588086, -0.1115006, 0.2335699, 0.9659261) })
					I[28] = new("Pose", I[22], "Bone.008", { CFrame = CFrame.new(0, -0.3508785, 0) })
					I[29] = new("Pose", I[22], "Bone.005", { CFrame = CFrame.new(-0.0000134, -0.3508785, 0.0000535) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[31] = new("Pose", I[30], "Mesh", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9999323, 0.0104223, 0.0051625, -0.0108325, 0.9961384, 0.0871278, -0.0042345, -0.0871778, 0.9961838) })
						I[34] = new("Pose", I[33], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.9999655, 0.0061302, 0.0055835, -0.0060795, 0.9999403, -0.0090603, -0.0056388, 0.0090261, 0.9999435) })
						I[35] = new("Pose", I[33], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.9995409, -0.0227885, -0.0199673, 0.0296723, 0.8695471, 0.4929578, 0.0061288, -0.4933239, 0.8698242) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[37] = new("Pose", I[36], "Mesh", { Weight = 0 })
				I[38] = new("Pose", I[37], "Bone", { CFrame = CFrame.new(0, 0.3508785, 0) })
					I[39] = new("Pose", I[38], "Bone.011", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1556049, 0.0770767, -0.1556049, 0.987801, -0.0060427, -0.0770767, -0.0060427, 0.997007) })
						I[40] = new("Pose", I[39], "Bone.014", { CFrame = CFrame.new(0, 0, 0, 0.9981818, 0.0542228, 0.0263294, -0.0599249, 0.9398317, 0.3363414, -0.0065079, -0.3373077, 0.941372) })
						I[41] = new("Pose", I[39], "Bone.012", { CFrame = CFrame.new(0, 0, 0, 0.9981818, -0.0495602, -0.0343094, 0.0582256, 0.9400136, 0.3361314, 0.0155926, -0.3375178, 0.9411901) })
					I[42] = new("Pose", I[38], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.4996919, 0.8662001, -0.0023329, -0.8363879, 0.4831909, 0.2588086, 0.2253072, -0.1273733, 0.9659261) })
						I[43] = new("Pose", I[42], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 1.0000002, -0.0000053, -0.0000007, 0.0000053, 0.965926, 0.2588191, -0.0000007, -0.2588191, 0.965926) })
					I[44] = new("Pose", I[38], "Bone.001", { CFrame = CFrame.new(0, -0.0000067, 0, 0.4996919, -0.8662001, 0.0023329, 0.8363879, 0.4831909, 0.2588086, -0.2253072, -0.1273733, 0.9659261) })
						I[45] = new("Pose", I[44], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.965926, -0.2588191, 0, 0.2588191, 0.965926, 0, 0, 0, 1.0000002) })
					I[46] = new("Pose", I[38], "Bone.008")
					I[47] = new("Pose", I[38], "Bone.005")
		I[48] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
