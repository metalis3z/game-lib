-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~22/Walk Girafa celeste.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Girafa celeste", nil, nil, { "1786655425" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9924051, 0.0854935, 0.0884483, -0.08583, 0.9963098, 0.000002, -0.0881218, -0.0075935, 0.9960808) })
					I[5] = new("Pose", I[4], "Bone.011.R", { CFrame = CFrame.new(0.0151919, -0.1747332, 0.0033195, 1, 0, 0, 0, 0.9397938, -0.3417421, 0, 0.3417421, 0.9397939) })
					I[6] = new("Pose", I[4], "Bone.011.L", { CFrame = CFrame.new(-0.0304507, 0.3494932, -0.0066925, 1, 0, 0, 0, 0.9397039, 0.341989, 0, -0.341989, 0.9397041) })
					I[7] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[8] = new("Pose", I[7], "Bone.002", { CFrame = CFrame.new(-0.0001071, -0.0000535, 0.0000535, 0.9849333, -0.1309322, 0.1129741, 0.1291955, 0.9913618, 0.0225905, -0.114956, -0.0076542, 0.9933409) })
					I[9] = new("Pose", I[4], "Bone.008.L", { CFrame = CFrame.new(-0.0304373, 0.3494932, -0.0067995, 1, 0, 0, 0, 0.9397039, -0.341989, 0, 0.341989, 0.9397041) })
					I[10] = new("Pose", I[4], "Bone.008.R", { CFrame = CFrame.new(0.0151919, -0.1747533, 0.0032659, 1, 0, 0, 0, 0.9398237, 0.3416596, 0, -0.3416597, 0.9398239) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9924038, 0.0881185, -0.085847, -0.0884451, 0.996081, -0.0000012, 0.0855105, 0.007594, 0.9963083) })
					I[14] = new("Pose", I[13], "Bone.011.R", { CFrame = CFrame.new(0.0151785, 0.1746864, -0.0061035, 1, 0, 0, 0, 0.939704, 0.341989, 0, -0.341989, 0.9397041) })
					I[15] = new("Pose", I[13], "Bone.011.L", { CFrame = CFrame.new(-0.030464, -0.3493594, 0.0120464, 1, 0, 0, 0, 0.9397041, -0.341989, 0, 0.341989, 0.9397041) })
					I[16] = new("Pose", I[13], "Bone.001", { Weight = 0 })
						I[17] = new("Pose", I[16], "Bone.002", { CFrame = CFrame.new(-0.0001071, -0.0000535, 0.0000535, 0.9849117, 0.1292572, -0.1150714, -0.1309974, 0.991353, -0.0076592, 0.1130864, 0.0226178, 0.9933275) })
					I[18] = new("Pose", I[13], "Bone.008.L", { CFrame = CFrame.new(-0.030464, -0.3493326, 0.0119393, 1, 0, 0, 0, 0.939704, 0.341989, 0, -0.341989, 0.9397041) })
					I[19] = new("Pose", I[13], "Bone.008.R", { CFrame = CFrame.new(0.0152052, 0.174673, -0.0061035, 1, 0, 0, 0, 0.9397041, -0.341989, 0, 0.341989, 0.9397041) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9924051, 0.0854935, 0.0884483, -0.08583, 0.9963098, 0.000002, -0.0881218, -0.0075935, 0.9960808) })
					I[23] = new("Pose", I[22], "Bone.011.R", { CFrame = CFrame.new(0.0151919, -0.1747332, 0.0033195, 1, 0, 0, 0, 0.9397938, -0.3417421, 0, 0.3417421, 0.9397939) })
					I[24] = new("Pose", I[22], "Bone.011.L", { CFrame = CFrame.new(-0.0304507, 0.3494932, -0.0066925, 1, 0, 0, 0, 0.9397039, 0.341989, 0, -0.341989, 0.9397041) })
					I[25] = new("Pose", I[22], "Bone.001", { Weight = 0 })
						I[26] = new("Pose", I[25], "Bone.002", { CFrame = CFrame.new(-0.0001071, -0.0000535, 0.0000535, 0.9849333, -0.1309322, 0.1129741, 0.1291955, 0.9913618, 0.0225905, -0.114956, -0.0076542, 0.9933409) })
					I[27] = new("Pose", I[22], "Bone.008.L", { CFrame = CFrame.new(-0.0304373, 0.3494932, -0.0067995, 1, 0, 0, 0, 0.9397039, -0.341989, 0, 0.341989, 0.9397041) })
					I[28] = new("Pose", I[22], "Bone.008.R", { CFrame = CFrame.new(0.0151919, -0.1747533, 0.0032659, 1, 0, 0, 0, 0.9398237, 0.3416596, 0, -0.3416597, 0.9398239) })
		I[29] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
