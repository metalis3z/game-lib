-- Generated from animations/ServerStorage/TrickySignAnims/AnimSaves/Tricky-Sign-Swing.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Tricky-Sign-Swing", { Loop = false }, nil, { "1619270130" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1213754, -0.4926789, 0.0153329, -0.0160417, -0.8168226, 0.5766658, 0.6851259, 0.4110842, 0.6013421, -0.7282481, 0.4047353, 0.5530318), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "ArmAttach", { Weight = 0 })
							I[7] = new("Pose", I[6], "Base", { CFrame = CFrame.new(-0.0002289, -0.1515241, 0.119567, 1.0000002, -0.0000001, -0.0000003, 0, 0.9955464, -0.0942747, 0.0000002, 0.0942747, 0.9955461), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.1511318, -0.1121649, 0.0943285, -0.1794908, 0.7042186, -0.68692, -0.4951327, -0.6680406, -0.5554865, -0.8500744, 0.2404119, 0.4685888), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8580834, 0.5135103, 0, -0.5135103, 0.8580834, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.6417544, 0.0058365, -0.2844799, 0.0642267, 0.5051671, -0.8606282, 0.9922113, -0.1245614, 0.0009322, -0.1067301, -0.8539851, -0.5092328), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[14] = new("Pose", I[13], "ArmAttach", { Weight = 0 })
							I[15] = new("Pose", I[14], "Base", { CFrame = CFrame.new(-1.6001275, -1.3902891, -0.2040493, 0.3703328, -0.9228751, -0.1056164, 0.9282881, 0.3718124, 0.0060524, 0.0336837, -0.1002838, 0.9943881), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[16] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.5855519, -1.0084257, -2.8887746, -0.3880498, -0.0786297, 0.9182781, 0.4008369, -0.9115857, 0.0913307, 0.8299079, 0.4035206, 0.3852585), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0, 0.8809417, -0.473225, 0, 0.473225, 0.8809417, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.6193132, -0.7441723, 0.2503172, 0.7851441, 0.5869952, -0.1974475, 0, 0.3188168, 0.9478164), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(1.127454, 0.0953756, 0.6359365, -0.0845422, -0.6786743, -0.7295572, 0.9715612, -0.2186728, 0.0908355, -0.221182, -0.70113, 0.6778607), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[22] = new("Pose", I[21], "ArmAttach", { Weight = 0 })
							I[23] = new("Pose", I[22], "Base", { CFrame = CFrame.new(-3.1109676, -1.7550268, -0.3621737, 0.0903047, -0.9902982, -0.1056152, 0.995908, 0.0901711, 0.0060496, 0.0035325, -0.1057293, 0.9943883), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-1.5421766, -0.065522, -3.3862841, 0.5459521, 0.6685032, 0.5050146, 0.8322358, -0.5021757, -0.2349535, 0.0965389, 0.5485646, -0.8305162), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0.0000152, 0.0001221, 0.0000419, 0.641226, 0.767352, 0, -0.7673522, 0.6412261, 0, -0.0000001, 0, 1.0000001), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5666667 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.3653804, -0.8661705, 0.3409483, 0.9258556, 0.30024, -0.2294497, 0.0963762, 0.3995053, 0.9116507), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(1.0582776, 0.2993819, 0.0762671, -0.4061075, -0.9112695, -0.0683, 0.9100299, -0.4100944, 0.060563, -0.0831986, -0.03756, 0.9958249), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[30] = new("Pose", I[29], "ArmAttach", { Weight = 0 })
							I[31] = new("Pose", I[30], "Base", { CFrame = CFrame.new(-1.9646795, -1.8651788, 1.382184, 0.0902821, -0.8313333, 0.5483926, 0.99591, 0.0734133, -0.0526661, 0.0035237, 0.5509043, 0.8345606), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-1.9623661, 0.1333276, -2.7228646, 0.5459579, 0.5189345, -0.6577514, 0.8322293, -0.2454238, 0.4971532, 0.0965621, -0.8188247, -0.5658635), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.0000192, 0.000122, 0.0000421, 0.4146344, 0.9099879, -0.0000002, -0.9099881, 0.4146345, 0.0000001, 0.0000002, 0.0000001, 0.9999998), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.2218379, -0.9135327, 0.3409483, 0.9620064, 0.1479739, -0.2294497, 0.1591584, 0.3788952, 0.9116507), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(1.1088037, 0.3134443, -0.0162181, -0.4061073, -0.9004013, 0.1560594, 0.9100304, -0.3829316, 0.1587717, -0.0831982, 0.2064971, 0.9749036), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[38] = new("Pose", I[37], "ArmAttach", { Weight = 0 })
							I[39] = new("Pose", I[38], "Base", { CFrame = CFrame.new(-1.6991386, -1.8903375, 1.6937304, 0.090278, -0.756986, 0.6471651, 0.9959106, 0.0663215, -0.0613512, 0.0035209, 0.6500569, 0.759877), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[40] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(-1.8574188, 0.0316375, -2.4402137, 0.545958, 0.4811083, -0.6859043, 0.8322291, -0.2170643, 0.5101744, 0.0965638, -0.8493633, -0.5189003), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[41] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0.0000479, 0.0001144, 0.0000229, 0.2944569, 0.9556649, -0.0000003, -0.9556648, 0.2944569, 0, 0.0000001, 0.0000003, 1), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 1.3 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso")
					I[45] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0.1213754, -0.4926789, 0.0153329, -0.0160417, -0.8168226, 0.5766658, 0.6851259, 0.4110842, 0.6013421, -0.7282481, 0.4047353, 0.5530318) })
						I[46] = new("Pose", I[45], "ArmAttach", { Weight = 0 })
							I[47] = new("Pose", I[46], "Base", { CFrame = CFrame.new(-0.0002289, -0.1515241, 0.119567, 1.0000002, -0.0000001, -0.0000003, 0, 0.9955464, -0.0942747, 0.0000002, 0.0942747, 0.9955461) })
					I[48] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(-0.1511318, -0.1121649, 0.0943285, -0.1794908, 0.7042186, -0.68692, -0.4951327, -0.6680406, -0.5554865, -0.8500744, 0.2404119, 0.4685888) })
					I[49] = new("Pose", I[44], "Head")
	return I[1]
end

return build
