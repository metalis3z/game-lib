-- Generated from animations/Workspace/Games/Tables/TournamentHoldem/TournamentHoldem/Functional/Dealer/AnimSaves/TheFlop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "TheFlop", { Loop = false }, nil, { "1703676735" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.1428604, -0.247649, 0.0497456, 0.7533523, -0.6354809, -0.1691869, 0.1798466, 0.446558, -0.8764937, 0.6325468, 0.6298809, 0.4507045), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(-0.0000048, 0, -0.0000019, 0.9999999, 0.0000001, 0, 0.0000001, 0.9730667, -0.2305232, 0, 0.2305231, 0.9730669), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0.162756, 0.0193932, 0.0344, 0.7870222, 0.602545, 0.1324215, -0.4275275, 0.6874404, -0.5870656, -0.4447653, 0.4054198, 0.7986355), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(0.0000057, 0, 0.0000019, 0.9997995, 0.0042524, 0.0195512, 0.009962, 0.7416221, -0.6707435, -0.017352, 0.6708041, 0.7414312), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[4], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[11] = new("Pose", I[4], "RightUpperLeg", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[13] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[14] = new("Pose", I[13], "LowerTorso", { Weight = 0 })
					I[15] = new("Pose", I[14], "UpperTorso", { CFrame = CFrame.new(0.0000305, 0, 0.0000305, 0.9552913, 0, -0.2956624, 0, 1, 0, 0.2956624, 0, 0.9552913), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[16] = new("Pose", I[15], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[17] = new("Pose", I[16], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[14], "CardDeck", { CFrame = CFrame.new(-0.6991577, 1.0197144, -0.2240334, 0.8182223, 0.5529504, 0.1573113, -0.5747081, 0.7798193, 0.2481557, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[19] = new("Keyframe", I[1], "DealCard", { Time = 0.5666667 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "UpperTorso", { CFrame = CFrame.new(0.0000305, 0, 0.0000305, 0.9552913, 0, -0.2956624, 0, 1, 0, 0.2956624, 0, 0.9552913), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[23] = new("Pose", I[22], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[24] = new("Pose", I[23], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[21], "CardDeck", { CFrame = CFrame.new(-0.6991577, 1.0197144, -0.2240334, 0.8182223, 0.5529504, 0.1573113, -0.5747081, 0.7798193, 0.2481557, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.8333333 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "LowerTorso", { Weight = 0 })
					I[29] = new("Pose", I[28], "UpperTorso", { CFrame = CFrame.new(0, 0, 0.000061, 0.986772, 0, -0.1621082, 0, 1, 0, 0.1621082, 0, 0.986772), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[30] = new("Pose", I[29], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[31] = new("Pose", I[30], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[28], "CardDeck", { CFrame = CFrame.new(-0.9475098, 1.0644836, -0.2240334, 0.7318405, 0.6545019, 0.1898044, -0.6813126, 0.6967765, 0.2242866, 0.0145449, -0.2934614, 0.9558603), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[33] = new("Keyframe", I[1], "DealCard", { Time = 1.1 })
			I[34] = new("Pose", I[33], "HumanoidRootPart", { Weight = 0 })
				I[35] = new("Pose", I[34], "LowerTorso", { Weight = 0 })
					I[36] = new("Pose", I[35], "UpperTorso", { CFrame = CFrame.new(0, 0, 0.000061, 0.986772, 0, -0.1621082, 0, 1, 0, 0.1621082, 0, 0.986772), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[37] = new("Pose", I[36], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[38] = new("Pose", I[37], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[39] = new("Pose", I[35], "CardDeck", { CFrame = CFrame.new(-0.9475098, 1.0644836, -0.2240334, 0.7318405, 0.6545019, 0.1898044, -0.6813126, 0.6967765, 0.2242866, 0.0145449, -0.2934614, 0.9558603), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 1.3333334 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "LowerTorso", { Weight = 0 })
					I[43] = new("Pose", I[42], "UpperTorso", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[44] = new("Pose", I[43], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[45] = new("Pose", I[44], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[46] = new("Pose", I[42], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[47] = new("Keyframe", I[1], "DealCard", { Time = 1.5666667 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 })
				I[49] = new("Pose", I[48], "LowerTorso", { Weight = 0 })
					I[50] = new("Pose", I[49], "UpperTorso", { Weight = 0 })
						I[51] = new("Pose", I[50], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[52] = new("Pose", I[51], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[53] = new("Keyframe", I[1], "Keyframe", { Time = 1.7 })
			I[54] = new("Pose", I[53], "HumanoidRootPart", { Weight = 0 })
				I[55] = new("Pose", I[54], "LowerTorso", { Weight = 0 })
					I[56] = new("Pose", I[55], "UpperTorso", { Weight = 0 })
						I[57] = new("Pose", I[56], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[58] = new("Pose", I[57], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[59] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[60] = new("Pose", I[59], "HumanoidRootPart", { Weight = 0 })
				I[61] = new("Pose", I[60], "LowerTorso", { Weight = 0 })
					I[62] = new("Pose", I[61], "UpperTorso", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[63] = new("Pose", I[62], "LeftUpperArm", { CFrame = CFrame.new(0.1428604, -0.247649, 0.0497456, 0.7533523, -0.6354809, -0.1691869, 0.1798466, 0.446558, -0.8764937, 0.6325468, 0.6298809, 0.4507045), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[64] = new("Pose", I[63], "LeftLowerArm", { CFrame = CFrame.new(-0.0000048, 0, -0.0000019, 0.9999999, 0.0000001, 0, 0.0000001, 0.9730667, -0.2305232, 0, 0.2305231, 0.9730669), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[65] = new("Pose", I[62], "RightUpperArm", { CFrame = CFrame.new(0.162756, 0.0193932, 0.0344, 0.7870222, 0.602545, 0.1324215, -0.4275275, 0.6874404, -0.5870656, -0.4447653, 0.4054198, 0.7986355), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[66] = new("Pose", I[65], "RightLowerArm", { CFrame = CFrame.new(0.0000057, 0, 0.0000019, 0.9997995, 0.0042524, 0.0195512, 0.009962, 0.7416221, -0.6707435, -0.017352, 0.6708041, 0.7414312), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[67] = new("Pose", I[61], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[68] = new("Pose", I[61], "RightUpperLeg", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[69] = new("AnimationRigData", I[1], "DealerAnimationRigData")
	return I[1]
end

return build
