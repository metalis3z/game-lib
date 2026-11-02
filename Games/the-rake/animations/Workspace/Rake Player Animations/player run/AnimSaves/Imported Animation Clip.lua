-- Generated from animations/Workspace/Rake Player Animations/player run/AnimSaves/Imported Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Imported Animation Clip", { Priority = Enum.AnimationPriority.Movement }, nil, { "1581720078" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.0000019, -0.0000002, 0.9998477, -0.0015211, -0.017386, -0.0064437, 0.8936321, -0.4487541, 0.0162192, 0.4487978, 0.8934861), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.3629397, -0.1679593, 0, 0.2756377, -0.9612616, 0, 0.9612616, 0.2756377, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.3060911, -0.2967424, 0.000061, 0.1564351, -0.9876883, 0, 0.9876882, 0.1564351, 0, 0, 0, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.4344591, 0.153643, 0.0056334, 0.6078568, -0.7937518, -0.0216368, 0.7935244, 0.6082194, -0.0196938, 0.0287919, -0.0051983, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.6493769, -0.2858835, -0.0382065, -0.837382, -0.4853627, 0.2514251, 0.5455774, -0.7704978, 0.3296639, 0.0337159, 0.4132265, 0.9100039), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.0000019, -0.1999993, 1, 0, 0, 0, 0.8936269, -0.4488105, 0, 0.4488105, 0.8936269), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-1.2445674, 0.6537061, -0.0000048, 0.7660444, -0.6427876, 0, 0.6427876, 0.7660444, 0, 0, 0, 1) })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.1961452, -0.0671122, 0, 0.9713609, 0.2376088, 0, -0.2376088, 0.9713609, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.1150979, -0.0894201, 0.0048119, 0.7968819, 0.5744653, -0.1869996, -0.5527226, 0.8182141, 0.1581873, 0.2438788, -0.0226977, 0.9695401), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(-0.1625529, -0.039471, 0.0144454, 0.843375, -0.5037462, 0.1869717, 0.4778074, 0.8622686, 0.1679067, -0.2458022, -0.0522718, 0.9679096), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9998477, 0.0015211, 0.017386, 0.0064437, 0.8936321, -0.4487542, -0.0162192, 0.4487979, 0.8934861), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.4555914, -0.3340148, -0.0000458, 0.0697567, 0.9975641, 0, -0.997564, 0.0697566, 0, 0, 0, 1) })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(-0.3754289, -0.135409, 0, 0.2756377, 0.9612616, 0, -0.9612616, 0.2756377, 0, 0, 0, 1) })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.6727071, -0.3563443, -0.0373637, -0.837387, 0.4853562, -0.2514214, -0.54557, -0.7705023, 0.329666, -0.0337154, 0.413226, 0.9100042), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(-0.4344478, 0.1536844, 0.0056563, 0.6078575, 0.7937514, 0.0216368, -0.7935239, 0.6082201, -0.0196939, -0.028792, -0.0051982, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, -0.0000019, -0.1999993, 1, 0, 0, 0, 0.8936269, -0.4488105, 0, 0.4488105, 0.8936269), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(-0.1737757, -0.0615391, 0, 0.9713609, -0.2376089, 0, 0.2376089, 0.9713609, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(1.1054657, 0.4879254, -0.0000048, 0.7660445, 0.6427876, 0, -0.6427876, 0.7660445, 0, 0, 0, 1) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.1150979, -0.0894202, 0.0048119, 0.7968819, 0.5744653, -0.1869995, -0.5527226, 0.8182141, 0.1581873, 0.2438788, -0.0226977, 0.9695401), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.1625358, -0.0394759, 0.0144454, 0.8433748, -0.5037464, 0.1869717, 0.4778075, 0.8622685, 0.1679067, -0.2458023, -0.0522718, 0.9679096), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0.0000019, -0.0000002, 0.9998477, -0.0015211, -0.017386, -0.0064437, 0.8936321, -0.4487541, 0.0162192, 0.4487978, 0.8934861), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.3629397, -0.1679593, 0, 0.2756377, -0.9612616, 0, 0.9612616, 0.2756377, 0, 0, 0, 1) })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(0.3060911, -0.2967424, 0.000061, 0.1564351, -0.9876883, 0, 0.9876882, 0.1564351, 0, 0, 0, 1) })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(0.4344591, 0.153643, 0.0056334, 0.6078568, -0.7937518, -0.0216368, 0.7935244, 0.6082194, -0.0196938, 0.0287919, -0.0051983, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[40] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(0.6493769, -0.2858835, -0.0382065, -0.837382, -0.4853627, 0.2514251, 0.5455774, -0.7704978, 0.3296639, 0.0337159, 0.4132265, 0.9100039), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { Weight = 0 })
					I[45] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(0.4244606, 0.1393622, 0.0044647, 0.5363574, -0.8437136, -0.0216371, 0.8435186, 0.5367385, -0.019694, 0.0282296, -0.0076883, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[46] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0.6493675, -0.2858707, -0.038165, -0.8764947, -0.4105362, 0.2514298, 0.4763527, -0.815114, 0.3296618, 0.0696059, 0.4087162, 0.9100034), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 })
				I[49] = new("Pose", I[48], "Torso", { Weight = 0 })
					I[50] = new("Pose", I[49], "Left Arm", { CFrame = CFrame.new(-0.6727066, -0.356344, -0.0376921, -0.8764982, 0.4105312, -0.2514257, -0.4763465, -0.8151166, 0.3296642, -0.0696038, 0.4087159, 0.9100035), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[51] = new("Pose", I[49], "Right Arm", { CFrame = CFrame.new(-0.4244876, 0.139401, 0.0051973, 0.5363587, 0.8437127, 0.0216369, -0.8435178, 0.5367397, -0.019694, -0.0282295, -0.0076881, 0.9995718), EasingDirection = Enum.PoseEasingDirection.InOut })
	return I[1]
end

return build
