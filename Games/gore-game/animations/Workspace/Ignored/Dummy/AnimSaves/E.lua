-- Generated from animations/Workspace/Ignored/Dummy/AnimSaves/E.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "E", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1917126, -0.339039, -0.2600195, 0.5810099, -0.80287, 0.1335193, 0.7956778, 0.5948249, 0.1143686, -0.1712437, 0.0397891, 0.9844249) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
							I[7] = new("Pose", I[6], "Slide")
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3846861, -0.5021107, -1.0484049, 0.3485269, 0.5124012, -0.7848401, -0.7257568, 0.6774095, 0.1199731, 0.5931325, 0.5277891, 0.6079741) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { Weight = 0 })
						I[13] = new("Pose", I[12], "Handle", { CFrame = CFrame.new(-0.1054001, -0.9519005, -0.3860035, 0.9865056, 0.0798493, -0.1429359, 0.1276747, 0.1713542, 0.9769017, 0.1024976, -0.9819683, 0.1588471) })
							I[14] = new("Pose", I[13], "Slide", { CFrame = CFrame.new(0.0000687, -0.0000124, 0.2999878) })
					I[15] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-1.0750434, -1.056151, -0.6262707, -0.9922144, 0.0566765, 0.1108983, 0.0952535, -0.2283047, 0.9689188, 0.0802335, 0.9719386, 0.2211286) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[19] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0.5463259, -0.5408445, -0.2847283, 0.2587126, -0.9566809, 0.1335267, 0.9548559, 0.2741793, 0.11435, -0.1460067, 0.0979149, 0.9844261) })
						I[20] = new("Pose", I[19], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-1.0750437, -1.0561481, -0.6262745, -0.9658091, -0.2343474, 0.1108787, 0.157516, -0.1907324, 0.968922, -0.2059162, 0.9532589, 0.2211245) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.5666667 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("Pose", I[23], "Torso", { Weight = 0 })
					I[25] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(0.1916996, -0.3390401, -0.2600343, -0.0050036, -0.9910373, 0.1334914, 0.9933912, 0.0103816, 0.1143073, -0.1146687, 0.1331811, 0.9844358) })
						I[26] = new("Pose", I[25], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
					I[27] = new("Pose", I[24], "Left Arm", { CFrame = CFrame.new(-0.3846902, -0.5021126, -1.0484142, -0.1135556, 0.6092504, -0.7848052, -0.9923124, -0.0304253, 0.1199609, 0.0492083, 0.792394, 0.6080216) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(0.47322, -0.883706, -0.1073803, -0.2179202, -0.9710199, 0.0981386, 0.9429762, -0.1835631, 0.2776698, -0.2516082, 0.1530523, 0.9556507) })
						I[32] = new("Pose", I[31], "Handle", { Weight = 0 })
							I[33] = new("Pose", I[32], "Slide")
					I[34] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.8017656, -1.0645455, -0.726511, -0.9042974, 0.4122559, 0.1108702, 0.0060318, -0.2473433, 0.9689094, 0.4268615, 0.8768505, 0.2211847) })
		I[35] = new("Keyframe", I[1], "Keyframe", { Time = 0.3666667 })
			I[36] = new("Pose", I[35], "HumanoidRootPart", { Weight = 0 })
				I[37] = new("Pose", I[36], "Torso", { Weight = 0 })
					I[38] = new("Pose", I[37], "Right Arm", { CFrame = CFrame.new(0.5237336, -0.6749983, -0.2660705, 0.0570762, -0.9876242, 0.1460853, 0.9522402, 0.0978172, 0.2892586, -0.2999685, 0.1225984, 0.9460384) })
						I[39] = new("Pose", I[38], "Handle", { Weight = 0 })
							I[40] = new("Pose", I[39], "Slide")
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[42] = new("Pose", I[41], "HumanoidRootPart", { Weight = 0 })
				I[43] = new("Pose", I[42], "Torso", { Weight = 0 })
					I[44] = new("Pose", I[43], "Right Arm", { CFrame = CFrame.new(0.5173358, -0.9820829, -0.0106584, -0.2612755, -0.962518, 0.0727608, 0.9124313, -0.2216759, 0.3439897, -0.314967, 0.1562653, 0.9361501) })
		I[45] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[46] = new("Pose", I[45], "HumanoidRootPart", { Weight = 0 })
				I[47] = new("Pose", I[46], "Torso", { Weight = 0 })
					I[48] = new("Pose", I[47], "Right Arm", { CFrame = CFrame.new(0.496308, -0.857913, 0.0161659, -0.2960023, -0.9527413, 0.0683133, 0.9084015, -0.2586745, 0.3284727, -0.2952786, 0.1592845, 0.9420398) })
		I[49] = new("Keyframe", I[1], "Keyframe", { Time = 0.4666667 })
			I[50] = new("Pose", I[49], "HumanoidRootPart", { Weight = 0 })
				I[51] = new("Pose", I[50], "Torso", { Weight = 0 })
					I[52] = new("Pose", I[51], "Left Arm", { CFrame = CFrame.new(-0.7711667, -1.4318745, -0.8314148, -0.9693729, -0.0349132, -0.2431009, -0.2316615, -0.1986808, 0.9522917, -0.081547, 0.9794424, 0.1845073) })
		I[53] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[54] = new("Pose", I[53], "HumanoidRootPart", { Weight = 0 })
				I[55] = new("Pose", I[54], "Torso", { Weight = 0 })
					I[56] = new("Pose", I[55], "Left Arm", { CFrame = CFrame.new(-0.4257738, -1.4223042, -1.0261737, -0.8057835, 0.2058239, -0.5552928, -0.5916341, -0.2384089, 0.7701498, 0.0261285, 0.9491038, 0.313878) })
		I[57] = new("Keyframe", I[1], "Keyframe", { Time = 0.5333334 })
			I[58] = new("Pose", I[57], "HumanoidRootPart", { Weight = 0 })
				I[59] = new("Pose", I[58], "Torso", { Weight = 0 })
					I[60] = new("Pose", I[59], "Left Arm", { CFrame = CFrame.new(-0.5707102, -1.2467108, -1.0133204, -0.5014784, 0.4348797, -0.7479299, -0.862116, -0.1786041, 0.4741905, 0.0726325, 0.8825986, 0.4644828) })
	return I[1]
end

return build
