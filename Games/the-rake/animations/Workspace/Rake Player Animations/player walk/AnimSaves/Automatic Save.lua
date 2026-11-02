-- Generated from animations/Workspace/Rake Player Animations/player walk/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000027, 0, 0.9396926, 0.34202, 0, -0.34202, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000008, -0.0000053, 0, 0.9396926, 0.3420199, 0, -0.3420199, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0000001, -0.0000002, 0, 0.9254164, -0.3420203, 0.1631759, 0.3368242, 0.9396925, 0.0593912, -0.1736482, 0, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000002, 0, 0.8528685, -0.5000002, 0.1503835, 0.4924041, 0.8660253, 0.086824, -0.173648, 0, 0.9848078), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0.0000016, -0.000004, 1, 0, 0, 0, 0.9961947, 0.0871563, 0, -0.0871563, 0.9961947), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.0000024, -0.1, 1, 0, 0, 0, 0.9872952, -0.1588971, 0, 0.1588971, 0.9872952), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.1661499, 0.401563, 0, 0.9848077, 0.1736483, 0, -0.1736483, 0.9848077, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0, 0.0000002, 0.0000001, 0.9999964, -0.0000409, 0.0026714, -0.0000407, 0.9995337, 0.0305342, -0.0026714, -0.0305342, 0.9995301), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0, -0.0000003, 0.0000003, 0.9999964, 0.0000408, -0.0026714, 0.0000408, 0.9995337, 0.0305341, 0.0026714, -0.0305341, 0.9995301), EasingDirection = Enum.PoseEasingDirection.Out })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9902681, -0.1391731, 0, 0.1391731, 0.9902681), EasingDirection = Enum.PoseEasingDirection.Out })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000027, 0, 0.9396925, -0.3420203, 0, 0.3420203, 0.9396925, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(-0.0000001, -0.0000003, 0, 0.9396927, -0.3420197, 0, 0.3420197, 0.9396927, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(0.0000002, 0.0000001, 0.0000001, 0.8528686, 0.5, -0.1503837, -0.4924038, 0.8660254, 0.0868241, 0.1736482, 0, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0, -0.0000006, 0, 0.9254164, 0.3420203, -0.1631757, -0.3368242, 0.9396924, 0.0593911, 0.173648, 0.0000001, 0.9848078), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0, 0.0000015, -0.0000062, 1, 0, 0, 0, 0.9975641, 0.069757, 0, -0.069757, 0.9975641), EasingDirection = Enum.PoseEasingDirection.Out })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, -0.0000028, -0.0999997, 1, 0, 0, 0, 0.9880753, -0.1539717, 0, 0.1539717, 0.9880753), EasingDirection = Enum.PoseEasingDirection.Out })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(-0.166006, 0.4025516, 0, 0.9848924, -0.1731673, 0, 0.1731673, 0.9848924, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(0.0000004, -0.0000015, 0, 0.9961947, -0.0871555, 0, 0.0871555, 0.9961947, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[29] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(0, 0.0000002, 0.0000001, 0.9999964, -0.0000406, 0.0026714, -0.000041, 0.9995337, 0.0305342, -0.0026714, -0.0305342, 0.9995301), EasingDirection = Enum.PoseEasingDirection.Out })
					I[30] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(0, 0.0000001, 0, 0.9999964, 0.0000408, -0.0026713, 0.0000408, 0.9995337, 0.0305342, 0.0026713, -0.0305342, 0.9995301), EasingDirection = Enum.PoseEasingDirection.Out })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[33] = new("Pose", I[32], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[34] = new("Pose", I[33], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000027, 0, 0.9396926, 0.34202, 0, -0.34202, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[35] = new("Pose", I[33], "Right Leg", { CFrame = CFrame.new(0.0000008, -0.0000053, 0, 0.9396926, 0.3420199, 0, -0.3420199, 0.9396926, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[36] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(-0.0000001, -0.0000002, 0, 0.9254164, -0.3420203, 0.1631759, 0.3368242, 0.9396925, 0.0593912, -0.1736482, 0, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[37] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000002, 0, 0.8528685, -0.5000002, 0.1503835, 0.4924041, 0.8660253, 0.086824, -0.173648, 0, 0.9848078), EasingDirection = Enum.PoseEasingDirection.Out })
					I[38] = new("Pose", I[33], "Head", { CFrame = CFrame.new(0, 0.0000016, -0.000004, 1, 0, 0, 0, 0.9961947, 0.0871563, 0, -0.0871563, 0.9961947), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
