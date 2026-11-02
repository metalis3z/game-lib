-- Generated from animations/ServerStorage/AnimSaves/Flare-Shot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Flare-Shot", { Loop = false }, nil, { "1619825790" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1978109, 0.0053302, -0.0292276, -0.0306801, -0.9940805, 0.1042253, 0.9992082, -0.02786, 0.0284072, -0.0253353, 0.1050143, 0.9941481), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Head", { EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[8] = new("Pose", I[7], "HumanoidRootPart", { Weight = 0 })
				I[9] = new("Pose", I[8], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9585054, 0.2850743, 0, -0.2850743, 0.9585054, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[9], "Right Arm", { CFrame = CFrame.new(0.1965576, 0.005331, -0.0286494, -0.6812909, -0.7234403, 0.1116995, 0.6649258, -0.6754202, -0.318875, 0.3061311, -0.1429747, 0.941192), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[11] = new("Pose", I[9], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9638432, -0.2664701, 0, 0.2664701, 0.9638432, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[13] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[14] = new("Pose", I[13], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9416539, 0.3365828, 0, -0.3365828, 0.9416539, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[15] = new("Pose", I[14], "Right Arm", { CFrame = CFrame.new(0.1969287, 0.0053312, -0.0284411, -0.7753947, -0.6255214, 0.0865214, 0.5576535, -0.7425755, -0.3709504, 0.2962861, -0.2393841, 0.9246133), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[16] = new("Pose", I[14], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9396588, -0.3421132, 0, 0.3421132, 0.9396588, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("Pose", I[18], "Torso")
					I[20] = new("Pose", I[19], "Right Arm")
					I[21] = new("Pose", I[19], "Head")
	return I[1]
end

return build
