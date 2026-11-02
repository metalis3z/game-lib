-- Generated from animations/Workspace/Games/Tables/Baccarat/Baccarat/Functional/Dealer/AnimSaves/IdleCards.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "IdleCards", { Priority = Enum.AnimationPriority.Idle }, nil, { "1703670597" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso")
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.1428604, -0.247649, 0.0497456, 0.7533523, -0.6354809, -0.1691869, 0.1798466, 0.446558, -0.8764937, 0.6325468, 0.6298809, 0.4507045), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(-0.0000048, 0, -0.0000019, 0.9999999, 0.0000001, 0, 0.0000001, 0.9730667, -0.2305232, 0, 0.2305231, 0.9730669), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0.162756, 0.0193932, 0.0344, 0.7870222, 0.602545, 0.1324215, -0.4275275, 0.6874404, -0.5870656, -0.4447653, 0.4054198, 0.7986355), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(0.0000057, 0, 0.0000019, 0.9997995, 0.0042524, 0.0195512, 0.009962, 0.7416221, -0.6707435, -0.017352, 0.6708041, 0.7414312), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[10] = new("Pose", I[4], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "LowerTorso")
					I[14] = new("Pose", I[13], "UpperTorso")
						I[15] = new("Pose", I[14], "LeftUpperArm", { CFrame = CFrame.new(0.1428604, -0.247649, 0.0497456, 0.7533523, -0.6354809, -0.1691869, 0.1798466, 0.446558, -0.8764937, 0.6325468, 0.6298809, 0.4507045), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[16] = new("Pose", I[15], "LeftLowerArm", { CFrame = CFrame.new(-0.0000048, 0, -0.0000019, 0.9999999, 0.0000001, 0, 0.0000001, 0.9730667, -0.2305232, 0, 0.2305231, 0.9730669), EasingDirection = Enum.PoseEasingDirection.InOut })
						I[17] = new("Pose", I[14], "RightUpperArm", { CFrame = CFrame.new(0.162756, 0.0193932, 0.0344, 0.7870222, 0.602545, 0.1324215, -0.4275275, 0.6874404, -0.5870656, -0.4447653, 0.4054198, 0.7986355), EasingDirection = Enum.PoseEasingDirection.InOut })
							I[18] = new("Pose", I[17], "RightLowerArm", { CFrame = CFrame.new(0.0000057, 0, 0.0000019, 0.9997995, 0.0042524, 0.0195512, 0.009962, 0.7416221, -0.6707435, -0.017352, 0.6708041, 0.7414312), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[19] = new("Pose", I[13], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "LowerTorso", { Weight = 0 })
					I[23] = new("Pose", I[22], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.1935112, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut })
					I[24] = new("Pose", I[22], "UpperTorso", { CFrame = CFrame.new(0, -0.0321846, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
		I[25] = new("AnimationRigData", I[1], "DealerAnimationRigData")
	return I[1]
end

return build
