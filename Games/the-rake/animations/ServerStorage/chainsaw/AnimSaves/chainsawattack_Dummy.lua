-- Generated from animations/ServerStorage/chainsaw/AnimSaves/chainsawattack_Dummy.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "chainsawattack_Dummy", { Loop = false }, nil, { "1619181303" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.653819, 0.756651, 0, -0.756651, 0.653819, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.2652435, -0.377708, 0.3133839, 0.1885933, -0.5038385, 0.8429586, 0.8631881, 0.4943903, 0.1023793, -0.4683341, 0.7083247, 0.528147), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "ArmAttach", { CFrame = CFrame.new(0, -1.5353551, -0.9725622, 0.966996, 0, 0.2547914, -0.2238669, 0.4775068, 0.8496298, -0.1216646, -0.8786281, 0.4617472), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[7] = new("Pose", I[6], "Part", { CFrame = CFrame.new(-0.2077251, -0.4467764, 0.2843954, 0.7892683, 0, 0.6140484, 0, 1, 0, -0.6140484, 0, 0.7892683), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.2424343, -0.0294921, -0.2108192, 0.1732279, 0.7441828, -0.6451232, -0.8311945, 0.4618321, 0.3095554, 0.5283051, 0.4825998, 0.6985636), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7195998, -0.694389, 0, 0.694389, 0.7195998, 0.0001867, -0.0001296, -0.0001343, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.1700851, 0.9819464, -0.082778, -0.9663497, 0.1826524, 0.1811243, 0.1929739, 0.049186, 0.9799703), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.2047514, -0.6429908, 0.4613581, -0.240772, -0.4810914, 0.8429586, 0.9497101, -0.2959148, 0.1023793, 0.2001903, 0.8252172, 0.528147), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[14] = new("Pose", I[13], "ArmAttach", { CFrame = CFrame.new(0, -1.5353546, -0.9725621, 0.9592321, -0.2324303, -0.1607789, 0.2692904, 0.5790349, 0.769546, -0.0857692, -0.7814696, 0.6180202), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[15] = new("Pose", I[14], "Part", { CFrame = CFrame.new(-0.2077251, -0.4467764, 0.2843954, 0.7892684, 0, 0.6140484, 0, 1, 0, -0.6140484, 0, 0.7892684), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[16] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.2424336, -0.0294956, -0.2108183, -0.5236195, 0.4970857, -0.6919019, -0.844988, -0.4066368, 0.3473303, -0.1087, 0.7665186, 0.6329558), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0, 0.8701131, -0.4928521, 0, 0.4928521, 0.8701131, 0.0001867, -0.000092, -0.0001624, 1), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.2833333 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9832675, -0.1820715, -0.0059057, 0.1758128, 0.9569578, -0.2309149, 0.0476945, 0.2260129, 0.972956), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.2652426, -0.3777048, 0.3133846, 0.3666387, -0.5371989, 0.7596008, 0.9303433, 0.2063192, -0.30314, 0.0061262, 0.8178322, 0.5754241), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[22] = new("Pose", I[21], "ArmAttach", { CFrame = CFrame.new(-0.096813, -1.7318394, -0.4462126, 0.9437459, 0.0594697, 0.3252801, -0.3267359, 0.0163852, 0.9449736, 0.0508675, -0.9980956, 0.0348944), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[23] = new("Pose", I[22], "Part", { CFrame = CFrame.new(-0.2077251, -0.4467764, 0.2843954, 0.7892683, 0, 0.6140485, 0, 1, 0, -0.6140485, 0, 0.7892683), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.4115045, 0.1385264, -0.4072218, 0.3278959, 0.7925234, -0.5141894, -0.7404338, 0.5536219, 0.3811306, 0.5867215, 0.2557519, 0.7683415), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9511446, -0.3087459, 0, 0.3087459, 0.9511446, 0.0001867, -0.0000576, -0.0001776, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 1.05 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.653819, 0.756651, 0, -0.756651, 0.653819, 0, 0, 0, 1) })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.2652435, -0.377708, 0.3133839, 0.1885933, -0.5038385, 0.8429586, 0.8631881, 0.4943903, 0.1023793, -0.4683341, 0.7083247, 0.528147) })
						I[30] = new("Pose", I[29], "ArmAttach", { CFrame = CFrame.new(0, -1.5353551, -0.9725622, 0.966996, 0, 0.2547914, -0.2238669, 0.4775068, 0.8496298, -0.1216646, -0.8786281, 0.4617472) })
							I[31] = new("Pose", I[30], "Part", { CFrame = CFrame.new(-0.2077251, -0.4467764, 0.2843954, 0.7892683, 0, 0.6140484, 0, 1, 0, -0.6140484, 0, 0.7892683) })
					I[32] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.2424343, -0.0294921, -0.2108192, 0.1732279, 0.7441828, -0.6451232, -0.8311945, 0.4618321, 0.3095554, 0.5283051, 0.4825998, 0.6985636) })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7195998, -0.694389, 0, 0.694389, 0.7195998, 0.0001867, -0.0001296, -0.0001343, 1) })
	return I[1]
end

return build
