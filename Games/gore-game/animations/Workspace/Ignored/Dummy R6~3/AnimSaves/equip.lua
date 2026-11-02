-- Generated from animations/Workspace/Ignored/Dummy R6~3/AnimSaves/equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "equip", { Loop = false, Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0565616, -0.1886244, 0.226322, -0.0444653, 0.1885439, -0.9810576, -0.7728341, -0.6287794, -0.0858137, -0.6330484, 0.754379, 0.173672) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9622566, 0.0871589, -0.2578094, -0.0841875, 0.9961944, 0.0225643, 0.258795, -0.0000083, 0.9659323) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(0.0498966, 0.3995235, 0.479379, -0.1445483, 0.1289597, -0.9810585, -0.272454, -0.9583335, -0.0858294, -0.9512492, 0.2548868, 0.1736605) })
						I[12] = new("Pose", I[11], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[13] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(0, 0.0000001, 0.0000001, 0.5517422, 0.736324, -0.3916726, -0.8172527, 0.5710052, -0.0777894, 0.1663688, 0.3630152, 0.9168105) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(0.3243047, 0.5030555, 0.3611365, -0.4139256, -0.0133841, -0.9102126, 0.0596083, -0.9981449, -0.0124301, -0.9083574, -0.0594013, 0.4139549) })
						I[18] = new("Pose", I[17], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.1282163, -0.4645854, -0.1331205, -0.2564589, 0.8531293, -0.4543119, -0.9291602, -0.3470827, -0.1272585, -0.2662518, 0.389492, 0.8817063) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { Weight = 0 })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.1756594, -0.3666213, -0.2259462, -0.6714362, -0.7370189, 0.0773072, 0.7008239, -0.6654214, -0.2570218, 0.2408718, -0.118395, 0.9633086) })
						I[24] = new("Pose", I[23], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[25] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-0.1793389, -0.405231, 0.0705555, -0.0198903, 0.6949989, -0.7187356, -0.999564, -0.0295146, -0.0008778, -0.0218233, 0.7184048, 0.6952829) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.3100023, -0.2077076, -0.2252314, 0.4163629, -0.8692943, 0.2664007, 0.8556338, 0.4737211, 0.2085165, -0.3074618, 0.1411229, 0.9410375) })
						I[30] = new("Pose", I[29], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.1878474, -0.3950728, 0.0667199, 0.1499251, 0.8316789, -0.5346332, -0.9866378, 0.1607375, -0.0266348, 0.063784, 0.5314826, 0.8446643) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { Weight = 0 })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.0822378, -0.3645491, -0.1923192, 0.269559, -0.9315693, 0.2439598, 0.9074697, 0.3305054, 0.2593545, -0.3222367, 0.1514748, 0.9344618) })
						I[36] = new("Pose", I[35], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[37] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-0.2014202, -0.3478624, 0.0411325, 0.0548363, 0.7803305, -0.6229584, -0.9762671, 0.1728121, 0.1305314, 0.2095124, 0.601016, 0.7712874) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { Weight = 0 })
					I[41] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.4031059, -0.1566882, -0.1645425, 0.3962002, -0.8893253, 0.228311, 0.859929, 0.4465636, 0.2471904, -0.3217881, 0.0983943, 0.9416852) })
					I[42] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(-0.1918572, -0.4225468, 0.0614992, 0.1226075, 0.7726026, -0.6229388, -0.9574785, 0.2572502, 0.1306038, 0.261156, 0.5804375, 0.7712911) })
	return I[1]
end

return build
