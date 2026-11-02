-- Generated from animations/Workspace/Ignored/SawnOff/AnimSaves/Iron Sight Sawed Off.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Iron Sight Sawed Off")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.9411423, -0.162157, -0.8259045, -0.2499981, 0.8547736, -0.4548221, -0.9659256, -0.2526747, 0.0560655, -0.0669987, 0.4533405, 0.8888158) })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.127535, -0.3099912, -0.0216966, -0.5, -0.8660254, 0.0000586, 0.0000471, 0.0000405, 1, -0.8660253, 0.5, 0.0000206) })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[8] = new("Pose", I[7], "HumanoidRootPart", { Weight = 0 })
				I[9] = new("Pose", I[8], "Torso", { Weight = 0 })
					I[10] = new("Pose", I[9], "Left Arm", { CFrame = CFrame.new(-0.9411423, -0.162157, -0.8259045, -0.2499981, 0.8547736, -0.4548221, -0.9659256, -0.2526747, 0.0560655, -0.0669987, 0.4533405, 0.8888158) })
					I[11] = new("Pose", I[9], "Right Arm", { CFrame = CFrame.new(0.127535, -0.3099912, -0.0216966, -0.5, -0.8660254, 0.0000586, 0.0000471, 0.0000405, 1, -0.8660253, 0.5, 0.0000206) })
	return I[1]
end

return build
