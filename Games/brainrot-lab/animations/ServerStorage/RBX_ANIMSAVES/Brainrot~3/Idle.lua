-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~3/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", nil, nil, { "1786571124" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone")
					I[5] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9518514, 0.3064964, 0.0062596, -0.3064964, 0.9518715, -0.0009814, -0.0062591, -0.0009844, 0.9999803) })
						I[6] = new("Pose", I[5], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.979879, -0.1995506, -0.004127, 0.1995506, 0.9798878, -0.000417, 0.0041272, -0.0004149, 0.9999918) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9800863, 0, -0.1985723, 0.0396651, 0.9798466, 0.1957736, 0.1945704, -0.1997514, 0.9603342) })
						I[8] = new("Pose", I[7], "Bone.016")
					I[9] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9582451, -0.2858807, -0.0062207, 0.2858969, 0.9582586, 0.0018574, 0.00543, -0.0035583, 0.999979) })
						I[10] = new("Pose", I[9], "Bone.006", { CFrame = CFrame.new(0, 0, 0, 0.9810904, 0.1935105, 0.0038798, -0.1935054, 0.9810979, -0.0016559, -0.0041269, 0.0008738, 0.9999913) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[12] = new("Pose", I[11], "Mesh", { Weight = 0 })
				I[13] = new("Pose", I[12], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9994076, 0.0344167, 0, -0.0344167, 0.9994076) })
					I[14] = new("Pose", I[13], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9995712, -0.029278, -0.0005979, 0.029278, 0.9995716, -0.0000089, 0.0005979, -0.0000086, 1.0000001) })
					I[15] = new("Pose", I[13], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9950005, 0, 0.0998693, 0, 1, 0, -0.0998693, 0, 0.9950005) })
						I[16] = new("Pose", I[15], "Bone.016", { CFrame = CFrame.new(-0.0027248, -0.006158, -0.0296674, 0.9999997, 0.0007989, 0.000215, -0.0007971, 0.9999658, -0.0082383, -0.0002216, 0.0082381, 0.999966) })
					I[17] = new("Pose", I[13], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9981652, 0.0605381, 0.0012206, -0.0605373, 0.9981657, -0.0006736, -0.0012592, 0.0005984, 0.9999991) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.8666667 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone")
					I[21] = new("Pose", I[20], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9518514, 0.3064964, 0.0062596, -0.3064964, 0.9518715, -0.0009814, -0.0062591, -0.0009844, 0.9999803) })
						I[22] = new("Pose", I[21], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.979879, -0.1995506, -0.004127, 0.1995506, 0.9798878, -0.000417, 0.0041272, -0.0004149, 0.9999918) })
					I[23] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9615404, -0.0907182, 0.2592493, 0.039663, 0.979848, 0.1957669, -0.2717846, -0.1779551, 0.9457616) })
						I[24] = new("Pose", I[23], "Bone.016")
					I[25] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9582451, -0.2858807, -0.0062207, 0.2858969, 0.9582586, 0.0018574, 0.00543, -0.0035583, 0.999979) })
						I[26] = new("Pose", I[25], "Bone.006", { CFrame = CFrame.new(0, 0, 0, 0.9810904, 0.1935105, 0.0038798, -0.1935054, 0.9810979, -0.0016559, -0.0041269, 0.0008738, 0.9999913) })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 1.4 })
			I[28] = new("Pose", I[27], "Mesh", { Weight = 0 })
				I[29] = new("Pose", I[28], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9994076, 0.0344167, 0, -0.0344167, 0.9994076) })
					I[30] = new("Pose", I[29], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9995712, -0.029278, -0.0005979, 0.029278, 0.9995716, -0.0000089, 0.0005979, -0.0000086, 1.0000001) })
					I[31] = new("Pose", I[29], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9950005, 0, 0.0998693, 0, 1, 0, -0.0998693, 0, 0.9950005) })
						I[32] = new("Pose", I[31], "Bone.016", { CFrame = CFrame.new(-0.0027248, -0.006158, -0.0296674, 0.9999997, 0.0007989, 0.000215, -0.0007971, 0.9999658, -0.0082383, -0.0002216, 0.0082381, 0.999966) })
					I[33] = new("Pose", I[29], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9981652, 0.0605381, 0.0012206, -0.0605373, 0.9981657, -0.0006736, -0.0012592, 0.0005984, 0.9999991) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 1.8666667 })
			I[35] = new("Pose", I[34], "Mesh", { Weight = 0 })
				I[36] = new("Pose", I[35], "Bone")
					I[37] = new("Pose", I[36], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9518514, 0.3064964, 0.0062596, -0.3064964, 0.9518715, -0.0009814, -0.0062591, -0.0009844, 0.9999803) })
						I[38] = new("Pose", I[37], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.979879, -0.1995506, -0.004127, 0.1995506, 0.9798878, -0.000417, 0.0041272, -0.0004149, 0.9999918) })
					I[39] = new("Pose", I[36], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9800863, 0, -0.1985723, 0.0396651, 0.9798466, 0.1957736, 0.1945704, -0.1997514, 0.9603342) })
						I[40] = new("Pose", I[39], "Bone.016")
					I[41] = new("Pose", I[36], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9582451, -0.2858807, -0.0062207, 0.2858969, 0.9582586, 0.0018574, 0.00543, -0.0035583, 0.999979) })
						I[42] = new("Pose", I[41], "Bone.006", { CFrame = CFrame.new(0, 0, 0, 0.9810904, 0.1935105, 0.0038798, -0.1935054, 0.9810979, -0.0016559, -0.0041269, 0.0008738, 0.9999913) })
		I[43] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
