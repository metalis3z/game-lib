-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~2/fly.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "fly", { Priority = Enum.AnimationPriority.Core }, nil, { "1720217006" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Body", { Weight = 0 })
				I[4] = new("Pose", I[3], "L", { CFrame = CFrame.new(0, 0.0000579, 0, 0.9999937, 0.0000009, 0.0000014, -0.0000006, 0.8290434, -0.5591946, 0.0000014, 0.559193, 0.8290409) })
				I[5] = new("Pose", I[3], "R", { CFrame = CFrame.new(0, 0, 0, 0.9999937, -0.0000013, 0.0000011, 0.0000003, 0.8191579, 0.5735779, 0.0000015, -0.573577, 0.8191552) })
		I[6] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[7] = new("Pose", I[6], "Body", { Weight = 0 })
				I[8] = new("Pose", I[7], "L", { CFrame = CFrame.new(0, 0.0000579, 0, 0.9999937, 0.0000007, 0.0000011, -0.0000001, 0.8987972, 0.4383751, 0.0000018, -0.4383761, 0.8987961) })
				I[9] = new("Pose", I[7], "R", { CFrame = CFrame.new(0, -0.0000579, 0, 0.9999937, -0.0000003, 0.0000008, 0.0000002, 0.9063124, -0.4226221, 0.0000025, 0.4226205, 0.90631) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[11] = new("Pose", I[10], "Body", { Weight = 0 })
				I[12] = new("Pose", I[11], "L", { CFrame = CFrame.new(0, 0.0000579, 0, 0.9999937, 0.0000009, 0.0000014, -0.0000006, 0.8290434, -0.5591946, 0.0000014, 0.559193, 0.8290409) })
				I[13] = new("Pose", I[11], "R", { CFrame = CFrame.new(0, 0, 0, 0.9999937, -0.0000013, 0.0000011, 0.0000003, 0.8191579, 0.5735779, 0.0000015, -0.573577, 0.8191552) })
	return I[1]
end

return build
