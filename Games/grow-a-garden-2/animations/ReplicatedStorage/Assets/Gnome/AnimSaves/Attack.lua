-- Generated from animations/ReplicatedStorage/Assets/Gnome/AnimSaves/Attack.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Attack", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "Right Arm")
					I[8] = new("Pose", I[5], "Left Arm")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("IntValue", I[10], "Null")
				I[12] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[13] = new("IntValue", I[12], "Null")
					I[14] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0, 0, 0, -0.4440957, 0.8959793, 0, -0.8959793, -0.4440957, 0, 0, 0, 1) })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0, 0, 0, -0.4440957, 0.8959793, 0, -0.8959793, -0.4440957, 0, 0, 0, 1) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("IntValue", I[17], "Null")
				I[19] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[20] = new("IntValue", I[19], "Null")
					I[21] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(0, 0, 0, -0.939701, -0.3419984, 0, 0.3419984, -0.939701, 0, 0, 0, 1) })
					I[22] = new("Pose", I[19], "Left Arm", { CFrame = CFrame.new(0, 0, 0, -0.939701, -0.3419984, 0, 0.3419984, -0.939701, 0, 0, 0, 1) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[24] = new("Pose", I[23], "HumanoidRootPart", { Weight = 0 })
				I[25] = new("IntValue", I[24], "Null")
				I[26] = new("Pose", I[24], "Torso", { Weight = 0 })
					I[27] = new("IntValue", I[26], "Null")
					I[28] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(-0.2268556, -0.2392416, 0, 0.7660612, 0.6427676, 0, -0.6427676, 0.7660612, 0, 0, 0, 1) })
					I[29] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.2268556, -0.2392416, 0, 0.7660612, 0.6427676, 0, -0.6427676, 0.7660612, 0, 0, 0, 1) })
	return I[1]
end

return build
