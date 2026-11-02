-- Generated from animations/Workspace/Ignored/Dummy R6~3/AnimSaves/blockstart.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "blockstart", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0735641, -0.2481932, -0.2570173, 0.3521049, -0.7400799, 0.5729784, 0.8006953, 0.5551888, 0.2250614, -0.4846747, 0.3795357, 0.7880629) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.1413142, -0.2100444, -0.7624362, 0.5165043, 0.7217371, -0.4607809, -0.8561469, 0.4449302, -0.2627734, 0.0153621, 0.5302197, 0.8477212) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(-0.0018786, -0.4832168, -0.0977487, 0.143627, -0.9377987, 0.3160774, 0.7639777, 0.3080879, 0.566939, -0.6290543, 0.1600483, 0.760707) })
						I[12] = new("Pose", I[11], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[13] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(-0.2923043, -0.5045438, -0.8409334, 0.0661059, 0.6514294, -0.7558239, -0.9906573, 0.1334, 0.0283299, 0.1192818, 0.7468897, 0.6541618) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(0.0065771, -0.6098996, 0.0242812, 0.048292, -0.9904122, 0.1294273, 0.6983489, 0.1261229, 0.7045579, -0.7141265, 0.0563609, 0.6977441) })
						I[18] = new("Pose", I[17], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.466807, -0.6755379, -0.8777937, -0.2040097, 0.526836, -0.8251206, -0.9723883, -0.0114889, 0.2330857, 0.1133182, 0.8498893, 0.5146331) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { Weight = 0 })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.0193694, -0.6575942, 0.081487, 0.015564, -0.9987416, 0.0476749, 0.6633333, 0.0459908, 0.7469094, -0.7481622, 0.0199996, 0.6632144) })
						I[24] = new("Pose", I[23], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[25] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-0.556478, -0.741696, -0.8948991, -0.3104389, 0.4613672, -0.8311245, -0.9455798, -0.0601976, 0.3197735, 0.0975014, 0.8851647, 0.4549471) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.0200536, -0.6596403, 0.0841277, 0.0142381, -0.9989311, 0.0439753, 0.6616667, 0.0423861, 0.7485991, -0.7496629, 0.0184383, 0.661563) })
						I[30] = new("Pose", I[29], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.5606987, -0.7445556, -0.8957065, -0.3150561, 0.4582645, -0.8311037, -0.944148, -0.0622399, 0.3235904, 0.0965622, 0.886634, 0.4522786) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { Weight = 0 })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.0140113, -0.6401747, 0.0596665, 0.0272917, -0.9965478, 0.0784075, 0.6768582, 0.0761427, 0.7321647, -0.7356073, 0.0330887, 0.6765997) })
						I[36] = new("Pose", I[35], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[37] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-0.5218593, -0.7174233, -0.8882945, -0.2712396, 0.4866458, -0.8304245, -0.9568453, -0.04285, 0.2874211, 0.1042886, 0.8725479, 0.4772674) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { Weight = 0 })
					I[41] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.0092174, -0.6217669, 0.0377942, 0.0399461, -0.9931542, 0.1097673, 0.6902557, 0.1068575, 0.7156315, -0.7224619, 0.0471809, 0.689799) })
						I[42] = new("Pose", I[41], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[43] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(-0.4876556, -0.6919108, -0.88178, -0.2302184, 0.5115467, -0.8278403, -0.9668818, -0.0239259, 0.2541007, 0.1101776, 0.8589224, 0.5001133) })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { Weight = 0 })
				I[46] = new("Pose", I[45], "Torso", { Weight = 0 })
					I[47] = new("Pose", I[46], "Right Arm", { CFrame = CFrame.new(0.0088144, -0.6200504, 0.0358124, 0.0411272, -0.9927926, 0.1125675, 0.691421, 0.1096094, 0.7140888, -0.7212805, 0.048463, 0.6909456) })
						I[48] = new("Pose", I[47], "Handle", { CFrame = CFrame.new(-0.0995525, -1.2993318, -1.0479208, 0.9969192, -0.0780457, -0.0078178, -0.0139785, -0.2748566, 0.9613836, -0.0771806, -0.9583125, -0.2751007) })
					I[49] = new("Pose", I[46], "Left Arm", { CFrame = CFrame.new(-0.4845836, -0.6895391, -0.8811935, -0.2264048, 0.5138232, -0.8274821, -0.9677297, -0.0221659, 0.2510136, 0.1106348, 0.8576096, 0.5022605) })
	return I[1]
end

return build
