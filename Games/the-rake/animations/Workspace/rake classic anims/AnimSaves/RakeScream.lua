-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeScream.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeScream", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1595938733" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000023, -0.0000014, -0.0000001, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.0000019, -0.0000045, 0.000002, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000006, 0.0000005, 0.0000063, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000038, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.4442806, 0.0511305, 1, 0, 0, 0, 0.9396926, -0.3420199, 0, 0.3420199, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.1879385, 0.0684031, -0.0000004, 0.9396923, 0.3420208, 0, -0.3420208, 0.9396923, 0, 0, 0, 0.9999999), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.1879384, 0.0684034, -0.0000001, 0.9396926, -0.3420199, 0, 0.3420199, 0.9396926, 0, 0, 0, 0.9999999), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0, -0.000001, 0.0000007, 0.4699387, 0.802451, -0.367736, -0.692587, 0.5934865, 0.4099963, 0.5472484, 0.0620161, 0.8346695), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(-0.0000002, -0.0000023, 0.0000007, 0.5146121, -0.8198742, 0.2509589, 0.6844961, 0.5691014, 0.4556186, -0.5163712, -0.0626865, 0.8540674), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9659259, -0.2588189, 0, 0.2588189, 0.9659259), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, -0.625789, -0.0915828, 1, 0, 0, 0, 0.6850436, -0.728502, 0, 0.728502, 0.6850436), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.5178546, 0.3064782, -0.0115201, 0.8190035, 0.5736073, 0.0144243, -0.5732222, 0.8168198, 0.0649746, 0.0254878, -0.0614827, 0.9977826), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0.4998824, 0.345925, -0.0164964, 0.835432, -0.5495518, -0.0067883, 0.548968, 0.8338278, 0.0580116, -0.0262201, -0.0521913, 0.9982928), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.0000004, -0.0000008, 0.0000005, 0.3234553, 0.8718638, -0.367736, -0.7851228, 0.4642038, 0.4099963, 0.5281656, 0.1561025, 0.8346695), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.0000005, -0.0000021, 0.0000005, 0.3644243, -0.8967798, 0.2509589, 0.7729205, 0.4415939, 0.4556186, -0.5194117, 0.0279328, 0.8540674), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9961947, 0.0871561, 0, -0.0871561, 0.9961947), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0.3972172, 0.0470908, 1, 0, 0, 0, 0.9734228, 0.2290145, 0, -0.2290145, 0.9734228), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000008, 0.0000001, 0.9396927, -0.3420197, 0.0000001, 0.3368236, 0.9254166, 0.1736481, -0.0593912, -0.1631759, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(-0.0000001, -0.0000008, 0.0000001, 0.9396926, 0.3420203, 0, -0.3368242, 0.9254165, 0.1736482, 0.0593912, -0.1631759, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.0000005, -0.0000006, 0.0000005, 0.8765295, -0.3234554, 0.3564722, 0.0383306, 0.7851228, 0.6181527, -0.4798192, -0.5281655, 0.7005815), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.0000001, -0.0000024, 0.0000006, 0.8115739, 0.3644243, -0.4566643, 0.0099169, 0.7729205, 0.634425, 0.5841655, -0.5194117, 0.6236684), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, 0, 0.0000005, 1, 0, 0, 0, 0.9063076, 0.4226186, 0, -0.4226186, 0.9063076), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0.4559168, 0.2382827, 1, 0, 0, 0, 0.9559594, 0.2934982, 0, -0.2934982, 0.9559594), EasingDirection = Enum.PoseEasingDirection.Out })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(0.0837886, -0.1815744, -0.0032495, 0.9050018, -0.4242738, 0.0310394, 0.4189447, 0.9015472, 0.1081563, -0.0738713, -0.0848779, 0.9936491), EasingDirection = Enum.PoseEasingDirection.Out })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(-0.0907062, -0.1755409, 0.0309523, 0.8912407, 0.4507912, -0.0497703, -0.4466403, 0.8914558, 0.0762806, 0.0787547, -0.045755, 0.9958434), EasingDirection = Enum.PoseEasingDirection.Out })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(-0.0491508, 0.0800333, -0.0456079, 0.8070456, -0.4707491, 0.3564722, 0.1740834, 0.7665389, 0.6181527, -0.5642447, -0.4368217, 0.7005815), EasingDirection = Enum.PoseEasingDirection.Out })
					I[40] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(0.0491295, 0.0749874, -0.0403088, 0.7359627, 0.4998161, -0.4566643, -0.1244498, 0.7629002, 0.634425, 0.6654854, -0.4100815, 0.6236684), EasingDirection = Enum.PoseEasingDirection.Out })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0000005, 1, 0, 0, 0, 0.7808869, 0.6246723, 0, -0.6246723, 0.7808869), EasingDirection = Enum.PoseEasingDirection.Out })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 1.25 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420201, 0, 0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[45] = new("Pose", I[44], "Left Leg", { CFrame = CFrame.new(0.0000023, -0.0000014, -0.0000001, 0.8576995, 0.3487518, 0.3777875, -0.3652485, 0.9304364, -0.0296936, -0.3618629, -0.1125182, 0.9254161), EasingDirection = Enum.PoseEasingDirection.Out })
					I[46] = new("Pose", I[44], "Right Leg", { CFrame = CFrame.new(0.0000019, -0.0000045, 0.000002, 0.9042561, -0.1685345, -0.3923227, 0.2213124, 0.9707505, 0.0930818, 0.36516, -0.1709957, 0.9151059), EasingDirection = Enum.PoseEasingDirection.Out })
					I[47] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(0.0000006, 0.0000005, 0.0000063, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.Out })
					I[48] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(-0.0000004, 0.0000038, 0.0000008, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out })
					I[49] = new("Pose", I[44], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
