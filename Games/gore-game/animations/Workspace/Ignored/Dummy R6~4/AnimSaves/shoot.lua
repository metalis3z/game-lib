-- Generated from animations/Workspace/Ignored/Dummy R6~4/AnimSaves/shoot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "shoot", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.6964473, -0.4288626, -0.3045461, -0.1781079, -0.949933, 0.2567198, 0.9839905, -0.1736217, 0.0402284, 0.0063579, 0.2597748, 0.9656483) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
							I[7] = new("Pose", I[6], "Bolt", { CFrame = CFrame.new(0.0000002, 0, 0.0000002) })
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.973004, -0.4482087, -1.0630662, -0.3894575, 0.7040235, -0.5938634, -0.9196215, -0.2614053, 0.2931953, 0.0511774, 0.6603166, 0.7492415) })
					I[9] = new("Pose", I[4], "Head")
			I[10] = new("Pose", I[2], "Mag6D", { CFrame = CFrame.new(-0.0000003, 0, 0.0000011) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { Weight = 0 })
					I[14] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(-0.7502963, -0.4822416, -0.1619127, -0.2521762, -0.8963577, 0.3646231, 0.9640434, -0.265353, 0.0144191, 0.0838291, 0.3551487, 0.9310436) })
						I[15] = new("Pose", I[14], "Handle", { CFrame = CFrame.new(-0.1449069, -0.9482567, -0.1923436, -0.2708744, -0.9453714, -0.181383, 0.9230772, -0.3085439, 0.2296284, -0.2730488, -0.1052301, 0.9562275) })
							I[16] = new("Pose", I[15], "Bolt", { CFrame = CFrame.new(0.3500113, -0.0000267, -0.0000019) })
					I[17] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-0.9519645, -0.5904416, -1.1956478, -0.4500861, 0.8586633, -0.2451947, -0.8670141, -0.3544604, 0.350207, 0.2137981, 0.3702104, 0.9040103) })
					I[18] = new("Pose", I[13], "Head")
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "Torso", { Weight = 0 })
					I[22] = new("Pose", I[21], "Right Arm", { CFrame = CFrame.new(-0.7273703, -0.3852071, -0.1611941, -0.0793929, -0.9496722, 0.3030177, 0.9960974, -0.063821, 0.0609671, -0.0385599, 0.3066754, 0.9510328) })
						I[23] = new("Pose", I[22], "Handle", { CFrame = CFrame.new(-0.1007538, -0.8125048, -0.216583, -0.2785757, -0.9524706, -0.12327, 0.9589188, -0.2830014, 0.0196249, -0.0535777, -0.1127389, 0.9921791) })
					I[24] = new("Pose", I[21], "Left Arm", { CFrame = CFrame.new(-0.8886513, -0.5601816, -1.1213413, -0.2919649, 0.7518233, -0.5912007, -0.9563327, -0.2207093, 0.1916119, 0.0135748, 0.6213285, 0.7834325) })
		I[25] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[26] = new("Pose", I[25], "HumanoidRootPart", { Weight = 0 })
				I[27] = new("Pose", I[26], "Torso", { Weight = 0 })
					I[28] = new("Pose", I[27], "Right Arm", { CFrame = CFrame.new(-0.5999859, -0.3999256, -0.2000026, -0.1269083, -0.9548316, 0.2686838, 0.9854813, -0.0905713, 0.143609, -0.1127874, 0.283008, 0.9524629) })
						I[29] = new("Pose", I[28], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
							I[30] = new("Pose", I[29], "Bolt", { CFrame = CFrame.new(0.0000002, 0, 0.0000002) })
					I[31] = new("Pose", I[27], "Left Arm", { CFrame = CFrame.new(-0.9999839, -0.5998649, -1.0999819, -0.3408877, 0.7235741, -0.6001967, -0.9382147, -0.3023012, 0.1684255, -0.0595719, 0.6205276, 0.7819186) })
			I[32] = new("Pose", I[25], "Mag6D", { CFrame = CFrame.new(-0.0000003, 0, 0.0000011) })
	return I[1]
end

return build
