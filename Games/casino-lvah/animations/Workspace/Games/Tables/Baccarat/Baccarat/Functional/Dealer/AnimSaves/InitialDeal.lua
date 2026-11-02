-- Generated from animations/Workspace/Games/Tables/Baccarat/Baccarat/Functional/Dealer/AnimSaves/InitialDeal.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "InitialDeal", { Loop = false }, nil, { "1703670800" })
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
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[13] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[14] = new("Pose", I[13], "LowerTorso", { Weight = 0 })
					I[15] = new("Pose", I[14], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.8904479, 0, -0.4550853, 0, 1, 0, 0.4550853, 0, 0.8904479), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[16] = new("Pose", I[15], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[17] = new("Pose", I[16], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[14], "CardDeck", { CFrame = CFrame.new(-0.3826599, 1.0122375, -0.2240334, 0.904653, 0.4110499, 0.1124315, -0.4259005, 0.8630878, 0.2714557, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[19] = new("Keyframe", I[1], "DealPlayer", { Time = 0.6333333 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "UpperTorso", { Weight = 0 })
						I[23] = new("Pose", I[22], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[24] = new("Pose", I[23], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[25] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[26] = new("Pose", I[25], "HumanoidRootPart", { Weight = 0 })
				I[27] = new("Pose", I[26], "LowerTorso", { Weight = 0 })
					I[28] = new("Pose", I[27], "UpperTorso", { Weight = 0 })
						I[29] = new("Pose", I[28], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[30] = new("Pose", I[29], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[31] = new("Keyframe", I[1], "DealPlayer", { Time = 1.1333333 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { Weight = 0 })
				I[33] = new("Pose", I[32], "LowerTorso", { Weight = 0 })
					I[34] = new("Pose", I[33], "UpperTorso", { Weight = 0 })
						I[35] = new("Pose", I[34], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[36] = new("Pose", I[35], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 1.2666667 })
			I[38] = new("Pose", I[37], "HumanoidRootPart", { Weight = 0 })
				I[39] = new("Pose", I[38], "LowerTorso", { Weight = 0 })
					I[40] = new("Pose", I[39], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.8904479, 0, -0.4550853, 0, 1, 0, 0.4550853, 0, 0.8904479), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[41] = new("Pose", I[40], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[42] = new("Pose", I[41], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[43] = new("Pose", I[39], "CardDeck", { CFrame = CFrame.new(-0.3826599, 1.0122375, -0.2240334, 0.904653, 0.4110499, 0.1124315, -0.4259005, 0.8630878, 0.2714557, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 1.6666666 })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { Weight = 0 })
				I[46] = new("Pose", I[45], "LowerTorso", { Weight = 0 })
					I[47] = new("Pose", I[46], "UpperTorso", { CFrame = CFrame.new(-0.0000305, 0, -0.0000076, 0.936608, 0, 0.3503789, 0, 1, 0, -0.3503789, 0, 0.936608), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[48] = new("Pose", I[47], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[49] = new("Pose", I[48], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[50] = new("Pose", I[46], "CardDeck", { CFrame = CFrame.new(-1.7752075, 1.5245972, -0.2240334, 0.2958191, 0.9144309, 0.2762375, -0.9551332, 0.2787447, 0.1001096, 0.0145436, -0.293458, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[51] = new("Keyframe", I[1], "DealBanker", { Time = 1.9333333 })
			I[52] = new("Pose", I[51], "HumanoidRootPart", { Weight = 0 })
				I[53] = new("Pose", I[52], "LowerTorso", { Weight = 0 })
					I[54] = new("Pose", I[53], "UpperTorso", { Weight = 0 })
						I[55] = new("Pose", I[54], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[56] = new("Pose", I[55], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[57] = new("Keyframe", I[1], "Keyframe", { Time = 2.2 })
			I[58] = new("Pose", I[57], "HumanoidRootPart", { Weight = 0 })
				I[59] = new("Pose", I[58], "LowerTorso", { Weight = 0 })
					I[60] = new("Pose", I[59], "UpperTorso", { Weight = 0 })
						I[61] = new("Pose", I[60], "LeftUpperArm", { CFrame = CFrame.new(0.3992119, -0.2476492, -0.1693096, 0.8705814, -0.4870869, -0.0695287, 0.1798465, 0.4465578, -0.8764937, 0.4579772, 0.7505546, 0.4763658), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[62] = new("Pose", I[61], "LeftLowerArm", { CFrame = CFrame.new(-0.0000038, 0, -0.0000029, 0.7746839, -0.6305664, -0.0474405, 0.5936416, 0.7510598, -0.2889613, 0.2178399, 0.1956911, 0.9561645), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[63] = new("Keyframe", I[1], "DealBanker", { Time = 2.4333334 })
			I[64] = new("Pose", I[63], "HumanoidRootPart", { Weight = 0 })
				I[65] = new("Pose", I[64], "LowerTorso", { Weight = 0 })
					I[66] = new("Pose", I[65], "UpperTorso", { Weight = 0 })
						I[67] = new("Pose", I[66], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[68] = new("Pose", I[67], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[69] = new("Keyframe", I[1], "Keyframe", { Time = 2.6666667 })
			I[70] = new("Pose", I[69], "HumanoidRootPart", { Weight = 0 })
				I[71] = new("Pose", I[70], "LowerTorso", { Weight = 0 })
					I[72] = new("Pose", I[71], "UpperTorso", { CFrame = CFrame.new(-0.0000305, 0, -0.0000076, 0.936608, 0, 0.3503789, 0, 1, 0, -0.3503789, 0, 0.936608), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[73] = new("Pose", I[72], "LeftUpperArm", { CFrame = CFrame.new(0.3992147, -0.247647, -0.1693058, 0.95959, -0.2744831, 0.062016, 0.1293295, 0.2344463, -0.9634879, 0.2499216, 0.9325736, 0.260471), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[74] = new("Pose", I[73], "LeftLowerArm", { CFrame = CFrame.new(-0.000001, 0, -0.0000029, 0.999824, 0.011878, 0.0144862, -0.0110275, 0.9982876, -0.057448, -0.0151439, 0.0572783, 0.9982432), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[75] = new("Pose", I[71], "CardDeck", { CFrame = CFrame.new(-1.7752075, 1.5245972, -0.2240334, 0.2958191, 0.9144309, 0.2762375, -0.9551332, 0.2787447, 0.1001096, 0.0145436, -0.293458, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[76] = new("Keyframe", I[1], "Keyframe", { Time = 3.0666666 })
			I[77] = new("Pose", I[76], "HumanoidRootPart", { Weight = 0 })
				I[78] = new("Pose", I[77], "LowerTorso", { Weight = 0 })
					I[79] = new("Pose", I[78], "UpperTorso", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[80] = new("Pose", I[79], "LeftUpperArm", { CFrame = CFrame.new(0.1428604, -0.247649, 0.0497456, 0.7533523, -0.6354809, -0.1691869, 0.1798466, 0.446558, -0.8764937, 0.6325468, 0.6298809, 0.4507045), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[81] = new("Pose", I[80], "LeftLowerArm", { CFrame = CFrame.new(-0.0000048, 0, -0.0000019, 0.9999999, 0.0000001, 0, 0.0000001, 0.9730667, -0.2305232, 0, 0.2305231, 0.9730669), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[82] = new("Pose", I[79], "RightUpperArm", { CFrame = CFrame.new(0.162756, 0.0193932, 0.0344, 0.7870222, 0.602545, 0.1324215, -0.4275275, 0.6874404, -0.5870656, -0.4447653, 0.4054198, 0.7986355), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[83] = new("Pose", I[82], "RightLowerArm", { CFrame = CFrame.new(0.0000057, 0, 0.0000019, 0.9997995, 0.0042524, 0.0195512, 0.009962, 0.7416221, -0.6707435, -0.017352, 0.6708041, 0.7414312), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[84] = new("Pose", I[78], "CardDeck", { CFrame = CFrame.new(-1.2306213, 1.1608887, -0.2240334, 0.6117252, 0.758797, 0.2236499, -0.7909365, 0.5814718, 0.1905512, 0.0145436, -0.2934579, 0.9558613), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[85] = new("Pose", I[78], "RightUpperLeg", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[86] = new("AnimationRigData", I[1], "DealerAnimationRigData")
	return I[1]
end

return build
