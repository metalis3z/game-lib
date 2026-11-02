-- Generated from animations/Workspace/Rake Player Animations/player jump/AnimSaves/ExportAnim/Test.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Test", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.1683103, 0.5622318, 0.0000004, 0.9848077, 0.1736483, 0, -0.1736483, 0.9848077, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.2030373, 0.1652699, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, -0.000001, 0.0000011, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0, -0.000001, 0.0000011, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000003, 1, 0, 0, 0, 0.9848078, -0.1736475, 0, 0.1736475, 0.9848078), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396926, -0.3420202, 0, 0.3420202, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.5164896, 1.0910664, 0, 0.9396924, 0.3420206, 0, -0.3420206, 0.9396924, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.3195373, 0.856341, 0, 0.9396925, -0.3420205, 0, 0.3420205, 0.9396925, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0000047, 0.0000004, 0.0000152, 0.9929454, -0.1109971, 0.0417031, -0.0193823, 0.1950386, 0.9806041, -0.116978, -0.9744945, 0.1915113), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(-0.0000014, 0.0000013, -0.0000075, 0.9971347, -0.0631124, -0.0417032, 0.0529559, 0.1887096, 0.9806041, -0.0540184, -0.9800028, 0.1915111), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0.0000019, 1, 0, 0, 0, 0.9396924, 0.3420206, 0, -0.3420206, 0.9396924), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848076, -0.1736488, 0, 0.1736488, 0.9848076), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.4723457, 0.7350509, 0, 0.9653602, 0.2609207, 0, -0.2609207, 0.9653602, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0.2835508, 0.5003747, 0.0000001, 0.9401383, -0.3407934, 0, 0.3407934, 0.9401383, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.0000002, 0.0000002, -0.0000002, 0.9396927, 0.3420197, 0, -0.1710098, 0.4698463, 0.8660254, 0.2961978, -0.8137978, 0.5), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.0000003, -0.0000032, -0.0000019, 0.9852875, 0.1466814, -0.0877104, -0.0024424, 0.525244, 0.8509482, 0.1708876, -0.8382143, 0.5178746), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0.0000012, 1, 0, 0, 0, 0.9396924, 0.3420205, 0, -0.3420205, 0.9396924), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
