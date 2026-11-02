-- Generated from animations/ServerStorage/MediumSmacks/AnimSaves/Shot_Hunting_Rifle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Shot_Hunting_Rifle", { Loop = false }, nil, { "1617618187" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7959675, 0.6053392, 0, -0.6053392, 0.7959675, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "Attach", { Weight = 0 })
							I[7] = new("Pose", I[6], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[8] = new("Pose", I[6], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7949504, -0.6066747, 0, 0.6066747, 0.7949504, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-1.2952459, -0.2657436, -0.6223054, -0.2307129, 0.9670577, -0.1075682, -0.9685596, -0.2388225, -0.0696858, -0.0930799, 0.0881087, 0.9917525), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.62292, 0.7822856, 0, -0.7822856, 0.62292, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.2531232, 0.0083374, -0.3006135, -0.1050743, -0.5973297, 0.7950826, 0.9867574, -0.1619683, 0.0087215, 0.1235685, 0.7854702, 0.6064382), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[15] = new("Pose", I[14], "Attach", { Weight = 0 })
							I[16] = new("Pose", I[15], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[17] = new("Pose", I[15], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0, 0, 0, 0.6107272, -0.7918411, 0, 0.7918411, 0.6107272, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-1.076966, -0.1888817, -0.6338772, -0.614278, 0.7890402, 0.0088268, -0.7806864, -0.6060702, -0.1523397, -0.1148525, -0.1004699, 0.9882886), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7959675, 0.6053392, 0, -0.6053392, 0.7959675, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[24] = new("Pose", I[23], "Attach", { Weight = 0 })
							I[25] = new("Pose", I[24], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[26] = new("Pose", I[24], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[27] = new("Pose", I[22], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7949504, -0.6066747, 0, 0.6066747, 0.7949504, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[28] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-1.2952459, -0.2657436, -0.6223054, -0.2307129, 0.9670577, -0.1075682, -0.9685596, -0.2388225, -0.0696858, -0.0930799, 0.0881087, 0.9917525), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.6333333 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 })
				I[31] = new("Pose", I[30], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8322524, 0.5543969, 0, -0.5543969, 0.8322524, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[31], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[33] = new("Pose", I[32], "Attach", { Weight = 0 })
							I[34] = new("Pose", I[33], "Mag", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[35] = new("Pose", I[33], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[36] = new("Pose", I[31], "Head", { CFrame = CFrame.new(0, 0, 0, 0.8355091, -0.5494766, 0, 0.5494766, 0.8355091, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[31], "Left Arm", { CFrame = CFrame.new(-0.5287822, -0.0515845, -0.1509598, -0.2458335, 0.6981878, -0.6723835, -0.9622813, -0.259184, 0.0826936, -0.1165353, 0.667351, 0.7355689), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7959675, 0.6053392, 0, -0.6053392, 0.7959675, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[41] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[42] = new("Pose", I[41], "Attach", { Weight = 0 })
							I[43] = new("Pose", I[42], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[44] = new("Pose", I[42], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[45] = new("Pose", I[40], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7949504, -0.6066747, 0, 0.6066747, 0.7949504, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[46] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(-1.2952459, -0.2657436, -0.6223054, -0.2307129, 0.9670577, -0.1075682, -0.9685596, -0.2388225, -0.0696858, -0.0930799, 0.0881087, 0.9917525), EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
