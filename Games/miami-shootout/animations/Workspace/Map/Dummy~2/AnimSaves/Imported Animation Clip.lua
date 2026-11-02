-- Generated from animations/Workspace/Map/Dummy~2/AnimSaves/Imported Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Imported Animation Clip", { Loop = false, Priority = Enum.AnimationPriority.Action2 }, nil, { "1682047476" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0, -0.3420202, 0, 1, 0, 0.3420202, 0, 0.9396926) })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0, 0.0509489, 0.0002441, 0.8834912, 0.2043411, -0.4215307, -0.4578435, 0.5670435, -0.6847197, 0.0991099, 0.7979389, 0.5945342) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0.0001221, 0.0001831, 0.000061, 0.8385486, -0.5230242, 0.1525851, 0.186115, 0.0117739, -0.9824576, 0.5120524, 0.8522366, 0.1072156) })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0, 0, 0, 0.9993443, -0.0323771, 0.0161862, 0.0328374, 0.9990391, -0.0290284, -0.0152309, 0.0295408, 0.9994475) })
						I[9] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0.0001221, 0.9659258, 0, 0.2588188, 0, 1, 0, -0.2588188, 0, 0.9659258) })
						I[10] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0.0002441, -0.0000153, 0.0001831, 0.3427888, -0.1216318, 0.9315049, 0.6807869, 0.7154344, -0.1571076, -0.6473215, 0.6880111, 0.3280482) })
							I[11] = new("Pose", I[10], "RightLowerArm", { CFrame = CFrame.new(-0.000061, 0.0001831, 0.000061, 0.9823674, 0.0046444, 0.1869049, 0.1759064, -0.36164, -0.9155729, 0.0633402, 0.9323064, -0.3560801) })
								I[12] = new("Pose", I[11], "RightHand", { CFrame = CFrame.new(0, 0, 0, 0.9981948, 0.0441993, -0.0406622, -0.047163, 0.9960619, -0.0750764, 0.0371836, 0.0768589, 0.9963484) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[14] = new("Pose", I[13], "HumanoidRootPart", { Weight = 0 })
				I[15] = new("Pose", I[14], "LowerTorso", { Weight = 0 })
					I[16] = new("Pose", I[15], "UpperTorso", { CFrame = CFrame.new(-0.0001221, -0.0000207, -0.0001221, 0.6817408, -0.1561187, 0.7147422, -0.0842706, 0.9537054, 0.2886943, -0.726724, -0.2570464, 0.6370236) })
						I[17] = new("Pose", I[16], "LeftUpperArm", { CFrame = CFrame.new(-0.0000305, 0.0510254, 0.0002441, 0.8834913, 0.38773, -0.262886, -0.4578434, 0.833434, -0.3094628, 0.0991098, 0.3937681, 0.9138511) })
						I[18] = new("Pose", I[16], "RightUpperArm", { CFrame = CFrame.new(0.1998596, 0.1036377, -0.4006348, -0.0195706, -0.4950702, 0.8686327, 0.9984042, -0.0557119, -0.0092582, 0.0529765, 0.8670651, 0.4953703) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.4166667 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "UpperTorso", { Weight = 0 })
						I[23] = new("Pose", I[22], "LeftUpperArm", { CFrame = CFrame.new(0, 0.0509949, 0.0002441, 0.5948564, 0.7366611, -0.3216777, -0.7830041, 0.4405157, -0.4391475, -0.1817987, 0.5131046, 0.8388522) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.875 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "LowerTorso", { Weight = 0 })
					I[27] = new("Pose", I[26], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.9396926, 0, -0.3420202, 0, 1, 0, 0.3420202, 0, 0.9396926) })
						I[28] = new("Pose", I[27], "LeftUpperArm", { CFrame = CFrame.new(0, 0.0509489, 0.0002441, 0.8834912, 0.2043411, -0.4215307, -0.4578435, 0.5670435, -0.6847197, 0.0991099, 0.7979389, 0.5945342) })
							I[29] = new("Pose", I[28], "LeftLowerArm", { CFrame = CFrame.new(0.0001221, 0.0001831, 0.000061, 0.8385486, -0.5230242, 0.1525851, 0.186115, 0.0117739, -0.9824576, 0.5120524, 0.8522366, 0.1072156) })
								I[30] = new("Pose", I[29], "LeftHand", { CFrame = CFrame.new(0, 0, 0, 0.9993443, -0.0323771, 0.0161862, 0.0328374, 0.9990391, -0.0290284, -0.0152309, 0.0295408, 0.9994475) })
						I[31] = new("Pose", I[27], "Head", { CFrame = CFrame.new(0, 0, 0.0001221, 0.9659258, 0, 0.2588188, 0, 1, 0, -0.2588188, 0, 0.9659258) })
						I[32] = new("Pose", I[27], "RightUpperArm", { CFrame = CFrame.new(0.0002441, -0.0000153, 0.0001831, 0.3427888, -0.1216318, 0.9315049, 0.6807869, 0.7154344, -0.1571076, -0.6473215, 0.6880111, 0.3280482) })
							I[33] = new("Pose", I[32], "RightLowerArm", { CFrame = CFrame.new(-0.000061, 0.0001831, 0.000061, 0.9823674, 0.0046444, 0.1869049, 0.1759064, -0.36164, -0.9155729, 0.0633402, 0.9323064, -0.3560801) })
								I[34] = new("Pose", I[33], "RightHand", { CFrame = CFrame.new(0, 0, 0, 0.9981948, 0.0441993, -0.0406622, -0.047163, 0.9960619, -0.0750764, 0.0371836, 0.0768589, 0.9963484) })
		I[35] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[36] = new("Pose", I[35], "HumanoidRootPart", { Weight = 0 })
				I[37] = new("Pose", I[36], "LowerTorso", { Weight = 0 })
					I[38] = new("Pose", I[37], "UpperTorso", { CFrame = CFrame.new(0.000061, -0.0000064, -0.000061, 0.8191522, -0.2424037, 0.5198366, 0, 0.9063079, 0.4226182, -0.5735762, -0.3461885, 0.7424042) })
						I[39] = new("Pose", I[38], "Head", { CFrame = CFrame.new(-0.0000305, 0.0000005, 0.0002441, 0.7660438, 0, -0.6427885, 0, 1, 0, 0.6427885, 0, 0.7660438) })
						I[40] = new("Pose", I[38], "RightUpperArm", { CFrame = CFrame.new(0.0722351, 0.1080017, -0.3024902, -0.1140034, -0.7438239, 0.6585813, 0.9821032, -0.1844134, -0.0382762, 0.149922, 0.6424311, 0.7515356) })
							I[41] = new("Pose", I[40], "RightLowerArm", { CFrame = CFrame.new(0, 0.0001221, 0, 0.9823667, -0.181738, -0.0438888, 0.1759063, 0.9779747, -0.1123494, 0.0633402, 0.1026481, 0.992699) })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "LowerTorso", { Weight = 0 })
					I[45] = new("Pose", I[44], "UpperTorso", { CFrame = CFrame.new(0.000061, 0.000047, 0.000061, 0.9251599, -0.2354776, -0.2977074, 0.2663634, 0.961526, 0.0672166, 0.2704254, -0.1414844, 0.952288) })
						I[46] = new("Pose", I[45], "RightUpperArm", { CFrame = CFrame.new(0.0241699, 0.0359497, -0.100769, 0.2684406, -0.9001172, 0.3431162, 0.8828211, 0.3724016, 0.286259, -0.3854436, 0.2260664, 0.89461) })
	return I[1]
end

return build
