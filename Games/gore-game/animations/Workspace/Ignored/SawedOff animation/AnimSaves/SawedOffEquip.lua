-- Generated from animations/Workspace/Ignored/SawedOff animation/AnimSaves/SawedOffEquip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "SawedOffEquip", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.1400146, -0.1200008, -0.4299316, 0.4184436, -0.9076532, 0.0327208, 0.9050083, 0.4197204, 0.0692434, -0.0765826, 0.0006381, 0.997063) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.4511719, -0.55896, -0.370697, -0.0511947, 0.0444292, 0.9976999, -0.8234735, -0.5670999, -0.0170008, 0.5650402, -0.8224498, 0.0656188) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.6998291, -1.1999989, -1.0901184, 0.5869786, 0.7362844, -0.336662, -0.8093662, 0.5236194, -0.2659871, -0.0195594, 0.4286116, 0.9032772) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(-0.1400146, -0.1200008, -0.4299316, 0.1717703, -0.9850401, 0.0138188, 0.9821604, 0.1723241, 0.0752686, -0.0765239, 0.0006434, 0.9970675) })
						I[12] = new("Pose", I[11], "Handle", { CFrame = CFrame.new(-0.4512329, -0.5593262, -0.3707428, -0.0093414, 0.0575155, 0.998301, -0.9997089, -0.0227481, -0.0080439, 0.0222468, -0.9980854, 0.0577112) })
					I[13] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(-1.0718384, -0.6019955, -1.0901184, 0.0080226, 0.9034761, -0.4285633, -0.9997758, -0.0011491, -0.0211381, -0.0195902, 0.4286368, 0.9032645) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(-0.1400146, -0.1200008, -0.4299316, -0.0084087, -0.9999647, -0.0000169, 0.9970307, -0.0083853, 0.0765482, -0.0765456, 0.0006268, 0.9970659) })
						I[18] = new("Pose", I[17], "Handle", { CFrame = CFrame.new(-0.4515381, -0.5608521, -0.3709106, -0.007638, 0.0574905, 0.9983169, -0.9999707, -0.0008498, -0.0076016, 0.0004114, -0.9983457, 0.0574954) })
					I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-1.2600708, -0.4599953, -1.0901184, -0.369531, 0.8363563, -0.4049136, -0.929013, -0.3416914, 0.1420634, -0.0195399, 0.4286668, 0.9032513) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { Weight = 0 })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(-0.1400146, -0.1200008, -0.4299316, -0.1293969, -0.9915494, -0.0092902, 0.988634, -0.1297284, 0.0759824, -0.0765454, 0.0006473, 0.9970659) })
					I[24] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-1.2389526, -0.4564934, -1.190155, -0.5190426, 0.7678034, -0.3755962, -0.8545238, -0.4761934, 0.2074339, -0.0195879, 0.428623, 0.9032711) })
	return I[1]
end

return build
