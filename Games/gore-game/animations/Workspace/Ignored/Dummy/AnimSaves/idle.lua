-- Generated from animations/Workspace/Ignored/Dummy/AnimSaves/idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "idle", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1916996, -0.3390401, -0.2600343, -0.0050036, -0.9910373, 0.1334914, 0.9933912, 0.0103816, 0.1143073, -0.1146687, 0.1331811, 0.9844358) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3846902, -0.5021126, -1.0484142, -0.1135556, 0.6092504, -0.7848052, -0.9923124, -0.0304253, 0.1199609, 0.0492083, 0.792394, 0.6080216) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 4 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(0.1916996, -0.3390401, -0.2600343, -0.0050036, -0.9910373, 0.1334914, 0.9933912, 0.0103816, 0.1143073, -0.1146687, 0.1331811, 0.9844358) })
						I[12] = new("Pose", I[11], "Handle", { CFrame = CFrame.new(-0.1101837, -0.9621811, -0.3270903, 0.9864975, 0.1045293, -0.1260803, 0.127705, -0.0089711, 0.9917716, 0.1025381, -0.9944813, -0.0221989) })
					I[13] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(-0.3846902, -0.5021126, -1.0484142, -0.1135556, 0.6092504, -0.7848052, -0.9923124, -0.0304253, 0.1199609, 0.0492083, 0.792394, 0.6080216) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(0.1917, -0.3390393, -0.2600326, 0.0360466, -0.9903904, 0.1335201, 0.9921089, 0.0515193, 0.1143053, -0.1200857, 0.1283462, 0.9844322) })
					I[18] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.3846902, -0.5021119, -1.0484111, -0.0796969, 0.6146351, -0.7847754, -0.9924721, 0.024519, 0.1199924, 0.0929935, 0.7884306, 0.6080538) })
	return I[1]
end

return build
