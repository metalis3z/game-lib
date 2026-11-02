-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677~5/Untitled Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Untitled Animation Clip", { Priority = Enum.AnimationPriority.Core }, nil, { "1736169850" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0, -0.5087891, 0.4897156, 1, 0, 0, 0, -0.0174525, 0.9998477, 0, -0.9998477, -0.0174525) })
					I[6] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, -0.5335388, 0.4880066, 0.9999999, 0, 0, 0, 0.0174524, 0.9998477, 0, -0.9998477, 0.0174524) })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.6333333 })
			I[8] = new("Pose", I[7], "HumanoidRootPart", { Weight = 0 })
				I[9] = new("Pose", I[8], "Torso", { Weight = 0 })
					I[10] = new("Pose", I[9], "Right Arm", { CFrame = CFrame.new(0, -0.5087891, 0.4897156, 1, 0, 0, 0, -0.0174525, 0.9998477, 0, -0.9998477, -0.0174525) })
					I[11] = new("Pose", I[9], "Left Arm", { CFrame = CFrame.new(0, -0.5335388, 0.4880066, 0.9999999, 0, 0, 0, 0.0174524, 0.9998477, 0, -0.9998477, 0.0174524) })
	return I[1]
end

return build
