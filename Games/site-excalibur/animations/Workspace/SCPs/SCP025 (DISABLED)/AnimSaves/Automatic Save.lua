-- Generated from animations/Workspace/SCPs/SCP025 (DISABLED)/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Movement }, nil, { "1617734562" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "RightLeg2")
					I[6] = new("Pose", I[4], "RightLeg1")
					I[7] = new("Pose", I[4], "Head")
					I[8] = new("Pose", I[4], "Tail")
					I[9] = new("Pose", I[4], "LeftLeg2")
					I[10] = new("Pose", I[4], "LeftLeg1")
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { Weight = 0 })
					I[14] = new("Pose", I[13], "RightLeg2", { CFrame = CFrame.new(0.0001795, -0.000309, 0.0000005, 0.7668703, -0.6418193, -0.0000041, 0.6418199, 0.7668699, -0.0000157, 0.0000136, 0.0000099, 1) })
					I[15] = new("Pose", I[13], "RightLeg1", { CFrame = CFrame.new(0.0000223, -0.0009412, -0.0000026, 0.9659897, -0.2586237, -0.0000005, 0.2586244, 0.9659892, -0.0000014, 0.0000011, 0.0000019, 1) })
					I[16] = new("Pose", I[13], "Head", { CFrame = CFrame.new(-0.0000684, 0.0000098, 0, 0.9398511, -0.0000002, -0.3415913, 0.0000002, 1.0000021, -0.0000002, 0.3415905, 0.0000003, 0.9398489) })
					I[17] = new("Pose", I[13], "Tail", { CFrame = CFrame.new(0.1645819, -0.0000424, -0.0947529, 0.7074561, 0.0000022, 0.7067572, 0.0000001, 1.0000021, -0.0000034, -0.706759, 0.0000026, 0.7074577) })
					I[18] = new("Pose", I[13], "LeftLeg2", { CFrame = CFrame.new(-0.0000039, -0.000055, -0.000001, 0.9660128, 0.2585388, -0.0000007, -0.2585383, 0.9660121, -0.000002, 0.0000003, 0.0000028, 1) })
					I[19] = new("Pose", I[13], "LeftLeg1", { CFrame = CFrame.new(-0.0001469, -0.0002339, -0.0000025, 0.6435869, 0.7654008, -0.0000034, -0.7654006, 0.643586, -0.0000122, -0.0000071, 0.0000117, 1) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { Weight = 0 })
					I[23] = new("Pose", I[22], "RightLeg2")
					I[24] = new("Pose", I[22], "RightLeg1")
					I[25] = new("Pose", I[22], "LeftLeg2")
					I[26] = new("Pose", I[22], "LeftLeg1")
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 })
				I[29] = new("Pose", I[28], "Torso", { Weight = 0 })
					I[30] = new("Pose", I[29], "RightLeg2", { CFrame = CFrame.new(0.0000058, -0.0001046, 0.0000001, 0.966002, 0.2585793, -0.0000006, -0.2585789, 0.9660012, -0.0000017, 0.0000003, 0.0000025, 1) })
					I[31] = new("Pose", I[29], "RightLeg1", { CFrame = CFrame.new(-0.0001866, -0.0003987, -0.0000024, 0.5012424, 0.8653199, -0.0000039, -0.8653198, 0.5012419, -0.0000142, -0.0000103, 0.000011, 1) })
					I[32] = new("Pose", I[29], "Head", { CFrame = CFrame.new(-0.0001636, 0.0000234, 0, 0.9398401, 0.0000004, 0.3416215, -0.0000003, 1.0000021, 0.0000002, -0.3416207, -0.0000002, 0.9398379) })
					I[33] = new("Pose", I[29], "Tail", { CFrame = CFrame.new(-0.2525903, -0.0000914, -0.0166805, 0.7073992, -0.0000032, -0.7068143, 0.0000047, 1.0000021, 0.0000004, 0.7068159, -0.0000035, 0.7074009) })
					I[34] = new("Pose", I[29], "LeftLeg2", { CFrame = CFrame.new(0.0003646, -0.0005337, -0.0000081, 0.7082537, -0.7059734, -0.0000056, 0.7059742, 0.7082533, -0.0000246, 0.0000216, 0.000014, 1) })
					I[35] = new("Pose", I[29], "LeftLeg1", { CFrame = CFrame.new(-0.0000177, -0.0001488, -0.0000028, 0.9659897, -0.2586237, -0.0000005, 0.2586244, 0.9659892, -0.0000014, 0.0000011, 0.0000019, 1) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { Weight = 0 })
					I[39] = new("Pose", I[38], "RightLeg2")
					I[40] = new("Pose", I[38], "RightLeg1")
					I[41] = new("Pose", I[38], "Head", { CFrame = CFrame.new(-0.000262, 0.0000374, 0, 1.0000024, 0.0000001, 0, 0.0000001, 1.0000021, 0.0000001, 0, 0.0000001, 1) })
					I[42] = new("Pose", I[38], "Tail")
					I[43] = new("Pose", I[38], "LeftLeg2")
					I[44] = new("Pose", I[38], "LeftLeg1")
	return I[1]
end

return build
