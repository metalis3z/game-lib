-- Generated from animations/ServerStorage/AnimSaves/Flare-Equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Flare-Equip", { Loop = false }, nil, { "1619825082" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0000212, -0.0000004, 0.0000158, 0.8453091, 0.4191907, -0.3312576, -0.4985012, 0.8418794, -0.2067262, 0.1922212, 0.3398799, 0.9206154) })
		I[6] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[7] = new("Pose", I[6], "HumanoidRootPart", { Weight = 0 })
				I[8] = new("Pose", I[7], "Torso", { Weight = 0 })
					I[9] = new("Pose", I[8], "Right Arm", { CFrame = CFrame.new(0.0000212, -0.0000004, 0.0000158, 0.8453091, 0.4191907, -0.3312576, -0.4985012, 0.8418794, -0.2067262, 0.1922212, 0.3398799, 0.9206154), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.1978109, 0.0053302, -0.0292276, -0.0306801, -0.9940805, 0.1042253, 0.9992082, -0.02786, 0.0284072, -0.0253353, 0.1050143, 0.9941481) })
	return I[1]
end

return build
