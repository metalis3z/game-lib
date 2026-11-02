-- Generated from animations/ServerStorage/MediumSmacks/AnimSaves/Eerie_Equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Eerie_Equip", { Loop = false }, nil, { "1618105502" })
		I[2] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[3] = new("Pose", I[2], "HHandle", { CFrame = CFrame.new(0, 1.2, -1.0000001) })
			I[4] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[5] = new("Pose", I[4], "Torso", { Weight = 0 })
					I[6] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0.2516869, -0.2659064, -0.3827918, -0.2532127, -0.9047398, 0.3425335, 0.7425312, -0.4087203, -0.5306552, 0.6201053, 0.1199732, 0.7752907) })
					I[7] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.2516869, -0.2659063, -0.3827916, -0.2532128, 0.9047397, -0.3425334, -0.7425311, -0.4087204, -0.5306553, -0.6201054, 0.119973, 0.7752907) })
		I[8] = new("Keyframe", I[1], "Keyframe")
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[12] = new("Pose", I[10], "Left Arm", { EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
