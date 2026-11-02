-- Generated from animations/Workspace/StudioAssets/Darkseed_ the Fallen/AnimSaves/DarkseedPose.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "DarkseedPose", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0.000002, 0.0000018, 0.7900068, 0.9797871, 0.0802197, 0.1832542, 0.0169563, 0.8794721, -0.4756484, -0.1993233, 0.4691415, 0.8603351), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0.0789394, -0.1389134, 0.0614137, 0.9133732, -0.3568915, -0.1959026, 0.4023977, 0.8644873, 0.301227, 0.06185, -0.3539634, 0.9332119), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.7546102, 0.6, 0.1075726, 0.9123973, 0, 0.4093058, 0, 1, 0, -0.4093058, 0, 0.9123973), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.3709665, -0.3881313, 0.0495351, 0.6057314, 0.3987407, -0.6885458, 0.2855559, 0.6987745, 0.655875, 0.7426623, -0.5939024, 0.3094069), EasingStyle = Enum.PoseEasingStyle.Constant })
						I[9] = new("Pose", I[8], "Staff", { CFrame = CFrame.new(-0.2439129, -0.0190648, 0.4077066, 0.9982802, 0.0493462, 0.0316482, -0.0420542, 0.2266924, 0.973058, 0.0408423, -0.9727156, 0.2283777), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[10] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.1737223, -0.3693193, 0.5060354, -0.1470416, 0.498426, -0.8543712, -0.988346, -0.0396466, 0.1469701, 0.0393807, 0.8660251, 0.4984472), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[11] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.5632603, 0.3702984, 0.1578104, 0.9738486, 0.1690769, -0.1517623, -0.2016646, 0.9509333, -0.234643, 0.1046431, 0.2591119, 0.9601619), EasingStyle = Enum.PoseEasingStyle.Constant })
	return I[1]
end

return build
