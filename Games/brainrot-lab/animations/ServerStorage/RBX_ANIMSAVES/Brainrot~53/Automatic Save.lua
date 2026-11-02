-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~53/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1787543398" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.077", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.L", { CFrame = CFrame.new(0.0855732, 0.1807671, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Bone.R", { CFrame = CFrame.new(-0.0855713, 0.1807709, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[8] = new("Pose", I[7], "Cube.077", { Weight = 0 })
				I[9] = new("Pose", I[8], "Bone", { Weight = 0 })
					I[10] = new("Pose", I[9], "Bone.L", { CFrame = CFrame.new(0.0000019, -0.0000076, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
					I[11] = new("Pose", I[9], "Bone.R", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[13] = new("Pose", I[12], "Cube.077", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { Weight = 0 })
					I[15] = new("Pose", I[14], "Bone.L", { CFrame = CFrame.new(0.0855732, 0.1807556, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
					I[16] = new("Pose", I[14], "Bone.R", { CFrame = CFrame.new(-0.0855713, 0.1807709, 0, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1) })
		I[17] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
