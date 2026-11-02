-- Generated from animations/Workspace/Rake Player Animations/player run/AnimSaves/run 6.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "run 6", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.0000021, -0.0000002, 0.9998477, 0, -0.0174524, -0.0064437, 0.9293429, -0.3691615, 0.0162192, 0.3692178, 0.9292014), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.3629397, -0.1679593, 0, 0.2756377, -0.9612616, 0, 0.9612616, 0.2756377, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.2818937, -0.3937733, 0, 0.2419221, -0.9702957, 0, 0.9702957, 0.2419221, 0, 0, -0.0000001, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.4402081, 0.0252459, 0.0032472, 0.7364572, -0.6761381, -0.0216367, 0.6758512, 0.7367749, -0.0196937, 0.029257, -0.0001196, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.580818, -0.3461855, 0.0024291, -0.6832361, -0.6855499, 0.2514154, 0.7263985, -0.6030461, 0.3296677, -0.0743885, 0.4078687, 0.9100052), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.0000017, -0.1999993, 1, 0, 0, 0, 0.9293429, -0.3692178, 0, 0.3692178, 0.9293429), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-1.2445674, 0.6537061, -0.0000048, 0.7660444, -0.6427876, 0, 0.6427876, 0.7660444, 0, 0, 0, 1) })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.1961452, -0.0671122, 0, 0.9713609, 0.2376088, 0, -0.2376088, 0.9713609, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9998477, 0, 0.0174524, 0.0064437, 0.9293429, -0.3691615, -0.0162193, 0.3692178, 0.9292014), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(-0.4313864, -0.431047, 0, 0.2419217, 0.9702958, 0, -0.9702958, 0.2419217, 0, 0, 0, 1) })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(-0.3754289, -0.135409, 0, 0.2756377, 0.9612616, 0, -0.9612616, 0.2756377, 0, 0, 0, 1) })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.6041108, -0.4166588, 0.0036748, -0.6832362, 0.6855497, -0.2514156, -0.7263983, -0.6030461, 0.3296678, 0.0743885, 0.4078689, 0.9100052), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[22] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.4401997, 0.0252665, 0.0032257, 0.7364574, 0.6761378, 0.0216367, -0.6758509, 0.7367752, -0.0196938, -0.0292571, -0.0001196, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, -0.0000017, -0.1999993, 1, 0, 0, 0, 0.9293429, -0.3692178, 0, 0.3692178, 0.9293429), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(-0.1737757, -0.0615391, 0, 0.9713609, -0.2376089, 0, 0.2376089, 0.9713609, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(1.1054657, 0.4879254, -0.0000048, 0.7660445, 0.6427876, 0, -0.6427876, 0.7660445, 0, 0, 0, 1) })
					I[29] = new("Pose", I[26], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[32] = new("Pose", I[31], "Torso", { CFrame = CFrame.new(0, 0.0000021, -0.0000002, 0.9998477, 0, -0.0174524, -0.0064437, 0.9293429, -0.3691615, 0.0162192, 0.3692178, 0.9292014), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[32], "Left Leg", { CFrame = CFrame.new(0.3629397, -0.1679593, 0, 0.2756377, -0.9612616, 0, 0.9612616, 0.2756377, 0, 0, 0, 1) })
					I[34] = new("Pose", I[32], "Right Leg", { CFrame = CFrame.new(0.2818937, -0.3937733, 0, 0.2419221, -0.9702957, 0, 0.9702957, 0.2419221, 0, 0, -0.0000001, 1) })
					I[35] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(0.4402081, 0.0252459, 0.0032472, 0.7364572, -0.6761381, -0.0216367, 0.6758512, 0.7367749, -0.0196937, 0.029257, -0.0001196, 0.9995719), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[36] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(0.5808189, -0.3461782, 0.0024179, -0.6832361, -0.6855499, 0.2514155, 0.7263985, -0.603046, 0.3296677, -0.0743885, 0.4078687, 0.9100052), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[32], "Head", { CFrame = CFrame.new(0.0000076, 0.0000019, 0, 1, 0, 0, 0, 1, 0.0000002, 0, -0.0000002, 1), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
