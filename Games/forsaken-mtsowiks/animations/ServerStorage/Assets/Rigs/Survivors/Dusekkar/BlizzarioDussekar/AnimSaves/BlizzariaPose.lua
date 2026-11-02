-- Generated from animations/ServerStorage/Assets/Rigs/Survivors/Dusekkar/BlizzarioDussekar/AnimSaves/BlizzariaPose.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "BlizzariaPose", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(-0.0000032, 0.0000033, 0.9100004, 0.8148205, 0.5691722, 0.1100483, -0.5726482, 0.8198012, -0.0000227, -0.0902307, -0.0630004, 0.9939262), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0.001436, 0.0080935, -0.028852, 0.8747513, -0.4822035, -0.0478525, 0.4534944, 0.8494443, -0.269791, 0.1707422, 0.2142992, 0.9617292), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.5526909, 0.3265876, 0.1388755, 0.8906301, -0.4145713, 0.1868385, 0.3573662, 0.8921994, 0.2761696, -0.2811892, -0.1791952, 0.9427734), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.0402923, -0.6361216, -0.0577257, -0.1817667, -0.6019238, 0.7775915, 0.9043833, 0.2081345, 0.3725196, -0.386072, 0.7709524, 0.506538), EasingStyle = Enum.PoseEasingStyle.Constant })
						I[9] = new("Pose", I[8], "Staff", { CFrame = CFrame.new(-0.2152777, 0.1945667, 0.1006281, -0.2322475, -0.3577777, -0.9044645, 0.0347923, 0.92624, -0.3753253, 0.9720342, -0.1186368, -0.202669), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[10] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.1044134, -0.9850314, -0.0272263, -0.8356388, 0.5011607, 0.2248254, -0.444496, -0.8574506, 0.2592343, 0.3226947, 0.1166922, 0.9392822), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[11] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.5738604, 0.3329702, 0.0105379, 0.842785, 0.5179338, -0.1464855, -0.510932, 0.8554145, 0.0849387, 0.1692985, 0.003259, 0.9855595), EasingStyle = Enum.PoseEasingStyle.Constant })
	return I[1]
end

return build
