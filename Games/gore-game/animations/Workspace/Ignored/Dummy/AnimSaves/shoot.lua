-- Generated from animations/Workspace/Ignored/Dummy/AnimSaves/shoot.rbxm by _tools/rbxm2lua.luau
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
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1916996, -0.3390401, -0.2600343, -0.0050036, -0.9910373, 0.1334914, 0.9933912, 0.0103816, 0.1143073, -0.1146687, 0.1331811, 0.9844358) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
							I[7] = new("Pose", I[6], "Slide", { CFrame = CFrame.new(0.0002747, -0.0000029, 0.2799797) })
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3846902, -0.5021126, -1.0484142, -0.1135556, 0.6092504, -0.7848052, -0.9923124, -0.0304253, 0.1199609, 0.0492083, 0.792394, 0.6080216) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(0.1916996, -0.3390401, -0.2600343, -0.0050036, -0.9910373, 0.1334914, 0.9933912, 0.0103816, 0.1143073, -0.1146687, 0.1331811, 0.9844358) })
						I[13] = new("Pose", I[12], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
							I[14] = new("Pose", I[13], "Slide", { CFrame = CFrame.new(0.0002747, -0.0000029, 0) })
					I[15] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.3846902, -0.5021126, -1.0484142, -0.1135556, 0.6092504, -0.7848052, -0.9923124, -0.0304253, 0.1199609, 0.0492083, 0.792394, 0.6080216) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[19] = new("Pose", I[18], "Right Arm", { Weight = 0 })
						I[20] = new("Pose", I[19], "Handle", { Weight = 0 })
							I[21] = new("Pose", I[20], "Slide", { CFrame = CFrame.new(0.0002747, -0.0000029, 0) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.0333333 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("Pose", I[23], "Torso", { Weight = 0 })
					I[25] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(0.1027916, -0.3448585, -0.2472966, -0.0798019, -0.9878283, 0.1335178, 0.9913393, -0.0646338, 0.1143188, -0.1042975, 0.1414843, 0.9844309) })
					I[26] = new("Pose", I[24], "Left Arm", { CFrame = CFrame.new(-0.2875783, -0.5194455, -0.985453, -0.1644812, 0.5975363, -0.7847905, -0.9862204, -0.1139486, 0.119938, -0.0177585, 0.7937039, 0.6080449) })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 })
				I[29] = new("Pose", I[28], "Torso", { Weight = 0 })
					I[30] = new("Pose", I[29], "Right Arm", { CFrame = CFrame.new(0.1629317, -0.2905703, -0.261792, 0.0547227, -0.9895319, 0.1335368, 0.9909621, 0.0702252, 0.1142907, -0.1224719, 0.1260756, 0.9844316) })
					I[31] = new("Pose", I[29], "Left Arm", { CFrame = CFrame.new(-0.329636, -0.5172572, -1.0413866, -0.0750029, 0.6009842, -0.795734, -0.9970301, -0.0312052, 0.0704083, 0.0174832, 0.7986516, 0.6015397) })
	return I[1]
end

return build
