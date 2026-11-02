-- Generated from animations/Workspace/Ignored/SawedOff animation/AnimSaves/SawedOffFire.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "SawedOffFire", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.1400146, -0.1200008, -0.4299316, -0.0084087, -0.9999647, -0.0000169, 0.9970307, -0.0083853, 0.0765482, -0.0765456, 0.0006268, 0.9970659) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.4515381, -0.5608521, -0.3709106, -0.007638, 0.0574905, 0.9983169, -0.9999707, -0.0008498, -0.0076016, 0.0004114, -0.9983457, 0.0574954) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-1.2600708, -0.4599953, -1.0901184, -0.369531, 0.8363563, -0.4049136, -0.929013, -0.3416914, 0.1420634, -0.0195399, 0.4286668, 0.9032513) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(-0.380188, -0.1200008, -0.4299316, -0.144896, -0.9894329, 0.0052681, 0.9887083, -0.1449915, -0.0378595, 0.0382233, -0.0002771, 0.9992692) })
						I[12] = new("Pose", I[11], "Handle", { CFrame = CFrame.new(-0.4532776, -0.5667114, -0.4204407, -0.0031868, 0.0577878, 0.9983239, -0.9928249, -0.1195188, 0.0037491, 0.119535, -0.9911488, 0.057754) })
					I[13] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(-1.0198975, -0.4599934, -1.0901184, -0.6490668, 0.6974045, -0.3038738, -0.7557297, -0.5453923, 0.362519, 0.087092, 0.4649455, 0.8810452) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(-0.380188, -0.1200008, -0.4299316, -0.1859356, -0.9825312, -0.0077652, 0.9718811, -0.1850709, 0.145588, -0.1444819, 0.0195232, 0.9893149) })
						I[18] = new("Pose", I[17], "Handle", { CFrame = CFrame.new(-0.4515381, -0.5608521, -0.3709106, -0.007638, 0.0574905, 0.9983169, -0.9999707, -0.0008498, -0.0076016, 0.0004114, -0.9983457, 0.0574954) })
					I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-1.2301636, -0.4599934, -1.0901489, -0.7105865, 0.6529558, -0.2621377, -0.7026623, -0.6392077, 0.3125381, 0.0365132, 0.4062795, 0.9130191) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { Weight = 0 })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(-0.1400146, -0.1200008, -0.4299316, -0.0084087, -0.9999647, -0.0000169, 0.9970307, -0.0083853, 0.0765482, -0.0765456, 0.0006268, 0.9970659) })
						I[24] = new("Pose", I[23], "Handle", { CFrame = CFrame.new(-0.4515381, -0.5608521, -0.3709106, -0.007638, 0.0574905, 0.9983169, -0.9999707, -0.0008498, -0.0076016, 0.0004114, -0.9983457, 0.0574954) })
					I[25] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-1.2600708, -0.4599953, -1.0901184, -0.369531, 0.8363563, -0.4049136, -0.929013, -0.3416914, 0.1420634, -0.0195399, 0.4286668, 0.9032513) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.380188, -0.1200008, -0.4299316, -0.0084077, -0.9999647, 0.0000386, 0.9992346, -0.0084029, -0.0382035, 0.0382025, -0.0002827, 0.99927) })
					I[30] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-1.0198975, -0.4599953, -1.0901184, -0.3695023, 0.8363765, -0.4048982, -0.9251437, -0.2902985, 0.2446145, 0.0870485, 0.4649746, 0.8810341) })
	return I[1]
end

return build
