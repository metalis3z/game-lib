-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~2/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786558461" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.090", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0.0021439, -0.0009766, -0.1999855, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[5] = new("Pose", I[4], "Bone.R", { Weight = 0 })
						I[6] = new("Pose", I[5], "Bone.R.003", { CFrame = CFrame.new(0, 0, 0, 1.0000004, 0, 0, 0, 1.0000007, 0, 0, 0, 1.0000005) })
	return I[1]
end

return build
