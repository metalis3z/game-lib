-- Generated from animations/StarterGui/ScreenGui/main/BoothModels/LindonFunnyBooth/Lidon/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Body", { CFrame = CFrame.new(0, 0.9999983, 0, -0.0000205, -1, 0.0000119, -0.499939, 0.0000205, 0.8660606, -0.8660606, 0.0000119, -0.499939) })
					I[5] = new("Pose", I[4], "Head", { Weight = 0 })
						I[6] = new("Pose", I[5], "Cone", { CFrame = CFrame.new(0, 0, 0, 0.9659296, 0, 0.2588048, 0, 1, 0, -0.2588048, 0, 0.9659296) })
					I[7] = new("Pose", I[4], "LegR", { CFrame = CFrame.new(0, 0, 0, -0.8147762, -0.5644482, -0.1324352, -0.4663081, 0.7737284, -0.4288371, 0.3445252, -0.2876505, -0.8936222) })
					I[8] = new("Pose", I[4], "HandL", { CFrame = CFrame.new(0, 0, 0, -0.8660074, 0, 0.5000314, 0, 1, 0, -0.5000314, 0, -0.8660074) })
					I[9] = new("Pose", I[4], "HandR", { CFrame = CFrame.new(0, 0, 0, 0.2588643, 0.9659137, 0, -0.9659137, 0.2588643, 0, 0, 0, 1) })
	return I[1]
end

return build
