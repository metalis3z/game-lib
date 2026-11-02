-- Generated from animations/ReplicatedStorage/CaseRigs/CrateRig/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1654128485" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "MainBody", { Weight = 0 })
				I[4] = new("Pose", I[3], "Click2", { CFrame = CFrame.new(0, 0, 0, 0.9999982, 0, 0, 0, 0.9999994, 0.0000027, 0, -0.0000027, 0.9999994) })
				I[5] = new("Pose", I[3], "Lid", { CFrame = CFrame.new(0, 0, 0, 0.9999932, 0, 0, 0, 0.9999955, 0, 0, 0, 1) })
				I[6] = new("Pose", I[3], "Click1", { CFrame = CFrame.new(0, 0, 0, 0.9999989, 0, 0, 0, 0.9999993, 0, 0, 0, 1) })
				I[7] = new("Pose", I[3], "Main", { CFrame = CFrame.new(0, 0.0221252, 0, 0.9999992, -0.0000001, 0.0000004, -0.0000001, 0.9999991, 0.0000003, 0.0000004, 0.0000003, 0.9999997) })
	return I[1]
end

return build
