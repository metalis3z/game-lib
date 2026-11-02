-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~48/Idle bandito.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle bandito", { Priority = Enum.AnimationPriority.Core }, nil, { "1787509725" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0.2857263, 0.2857072, 0, 0.0005632, -0.9660023, -0.2585322, -0.0004583, 0.2585319, -0.9660025, 0.9999996, 0.0006626, -0.0002972) })
					I[6] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0.285729, 0.2857127, 0, 0.0005632, -0.9660023, 0.2585322, -0.0004583, 0.2585319, 0.9660025, -0.9999996, -0.0006626, -0.0002972) })
					I[7] = new("Pose", I[4], "Bone.013", { CFrame = CFrame.new(0, 0, 0, 0.9659258, 0.2587287, -0.006836, -0.2587287, 0.9659495, 0.0008997, 0.006836, 0.0008997, 0.9999762) })
						I[8] = new("Pose", I[7], "Bone.017", { CFrame = CFrame.new(-0.0000272, 0, 0, 0.9659289, 0.2550853, -0.0437357, -0.2550854, 0.9669018, 0.0056749, 0.0437357, 0.0056748, 0.999027) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { Weight = 0 })
					I[12] = new("Pose", I[11], "Bone.010", { CFrame = CFrame.new(0.2857263, 0.2857072, 0, 0.0006972, -0.9999999, 0.0002626, -0.000252, -0.0002626, -1.0000001, 0.9999999, 0.000697, -0.0002521) })
					I[13] = new("Pose", I[11], "Bone.007", { CFrame = CFrame.new(0.285729, 0.2857127, 0, 0.0007813, -0.9999996, -0.0002213, -0.0001849, -0.0002214, 0.9999999, -0.9999996, -0.0007813, -0.000185) })
					I[14] = new("Pose", I[11], "Bone.013", { CFrame = CFrame.new(0, 0, 0, 0.9659234, -0.2587379, 0.0068362, 0.2587379, 0.965947, 0.0008997, -0.0068362, 0.0008997, 0.9999762) })
						I[15] = new("Pose", I[14], "Bone.017", { CFrame = CFrame.new(-0.0000259, 0, 0, 0.9659203, -0.2550927, 0.0438832, 0.2550917, 0.9669, 0.0057138, -0.0438882, 0.0056752, 0.9990203) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.010", { CFrame = CFrame.new(0.2857263, 0.2857072, 0, 0.0005632, -0.9660023, -0.2585322, -0.0004583, 0.2585319, -0.9660025, 0.9999996, 0.0006626, -0.0002972) })
					I[20] = new("Pose", I[18], "Bone.007", { CFrame = CFrame.new(0.285729, 0.2857127, 0, 0.0005632, -0.9660023, 0.2585322, -0.0004583, 0.2585319, 0.9660025, -0.9999996, -0.0006626, -0.0002972) })
					I[21] = new("Pose", I[18], "Bone.013", { CFrame = CFrame.new(0, 0, 0, 0.9659258, 0.2587286, -0.006836, -0.2587287, 0.9659496, 0.0008997, 0.006836, 0.0008997, 0.9999762) })
						I[22] = new("Pose", I[21], "Bone.017", { CFrame = CFrame.new(0, 0.0000054, 0.0000436, 0.9659256, 0.2550844, -0.0438112, -0.2550852, 0.9669019, 0.005665, 0.0438062, 0.0057036, 0.9990237) })
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
