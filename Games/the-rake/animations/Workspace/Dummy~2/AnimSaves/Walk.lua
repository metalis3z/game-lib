-- Generated from animations/Workspace/Dummy~2/AnimSaves/Walk.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk", nil, nil, { "1630937581" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.0336068, -0.2212915, 1, 0, 0, 0, 0.988664, -0.1501451, 0, 0.1501451, 0.988664) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000008, 0, 0.9006999, -0.4344418, 0, 0.4344418, 0.9006999, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.2166444, 0.0901533, 0.0000003, 0.9751485, -0.2215519, 0, 0.2215519, 0.9751485, 0, 0, 0, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0696618, -0.1210117, -0.0183649, 0.8800049, 0.3983198, -0.2587133, -0.4267719, 0.9021883, -0.0626254, 0.2084632, 0.1655223, 0.9639219) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0613112, 0.0464858, 0.0052417, 0.8727551, 0.4810538, 0.082981, -0.4825041, 0.8758889, -0.0029134, -0.0740836, -0.037496, 0.9965469) })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9913991, 0.1308731, 0, -0.1308731, 0.9913991), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1428571 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0.0263171, -0.1658106, 1, 0, 0, 0, 0.9914784, -0.1302719, 0, 0.1302719, 0.9914784) })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.6955255, 0.6397009, 0, 0.7691631, -0.6390524, 0, 0.6390524, 0.7691631, 0, 0, 0, 1) })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.0836056, -0.000408, 0, 0.9989442, 0.04594, 0, -0.04594, 0.9989442, 0, 0, 0, 1) })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0747571, -0.0579979, -0.0044959, 0.9843813, 0.0177088, -0.175157, -0.006224, 0.9978067, 0.0659021, 0.1759399, -0.0637826, 0.9823323) })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0370542, -0.004467, -0.0175424, 0.9674849, -0.1580631, 0.1974565, 0.1374839, 0.9839229, 0.1139912, -0.2122998, -0.0831377, 0.9736616) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.2857143 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("Pose", I[18], "Torso", { CFrame = CFrame.new(0, 0.0336068, -0.2212915, 1, 0, 0, 0, 0.988664, -0.1501451, 0, 0.1501451, 0.988664) })
					I[20] = new("Pose", I[19], "Left Leg", { CFrame = CFrame.new(-0.2078987, 0.0614797, 0.0000003, 0.9493736, 0.3141491, 0, -0.3141491, 0.9493736, 0, 0, 0, 1) })
					I[21] = new("Pose", I[19], "Right Leg", { CFrame = CFrame.new(-0.0322912, -0.0144883, 0, 0.8824031, 0.4704943, 0, -0.4704943, 0.8824031, 0, 0, 0, 1) })
					I[22] = new("Pose", I[19], "Left Arm", { CFrame = CFrame.new(0.2096434, -0.1309032, 0.023577, 0.885595, -0.4410282, -0.1456555, 0.4540075, 0.8881505, 0.0711766, 0.0979731, -0.1291623, 0.9867716) })
					I[23] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(0.1447478, -0.1478859, -0.0124851, 0.7545394, -0.5633452, 0.3366193, 0.589878, 0.8069958, 0.0283139, -0.2876008, 0.1772003, 0.9412151) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.4285714 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, 0.0266271, -0.175332, 1, 0, 0, 0, 0.9932232, -0.1162222, 0, 0.1162222, 0.9932232) })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(-0.1030029, 0.0245675, 0, 0.9997506, 0.0223354, 0, -0.0223354, 0.9997506, 0, 0, 0, 1) })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(0.5830361, 0.5995882, 0, 0.8914362, 0.4531461, 0, -0.4531461, 0.8914362, 0, 0, 0, 1) })
					I[29] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(0.061927, -0.0574397, -0.0062896, 0.9818821, 0.0782252, -0.172593, -0.0566374, 0.9903302, 0.1266421, 0.1808307, -0.1145724, 0.976818) })
					I[30] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(0.0258082, -0.0189694, -0.0242451, 0.976425, -0.08699, 0.1975524, 0.0767819, 0.9953142, 0.0587723, -0.2017393, -0.0422183, 0.978529) })
		I[31] = new("Keyframe", I[1], "KF2.6", { Time = 0.5714286 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { Weight = 0 })
				I[33] = new("Pose", I[32], "Torso", { CFrame = CFrame.new(0, 0.0336068, -0.2212915, 1, 0, 0, 0, 0.988664, -0.1501451, 0, 0.1501451, 0.988664) })
					I[34] = new("Pose", I[33], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000017, 0, 0.9007002, -0.4344411, 0, 0.4344411, 0.9007002, 0, 0, 0, 1) })
					I[35] = new("Pose", I[33], "Right Leg", { CFrame = CFrame.new(0.2166445, 0.0901537, 0.0000003, 0.9751486, -0.2215517, 0, 0.2215517, 0.9751486, 0, 0, 0, 1) })
					I[36] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(-0.0696619, -0.1210116, -0.018365, 0.8800049, 0.3983198, -0.2587133, -0.4267719, 0.9021883, -0.0626254, 0.2084632, 0.1655223, 0.9639219) })
					I[37] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(-0.0613112, 0.0464858, 0.0052417, 0.8727551, 0.4810538, 0.082981, -0.4825041, 0.8758889, -0.0029134, -0.0740836, -0.037496, 0.9965469) })
	return I[1]
end

return build
