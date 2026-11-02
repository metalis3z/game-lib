-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Bear/a.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "a", { Loop = false, Priority = Enum.AnimationPriority.Idle }, nil, { "1721904588" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Torso", { Weight = 0 })
				I[4] = new("Pose", I[3], "LR", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[5] = new("Pose", I[3], "Head", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[5], "EarR", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[5], "Brow1", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[5], "Part", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[5], "Brow2", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[5], "EarL", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[11] = new("Pose", I[3], "RR", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 1.5333333 })
			I[13] = new("Pose", I[12], "Torso", { Weight = 0 })
				I[14] = new("Pose", I[13], "LR", { CFrame = CFrame.new(0.0000177, -0.0000495, 0.0000425, 0.9925541, -0.1217985, 0.0000001, 0.1217985, 0.9925542, 0.0000002, 0.0000001, 0.0000001, 0.9999949), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[15] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0.0000035, 0, 0, 0.9816273, -0.190809, 0.0000001, 0.190809, 0.9816272, 0, 0.0000001, 0, 0.999984), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[16] = new("Pose", I[15], "EarR", { CFrame = CFrame.new(0.0000212, 0.0000035, 0.0000142, 0.9062904, -0.4226554, 0, 0.4226555, 0.9062905, 0.0000001, 0.0000001, 0.0000001, 0.9999843), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[15], "Brow1", { CFrame = CFrame.new(-0.2182917, -0.6719224, -0.0709208, 0.924849, -0.3747881, -0.0646939, 0.3738739, 0.9271111, -0.0261451, 0.0697784, -0.0000033, 0.9975451), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[15], "Part", { CFrame = CFrame.new(0.0000035, -0.3455904, -0.0000991, 0.9999964, 0.0000005, -0.0027409, 0.0000004, 1, 0.0003426, 0.0027407, -0.0003426, 0.9999887), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[15], "Brow2", { CFrame = CFrame.new(-0.1837086, -0.6752336, 0.0497804, 0.9612169, -0.2741439, 0.0300533, 0.2739219, 0.9616857, 0.0113303, -0.0320087, -0.0026629, 0.9994667), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[20] = new("Pose", I[15], "EarL", { CFrame = CFrame.new(0.0000142, 0.0000283, 0.0000566, 0.874605, -0.4848362, 0, 0.4848363, 0.8746052, 0, 0, 0, 0.9999843), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[21] = new("Pose", I[13], "RR", { CFrame = CFrame.new(0.0000212, -0.0000142, 0.0000212, 0.9961971, -0.0871173, 0.0000002, 0.0871163, 0.9961961, -0.0000006, 0, -0.0000008, 0.9999866), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 3 })
			I[23] = new("Pose", I[22], "Torso", { Weight = 0 })
				I[24] = new("Pose", I[23], "LR", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[25] = new("Pose", I[23], "Head", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[26] = new("Pose", I[25], "EarR", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[27] = new("Pose", I[25], "Brow1", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[28] = new("Pose", I[25], "Part", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[25], "Brow2", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[25], "EarL", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
				I[31] = new("Pose", I[23], "RR", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
