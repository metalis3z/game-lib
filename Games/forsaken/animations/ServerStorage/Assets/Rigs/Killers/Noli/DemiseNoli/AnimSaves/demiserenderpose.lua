-- Generated from animations/ServerStorage/Assets/Rigs/Killers/Noli/DemiseNoli/AnimSaves/demiserenderpose.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "demiserenderpose", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(-0.0000009, -0.0000011, -0.2668053, 0.9881206, -0.0970988, -0.1191132, 0.0942498, 0.9951154, -0.029336, 0.1213801, 0.0177611, 0.9924471) })
					I[6] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(0.2148611, -0.1802376, 0.1089275, 0.9204955, -0.2787063, -0.2738715, 0.2923748, 0.9562556, 0.0095538, 0.2592286, -0.0888669, 0.9617167) })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-1.2287257, 0.190012, 0.3919325, 0.9999574, 0.0091624, 0.0011214, -0.0092291, 0.9946729, 0.1026679, -0.0001747, -0.1026739, 0.994715) })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.1770217, -0.1616128, 0.0124887, 0.8585632, 0.5057395, -0.0841916, -0.4698551, 0.8418554, 0.2655458, 0.2051744, -0.1884313, 0.9604111) })
					I[9] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.4948665, 0.3369935, 0.0169677, 0.794498, 0.1161667, -0.5960522, 0.2755514, 0.8057055, 0.5243185, 0.5411509, -0.5808131, 0.6081216) })
				I[10] = new("Pose", I[3], "VoidstarCrown", { CFrame = CFrame.new(0.4447947, 1.977025, 0) })
				I[11] = new("Pose", I[3], "Voidstar", { CFrame = CFrame.new(2.7947912, 0.643497, -1.2971172) })
	return I[1]
end

return build
