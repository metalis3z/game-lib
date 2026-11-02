-- Generated from animations/Workspace/Ignored/SawedOff animation/AnimSaves/SawedOffAimFire.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "SawedOffAimFire", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.1549775, -0.1219346, -0.5208407, -0.24856, -0.8967334, 0.3661791, 0.9683995, -0.2380638, 0.0743506, 0.0205014, 0.3730882, 0.9275693) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.5971069, -0.6357422, -0.3790741, 0.3473529, 0.0802001, 0.9342986, -0.9070119, -0.2242091, 0.3564544, 0.2380659, -0.9712355, -0.0051372) })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000529, 0, 0.0000064, 0.989832, 0, 0.142241, 0, 1, 0, -0.142241, 0, 0.989832) })
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.9944426, 0.0015264, -0.5785167, -0.1874423, 0.8949684, -0.4048418, -0.9797728, -0.1409441, 0.1420563, 0.0700758, 0.4232804, 0.9032846) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(-0.2850952, -0.1219387, -0.5208435, -0.3278714, -0.8739177, 0.3588428, 0.9424846, -0.3287078, 0.0606122, 0.0649844, 0.3580769, 0.931428) })
						I[13] = new("Pose", I[12], "Handle", { CFrame = CFrame.new(-0.597168, -0.6357422, -0.3790894, 0.3399312, 0.1117279, 0.93379, -0.8838399, -0.3013377, 0.3578027, 0.3213626, -0.9469491, -0.0036845) })
					I[14] = new("Pose", I[11], "Head", { CFrame = CFrame.new(0.000061, 0, 0.0000057, 0.9659038, 0.0000324, 0.2589014, -0.0235641, 0.9958605, 0.0877879, -0.2578269, -0.0908955, 0.9619061) })
					I[15] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.8643188, 0.0015278, -0.5785217, -0.281657, 0.8820193, -0.3777713, -0.9594343, -0.2537764, 0.1228142, 0.012455, 0.3970382, 0.9177176) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[19] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.2850952, -0.1219387, -0.5208435, -0.3346324, -0.8728674, 0.3551389, 0.9392918, -0.339285, 0.0511536, 0.075843, 0.3506967, 0.9334129) })
						I[20] = new("Pose", I[19], "Handle", { CFrame = CFrame.new(-0.5971069, -0.6358032, -0.3789673, 0.3593576, 0.0483923, 0.9319445, -0.9196638, -0.1511126, 0.362469, 0.1583691, -0.9873315, -0.009799) })
					I[21] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0.000061, 0, 0.0000057, 0.9659085, 0.0000393, 0.2588837, -0.0417591, 0.9869283, 0.1556556, -0.2554935, -0.1611598, 0.9532841) })
					I[22] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-1.0845337, 0.0215359, -0.6484985, -0.4921972, 0.7908491, -0.3637303, -0.8696756, -0.4647548, 0.1663347, -0.0374998, 0.3981969, 0.9165331) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 0.3666667 })
			I[24] = new("Pose", I[23], "HumanoidRootPart", { Weight = 0 })
				I[25] = new("Pose", I[24], "Torso", { Weight = 0 })
					I[26] = new("Pose", I[25], "Right Arm", { CFrame = CFrame.new(-0.2850952, -0.1219387, -0.5208435, -0.3447918, -0.8670294, 0.3596923, 0.9375219, -0.2990595, 0.1778086, -0.0465959, 0.3985264, 0.9159725) })
						I[27] = new("Pose", I[26], "Handle", { CFrame = CFrame.new(-0.5971069, -0.6358032, -0.3787842, 0.34556, 0.0798923, 0.9349896, -0.9081092, -0.222626, 0.3546481, 0.2364866, -0.9716249, -0.0043796) })
					I[28] = new("Pose", I[25], "Head", { CFrame = CFrame.new(0.000061, 0, 0.0000057, 0.9659029, -0.0000427, 0.2589046, -0.0197125, 0.9970852, 0.0737063, -0.2581531, -0.0762968, 0.9630866) })
					I[29] = new("Pose", I[25], "Left Arm", { CFrame = CFrame.new(-0.8544922, -0.0284691, -0.6484985, -0.3060223, 0.8819024, -0.3586064, -0.9403473, -0.3388206, -0.0307843, -0.148652, 0.3277939, 0.9329811) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { Weight = 0 })
				I[32] = new("Pose", I[31], "Torso", { Weight = 0 })
					I[33] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(-0.1549775, -0.1219346, -0.5208407, -0.24856, -0.8967334, 0.3661791, 0.9683995, -0.2380638, 0.0743506, 0.0205014, 0.3730882, 0.9275693) })
						I[34] = new("Pose", I[33], "Handle", { CFrame = CFrame.new(-0.5971069, -0.6357422, -0.3790741, 0.3473529, 0.0802001, 0.9342986, -0.9070119, -0.2242091, 0.3564544, 0.2380659, -0.9712355, -0.0051372) })
					I[35] = new("Pose", I[32], "Head", { CFrame = CFrame.new(0.0000529, 0, 0.0000064, 0.989832, 0, 0.142241, 0, 1, 0, -0.142241, 0, 0.989832) })
					I[36] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(-0.9944426, 0.0015264, -0.5785167, -0.1874423, 0.8949684, -0.4048418, -0.9797728, -0.1409441, 0.1420563, 0.0700758, 0.4232804, 0.9032846) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[38] = new("Pose", I[37], "HumanoidRootPart", { Weight = 0 })
				I[39] = new("Pose", I[38], "Torso", { Weight = 0 })
					I[40] = new("Pose", I[39], "Right Arm", { CFrame = CFrame.new(-0.2850952, -0.1219349, -0.5208435, -0.2485055, -0.8967466, 0.366184, 0.9651621, -0.2612034, 0.0153332, 0.0818984, 0.3572373, 0.9304161) })
					I[41] = new("Pose", I[39], "Left Arm", { CFrame = CFrame.new(-0.8643188, 0.0015278, -0.5785217, -0.1874384, 0.8949503, -0.4048837, -0.9733605, -0.1138146, 0.1990365, 0.1320461, 0.4314048, 0.8924425) })
	return I[1]
end

return build
