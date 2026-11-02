-- Generated from animations/ReplicatedStorage/CaseRigs/Decor Crate #1/AnimSaves/Open.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Open", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1654183585" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "MainBody", { Weight = 0 })
				I[4] = new("Pose", I[3], "Click2", { CFrame = CFrame.new(0, 0, 0, 0.9999982, 0, 0, 0, 0.9999994, 0.0000027, 0, -0.0000027, 0.9999994), EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[5] = new("Pose", I[3], "Click1", { CFrame = CFrame.new(-0.0000153, -0.0000076, 0, 0.9999898, 0, 0, 0, 0.9999959, 0.0000051, 0, -0.0000051, 0.9999974), EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[6] = new("Pose", I[3], "Main", { CFrame = CFrame.new(0, 0.0221252, 0, 0.9999992, -0.0000001, 0.0000004, -0.0000001, 0.9999991, 0.0000003, 0.0000004, 0.0000003, 0.9999997), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[6], "Silver", { CFrame = CFrame.new(0, 0, 0, 0.9999982, -0.0000001, 0.000001, -0.0000001, 0.9999979, 0.0000006, 0.000001, 0.0000006, 0.9999993), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[8] = new("Pose", I[3], "Lid", { CFrame = CFrame.new(0, 0, 0, 0.9999932, 0, 0, 0, 0.9999955, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5333334 })
			I[10] = new("Pose", I[9], "MainBody", { Weight = 0 })
				I[11] = new("Pose", I[10], "Click2", { CFrame = CFrame.new(0, 0, 0, 0.9999982, 0, 0, 0, 0.9999994, 0.0000027, 0, -0.0000027, 0.9999994), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Elastic })
				I[12] = new("Pose", I[10], "Click1", { CFrame = CFrame.new(-0.0000153, -0.0000076, 0, 0.9999898, 0, 0, 0, 0.9999959, 0.0000051, 0, -0.0000051, 0.9999974), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Elastic })
				I[13] = new("Pose", I[10], "Lid", { CFrame = CFrame.new(0, 0, 0, 0.9999932, 0, 0, 0, 0.9999955, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Elastic })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 1.1333333 })
			I[15] = new("Pose", I[14], "MainBody", { Weight = 0 })
				I[16] = new("Pose", I[15], "Click2", { CFrame = CFrame.new(0, -0.0000381, 0, 0.9999843, 0, 0, 0, -0.0016914, 0.9999945, 0, -0.9999921, -0.0016914) })
				I[17] = new("Pose", I[15], "Click1", { CFrame = CFrame.new(-0.0000229, -0.0000076, 0, 0.99999, 0, 0, 0, -0.0041143, 0.9999889, 0, -0.9999875, -0.0041143) })
				I[18] = new("Pose", I[15], "Lid", { CFrame = CFrame.new(0.0000076, -0.0000076, 0, 0.9999864, 0, 0, 0, -0.7071003, -0.7071036, 0, 0.7071036, -0.7071068) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 3 })
			I[20] = new("Pose", I[19], "MainBody", { Weight = 0 })
				I[21] = new("Pose", I[20], "Click2", { CFrame = CFrame.new(0, -0.0000381, 0, 0.9999843, 0, 0, 0, -0.0016914, 0.9999945, 0, -0.9999921, -0.0016914) })
				I[22] = new("Pose", I[20], "Click1", { CFrame = CFrame.new(-0.0000229, -0.0000076, 0, 0.99999, 0, 0, 0, -0.0041143, 0.9999889, 0, -0.9999875, -0.0041143) })
				I[23] = new("Pose", I[20], "Main", { CFrame = CFrame.new(0, -0.1887817, -0.0000153, 0.9999992, -0.0000001, 0.0000004, -0.0000001, 0.9999991, 0.0000003, 0.0000004, 0.0000003, 0.9999997) })
					I[24] = new("Pose", I[23], "Silver", { CFrame = CFrame.new(0, 0.6502228, 0, 0.9999982, -0.0000001, 0.000001, -0.0000001, 0.9999979, 0.0000006, 0.000001, 0.0000006, 0.9999993) })
				I[25] = new("Pose", I[20], "Lid", { CFrame = CFrame.new(0.0000076, -0.0000076, 0, 0.9999864, 0, 0, 0, -0.7071003, -0.7071036, 0, 0.7071036, -0.7071068) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 })
			I[27] = new("Pose", I[26], "MainBody", { Weight = 0 })
				I[28] = new("Pose", I[27], "Main", { CFrame = CFrame.new(0, -0.1887817, -0.0000153, 0.9999992, -0.0000001, 0.0000004, -0.0000001, 0.9999991, 0.0000003, 0.0000004, 0.0000003, 0.9999997) })
					I[29] = new("Pose", I[28], "Silver", { CFrame = CFrame.new(0, 0.6502228, 0, 0.9999982, -0.0000001, 0.000001, -0.0000001, 0.9999979, 0.0000006, 0.000001, 0.0000006, 0.9999993) })
	return I[1]
end

return build
