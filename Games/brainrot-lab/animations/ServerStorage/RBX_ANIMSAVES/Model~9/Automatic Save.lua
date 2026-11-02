-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~9/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786591803" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(-0.000001, 0, 0, 0.809017, 0.018014, 0.5875092, -0.018014, 0.9998206, -0.0058504, -0.5875092, -0.0058504, 0.8091964) })
					I[5] = new("Pose", I[4], "Bone.014", { Weight = 0 })
						I[6] = new("Pose", I[5], "Bone.019", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.020")
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 1.2766666 })
			I[9] = new("Pose", I[8], "Mesh", { Weight = 0 })
				I[10] = new("Pose", I[9], "Bone", { Weight = 0 })
					I[11] = new("Pose", I[10], "Bone.014", { Weight = 0 })
						I[12] = new("Pose", I[11], "Bone.019", { Weight = 0 })
							I[13] = new("Pose", I[12], "Bone.020", { CFrame = CFrame.new(0.000001, 0, 0, 0.9703768, 0.0161653, -0.2410546, -0.0192589, 0.9997597, -0.0104832, 0.2408271, 0.014815, 0.9704551) })
	return I[1]
end

return build
