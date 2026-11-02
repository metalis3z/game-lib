-- Generated from animations/ServerStorage/Assets/Rigs/Killers/Noli/DignityNoli/AnimSaves/tuff pose.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "tuff pose", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9828183, 0.1512657, 0.1057676, -0.1637847, 0.9789383, 0.1218777, -0.0851041, -0.1371067, 0.9868936) })
					I[6] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.034613, -0.2270613, 0.0453586, 0.9047542, -0.2783356, 0.3224117, 0.2263583, 0.9554142, 0.1895936, -0.3608074, -0.098555, 0.9274185) })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.093401, 0.078726, 0.2192793, 0.9305911, -0.3199962, 0.1777919, 0.2815959, 0.9360754, 0.2108707, -0.2339045, -0.1461683, 0.9612133) })
					I[8] = new("Pose", I[5], "Head", { CFrame = CFrame.new(-0.0000001, 0, 0.0000003, 0.9843505, 0.0547924, -0.1674875, -0.0807991, 0.984973, -0.1526419, 0.156607, 0.1637859, 0.9739859) })
					I[9] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.3912327, -0.4919465, -0.1911093, 0.4262189, -0.513246, -0.7449327, 0.6414639, 0.7521114, -0.1511715, 0.63786, -0.413416, 0.6497932) })
					I[10] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(-0.0662358, 0.0420988, -0.0130208, 0.9499483, 0.0213812, -0.3116746, 0.0019922, 0.9972203, 0.0744822, 0.3124008, -0.0713752, 0.9472653) })
				I[11] = new("Pose", I[3], "VoidstarCrown", { CFrame = CFrame.new(-0.0000001, 1.9447076, 0, 0.9971042, 0.0760477, 0, -0.0760477, 0.9971042, 0, 0, 0, 1) })
				I[12] = new("Pose", I[3], "Voidstar", { CFrame = CFrame.new(2.049031, -1.1553979, -0.8610345, 0.7864851, 0.557973, -0.2647778, 0.5034094, -0.3307919, 0.7982204, 0.3577991, -0.76108, -0.5410517) })
	return I[1]
end

return build
