-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Model~7/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786587043" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.090", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.R", { Weight = 0 })
						I[6] = new("Pose", I[5], "Bone.R.004", { CFrame = CFrame.new(0.0000038, 0, 0, 0.7071512, 0.0038482, -0.7070524, 0.0033493, 0.9999564, 0.0087921, 0.707055, -0.0085855, 0.7071071) })
						I[7] = new("Pose", I[5], "Bone.R.003", { CFrame = CFrame.new(-3.0429516, 0.0378876, -1.3491821, 0.7071512, 0.0038482, -0.7070524, 0.0033493, 0.9999564, 0.0087921, 0.707055, -0.0085855, 0.7071071) })
					I[8] = new("Pose", I[4], "Bone.L", { Weight = 0 })
						I[9] = new("Pose", I[8], "Bone.L.002", { CFrame = CFrame.new(0, 0.0000153, 0, 0.7071514, 0.0037593, -0.7070528, 0.0034404, 0.9999563, 0.0087575, 0.7070544, -0.0086254, 0.7071071) })
						I[10] = new("Pose", I[8], "Bone.L.001", { CFrame = CFrame.new(-0.6760025, 0.0083771, -0.2997818, 0.7071514, 0.0037593, -0.7070528, 0.0034404, 0.9999563, 0.0087575, 0.7070544, -0.0086254, 0.7071071) })
	return I[1]
end

return build
