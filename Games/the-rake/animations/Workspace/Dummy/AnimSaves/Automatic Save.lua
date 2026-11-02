-- Generated from animations/Workspace/Dummy/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false }, nil, { "1630893454" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.6691316, -0.743144, 0, 0.743144, 0.6691316) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0000407, 0.0000151, 0.0000041, 0.6699347, 0.7351948, 0.1033249, -0.74242, 0.6634148, 0.0932368, 0, -0.139173, 0.9902681) })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0001332, -0.0000075, -0.0002182, -0.8838034, -0.2767835, 0.3772037, 0.4675299, -0.4922671, 0.7342264, -0.0175368, 0.8252658, 0.5644718) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0003145, -0.0000154, 0.0000357, -0.7525057, 0.1754687, -0.6347802, -0.6114178, -0.5443313, 0.5743442, -0.2447513, 0.8203132, 0.5168971) })
					I[8] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(-0.0001034, 0.0000097, -0.0000581, 0.6699294, -0.7351995, -0.1033265, 0.7424248, 0.6634095, 0.0932366, 0.0000003, -0.1391741, 0.990268) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 27 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9135458, 0.4067357, 0, -0.4067357, 0.9135458) })
					I[12] = new("Pose", I[11], "Left Leg", { CFrame = CFrame.new(-0.0000071, 0.0000216, 0, 0.8824831, -0.470344, 0, 0.470344, 0.8824829, 0, 0, 0, 1) })
					I[13] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(0, -0.0000026, -0.0000811, 1, 0, 0, 0, 0.8480436, 0.529926, 0, -0.529926, 0.8480438) })
					I[14] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(0, -0.0000041, -0.0000488, 1, 0, 0, 0, 0.9135405, 0.4067472, 0, -0.4067472, 0.9135407) })
					I[15] = new("Pose", I[11], "Right Leg", { CFrame = CFrame.new(-0.0000376, 0.0000192, 0, 0.9131414, 0.4076429, 0, -0.4076429, 0.9131411, 0, 0, 0, 1) })
	return I[1]
end

return build
