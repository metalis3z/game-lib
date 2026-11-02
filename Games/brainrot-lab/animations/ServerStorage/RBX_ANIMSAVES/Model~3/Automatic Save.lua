-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~3/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786563944" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0.0000019, -0.0000114, -0.0000458, 1.0000001, 0, 0, 0, 0.7071069, -0.707107, 0, 0.7071069, 0.7071069) })
					I[6] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(-0.0000153, 0, -0.0000076, 0.7519228, -0.628805, 0.1980315, 0.534103, 0.7571362, 0.3761369, -0.3864534, -0.1770568, 0.9051546) })
	return I[1]
end

return build
