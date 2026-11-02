-- Generated from animations/Workspace/Rake Player Animations/player run/AnimSaves/run 4.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "run 4", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9998477, 0, -0.0174524, -0.0070059, 0.9158911, -0.4013658, 0.0159845, 0.4014269, 0.9157517), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.1831811, -0.0802851, 0, 0.4383715, -0.8987939, 0, 0.8987939, 0.4383715, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.5727218, -0.0540392, 0, 0.2419221, -0.9702957, 0, 0.9702957, 0.2419221, 0, 0, -0.0000001, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.3663574, -0.1605706, 0.000003, 0.7193396, -0.6878982, -0.0966778, 0.6946585, 0.712339, 0.1001127, 0, -0.1391731, 0.9902681), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.4466321, -0.0226168, -0.0000162, -0.7193396, -0.6346022, 0.2825429, 0.6946585, -0.6571494, 0.2925819, -0.0000001, 0.4067366, 0.9135455), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.000001, 1, 0, 0, 0, 0.9975641, 0.0697562, 0, -0.0697562, 0.9975641), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.0000008, -0.2, 1, 0, 0, 0, 0.9158912, -0.4014266, 0, 0.4014266, 0.9158912), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-1.1160107, 0.5004979, -0.0000005, 0.7660447, -0.6427873, 0, 0.6427873, 0.7660447, 0, 0, 0, 1) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9998477, 0, 0.0174524, 0.0070059, 0.9158911, -0.4013658, -0.0159845, 0.4014269, 0.9157517), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[16], "Left Leg", { CFrame = CFrame.new(-0.5281551, -0.0429286, 0, 0.2419217, 0.9702958, 0, -0.9702958, 0.2419217, 0, 0, 0, 1) })
					I[18] = new("Pose", I[16], "Right Leg", { CFrame = CFrame.new(-0.1831765, -0.0802815, 0, 0.4383715, 0.8987939, 0, -0.8987939, 0.4383715, 0, 0, 0, 1) })
					I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.4466362, -0.0226123, -0.0000024, -0.7193396, 0.6346022, -0.2825429, -0.6946585, -0.6571494, 0.2925819, 0.0000001, 0.4067366, 0.9135455), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[20] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(-0.3663566, -0.1605718, -0.0000046, 0.7193398, 0.6878979, 0.0966778, -0.6946583, 0.7123393, 0.1001127, 0, -0.1391731, 0.9902681), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[16], "Head", { CFrame = CFrame.new(0, -0.0000017, 0.0000019, 1, 0, 0, 0, 0.9902681, 0.1391726, 0, -0.1391726, 0.9902681), EasingDirection = Enum.PoseEasingDirection.Out })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[24] = new("Pose", I[23], "Torso", { CFrame = CFrame.new(0, -0.0000008, -0.2, 1, 0, 0, 0, 0.9158912, -0.4014266, 0, 0.4014266, 0.9158912), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[24], "Left Leg", { CFrame = CFrame.new(-0.172487, -0.0616068, 0.0000001, 0.9945219, 0.1045289, 0, -0.1045289, 0.9945219, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[26] = new("Pose", I[24], "Right Leg", { CFrame = CFrame.new(1.1054653, 0.4879249, -0.0000005, 0.7660445, 0.6427876, 0, -0.6427876, 0.7660445, 0, 0, 0, 1) })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[29] = new("Pose", I[28], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9998477, 0, -0.0174524, -0.0070059, 0.9158911, -0.4013658, 0.0159845, 0.4014269, 0.9157517), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[29], "Left Leg", { CFrame = CFrame.new(0.1831811, -0.0802851, 0, 0.4383715, -0.8987939, 0, 0.8987939, 0.4383715, 0, 0, 0, 1) })
					I[31] = new("Pose", I[29], "Right Leg", { CFrame = CFrame.new(0.4466454, -0.0226043, 0, 0.2419221, -0.9702957, 0, 0.9702957, 0.2419221, 0, 0, -0.0000001, 1) })
					I[32] = new("Pose", I[29], "Left Arm", { CFrame = CFrame.new(0.3663574, -0.1605706, 0.000003, 0.7193396, -0.6878982, -0.0966778, 0.6946585, 0.712339, 0.1001127, 0, -0.1391731, 0.9902681), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[29], "Right Arm", { CFrame = CFrame.new(0.446632, -0.0226175, -0.0000165, -0.7193391, -0.6346028, 0.282543, 0.6946591, -0.6571489, 0.2925817, -0.0000004, 0.4067366, 0.9135455), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[34] = new("Pose", I[29], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.000001, 1, 0, 0, 0, 0.9975641, 0.0697562, 0, -0.0697562, 0.9975641), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
