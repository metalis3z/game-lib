-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~46/Idle Frigo Camelo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Frigo Camelo", { Priority = Enum.AnimationPriority.Core }, nil, { "1787507175" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.2857154, 0) })
					I[5] = new("Pose", I[4], "Bone.010")
					I[6] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[7] = new("Pose", I[6], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9659258, 0.1900782, 0.1756632, -0.1900782, 0.9816222, -0.0169843, -0.1756632, -0.0169843, 0.984304) })
					I[8] = new("Pose", I[4], "Bone.007")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone")
					I[12] = new("Pose", I[11], "Bone.010", { CFrame = CFrame.new(0.0142506, 0.2853612, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
					I[13] = new("Pose", I[11], "Bone.001", { Weight = 0 })
						I[14] = new("Pose", I[13], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9659232, -0.1900853, -0.1756698, 0.1900852, 0.9816208, -0.0169855, 0.1756697, -0.0169855, 0.9843028) })
					I[15] = new("Pose", I[11], "Bone.007", { CFrame = CFrame.new(-0.0142506, 0.2853612, 0, 1.0000001, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000002) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, -0.2857154, 0) })
					I[19] = new("Pose", I[18], "Bone.010")
					I[20] = new("Pose", I[18], "Bone.001", { Weight = 0 })
						I[21] = new("Pose", I[20], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9659258, 0.1900782, 0.1756632, -0.1900782, 0.9816222, -0.0169843, -0.1756632, -0.0169843, 0.984304) })
					I[22] = new("Pose", I[18], "Bone.007")
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
