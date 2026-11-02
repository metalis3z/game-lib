-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~7/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786591937" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9781494, 0.0063717, 0.2078054, 0.0081396, 0.9975902, -0.0689014, -0.2077436, 0.0690873, 0.9757405) })
					I[5] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(0, 0, -0.0000268, 1, 0.0000028, -0.0000076, -0.0000028, 1.0000001, -0.0000027, 0.0000076, 0.0000027, 1.0000001) })
		I[6] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[7] = new("Pose", I[6], "Mesh", { Weight = 0 })
				I[8] = new("Pose", I[7], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9781494, -0.0063717, -0.2078054, 0.0208519, 0.9974968, 0.067566, 0.2068547, -0.0704228, 0.9758339) })
					I[9] = new("Pose", I[8], "Bone.014", { CFrame = CFrame.new(0.0000067, 0, 0, 0.9993927, 0.0110473, -0.0330496, -0.0110473, 0.9999391, 0.0001806, 0.0330496, 0.0001847, 0.9994538) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9975641, -0.0697565, 0, 0.0697565, 0.9975641) })
					I[13] = new("Pose", I[12], "Bone.014", { CFrame = CFrame.new(0.0000017, 0, 0, 1, 0, 0, 0, 0.999391, -0.0349029, 0, 0.0349029, 0.999391) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9781476, 0.0063719, 0.207814, -0.0063719, 0.9999795, -0.0006694, -0.207814, -0.0006694, 0.9781681) })
					I[17] = new("Pose", I[16], "Bone.014", { CFrame = CFrame.new(0, 0, -0.0000134, 1, 0.0000053, -0.0000706, -0.0000053, 1.0000002, -0.0000018, 0.0000706, 0.0000018, 1.0000001) })
		I[18] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
