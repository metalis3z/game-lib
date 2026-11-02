-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~4/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786565485" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.004")
		I[6] = new("Keyframe", I[1], "Keyframe", { Time = 0.2420833 })
			I[7] = new("Pose", I[6], "Mesh", { Weight = 0 })
				I[8] = new("Pose", I[7], "Bone", { Weight = 0 })
					I[9] = new("Pose", I[8], "Bone.004", { CFrame = CFrame.new(-0.000001, 0, 0, 0.7071068, 0.7071068, 0, -0.7071068, 0.7071068, 0, 0, 0, 1) })
	return I[1]
end

return build
