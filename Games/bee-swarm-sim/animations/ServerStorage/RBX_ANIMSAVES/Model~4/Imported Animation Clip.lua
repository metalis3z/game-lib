-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~4/Imported Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Imported Animation Clip", { Priority = Enum.AnimationPriority.Core }, nil, { "1723609727" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Body", { Weight = 0 })
				I[4] = new("Pose", I[3], "L", { CFrame = CFrame.new(0, 2.5821404, -0.9981896, 1, -0.0000012, -0.000001, 0.0000014, 0.5023468, 0.8646662, -0.0000006, -0.8646662, 0.5023468) })
				I[5] = new("Pose", I[3], "R", { CFrame = CFrame.new(0, 2.4687262, 1.0330529, 1, 0.0000014, -0.0000006, -0.0000012, 0.5117357, -0.8591429, -0.0000009, 0.8591429, 0.5117357) })
		I[6] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[7] = new("Pose", I[6], "Body", { Weight = 0 })
				I[8] = new("Pose", I[7], "L", { CFrame = CFrame.new(0, -2.1783626, -0.7042096, 1, 0.0000014, -0.0000006, -0.0000012, 0.5225871, -0.8525859, -0.0000009, 0.8525859, 0.5225871) })
				I[9] = new("Pose", I[7], "R", { CFrame = CFrame.new(0, -2.0332389, 1.1748785, 1, -0.0000012, -0.0000009, 0.0000014, 0.5264302, 0.8502183, -0.0000006, -0.8502183, 0.5264302) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[11] = new("Pose", I[10], "Body", { Weight = 0 })
				I[12] = new("Pose", I[11], "L", { CFrame = CFrame.new(0, 2.5821404, -0.9981896, 1, -0.0000012, -0.000001, 0.0000014, 0.5023468, 0.8646662, -0.0000006, -0.8646662, 0.5023468) })
				I[13] = new("Pose", I[11], "R", { CFrame = CFrame.new(0, 2.4687262, 1.0330529, 1, 0.0000014, -0.0000006, -0.0000012, 0.5117357, -0.8591429, -0.0000009, 0.8591429, 0.5117357) })
	return I[1]
end

return build
