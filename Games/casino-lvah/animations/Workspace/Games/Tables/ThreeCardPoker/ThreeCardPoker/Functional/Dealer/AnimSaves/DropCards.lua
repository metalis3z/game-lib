-- Generated from animations/Workspace/Games/Tables/ThreeCardPoker/ThreeCardPoker/Functional/Dealer/AnimSaves/DropCards.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "DropCards", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1703674606" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { Weight = 0 })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.1428604, -0.247649, 0.0497456, 0.7533523, -0.6354809, -0.1691869, 0.1798466, 0.446558, -0.8764937, 0.6325468, 0.6298809, 0.4507045), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(-0.0000048, 0, -0.0000019, 0.9999999, 0.0000001, 0, 0.0000001, 0.9730667, -0.2305232, 0, 0.2305231, 0.9730669), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0.162756, 0.0193932, 0.0344, 0.7870222, 0.602545, 0.1324215, -0.4275275, 0.6874404, -0.5870656, -0.4447653, 0.4054198, 0.7986355), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(0.0000057, 0, 0.0000019, 0.9997995, 0.0042524, 0.0195512, 0.009962, 0.7416221, -0.6707435, -0.017352, 0.6708041, 0.7414312), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[4], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "LowerTorso", { Weight = 0 })
					I[14] = new("Pose", I[13], "UpperTorso", { Weight = 0 })
						I[15] = new("Pose", I[14], "LeftUpperArm", { CFrame = CFrame.new(0.0000019, -0.2456524, -0.0000019, 0.8779197, -0.3516471, -0.3249635, 0, 0.678693, -0.7344221, 0.4788079, 0.6447636, 0.595838), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[16] = new("Pose", I[15], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 0.9999999, -0.0000001, 0.0000001, -0.0000001, 0.8291504, -0.5590258, 0.0000001, 0.5590254, 0.8291504), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[17] = new("Pose", I[14], "RightUpperArm", { CFrame = CFrame.new(0.0047817, -0.2667019, -0.1952314, 0.9865358, -0.1393067, -0.0856789, 0.0180089, 0.6132298, -0.7896993, 0.1625513, 0.7775236, 0.6074818), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[18] = new("Pose", I[17], "RightLowerArm", { CFrame = CFrame.new(0.0000019, -0.0000019, 0, 0.9997999, -0.006934, 0.0187685, 0.0099622, 0.9860069, -0.166407, -0.017352, 0.1665605, 0.9858786), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[13], "CardDeck", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "LowerTorso", { Weight = 0 })
					I[23] = new("Pose", I[22], "UpperTorso", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[24] = new("Pose", I[23], "LeftUpperArm", { CFrame = CFrame.new(0.0000019, -0.2456524, -0.0000019, 0.8779197, -0.3516471, -0.3249635, 0, 0.678693, -0.7344221, 0.4788079, 0.6447636, 0.595838), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[25] = new("Pose", I[24], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 0.9999999, -0.0000001, 0.0000001, -0.0000001, 0.8291504, -0.5590258, 0.0000001, 0.5590254, 0.8291504), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[26] = new("Pose", I[23], "RightUpperArm", { CFrame = CFrame.new(0, -0.2456541, -0.000001, 0.8779914, 0.3471516, 0.3295706, 0, 0.6885041, -0.7252324, -0.4786763, 0.6367478, 0.6045007), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[27] = new("Pose", I[26], "RightLowerArm", { CFrame = CFrame.new(0.0000019, -0.0000005, 0.0000005, 1.0000001, 0, 0.0000001, 0, 0.7998351, -0.6002201, 0, 0.6002201, 0.7998347), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[28] = new("Pose", I[22], "CardDeck", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[29] = new("AnimationRigData", I[1], "DealerAnimationRigData")
	return I[1]
end

return build
