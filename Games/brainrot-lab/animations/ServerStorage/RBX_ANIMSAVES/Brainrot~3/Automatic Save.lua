-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~3/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", nil, nil, { "1786567757" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone")
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9800863, 0, -0.1985723, 0.0396651, 0.9798466, 0.1957736, 0.1945704, -0.1997514, 0.9603342) })
						I[6] = new("Pose", I[5], "Bone.016")
					I[7] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9582451, -0.2858807, -0.0062207, 0.2858969, 0.9582586, 0.0018574, 0.00543, -0.0035583, 0.999979) })
					I[8] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9518514, 0.3064964, 0.0062596, -0.3064964, 0.9518715, -0.0009814, -0.0062591, -0.0009844, 0.9999803) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9994076, 0.0344167, 0, -0.0344167, 0.9994076) })
					I[12] = new("Pose", I[11], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9950005, 0, 0.0998693, 0, 1, 0, -0.0998693, 0, 0.9950005) })
						I[13] = new("Pose", I[12], "Bone.016", { CFrame = CFrame.new(-0.0027248, -0.006158, -0.0296674, 0.9999997, 0.0007989, 0.000215, -0.0007971, 0.9999658, -0.0082383, -0.0002216, 0.0082381, 0.999966) })
					I[14] = new("Pose", I[11], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9981652, 0.0605381, 0.0012206, -0.0605373, 0.9981657, -0.0006736, -0.0012592, 0.0005984, 0.9999991) })
					I[15] = new("Pose", I[11], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9995712, -0.029278, -0.0005979, 0.029278, 0.9995716, -0.0000089, 0.0005979, -0.0000086, 1.0000001) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9695283, -0.0851276, 0.2297133, 0.0396533, 0.979851, 0.1957541, -0.2417489, -0.1806803, 0.9533688) })
					I[20] = new("Pose", I[18], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9582451, -0.2858807, -0.0062207, 0.2858969, 0.9582586, 0.0018574, 0.00543, -0.0035583, 0.999979) })
					I[21] = new("Pose", I[18], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9518514, 0.3064964, 0.0062596, -0.3064964, 0.9518715, -0.0009814, -0.0062591, -0.0009844, 0.9999803) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 1.2 })
			I[23] = new("Pose", I[22], "Mesh", { Weight = 0 })
				I[24] = new("Pose", I[23], "Bone", { Weight = 0 })
					I[25] = new("Pose", I[24], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9950005, 0, 0.0998693, 0, 1, 0, -0.0998693, 0, 0.9950005) })
					I[26] = new("Pose", I[24], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9981652, 0.0605381, 0.0012206, -0.0605373, 0.9981657, -0.0006736, -0.0012592, 0.0005984, 0.9999991) })
					I[27] = new("Pose", I[24], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9995712, -0.029278, -0.0005979, 0.029278, 0.9995716, -0.0000089, 0.0005979, -0.0000086, 1.0000001) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 1.6 })
			I[29] = new("Pose", I[28], "Mesh", { Weight = 0 })
				I[30] = new("Pose", I[29], "Bone", { Weight = 0 })
					I[31] = new("Pose", I[30], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9800863, 0, -0.1985723, 0.0396651, 0.9798466, 0.1957736, 0.1945704, -0.1997514, 0.9603342) })
					I[32] = new("Pose", I[30], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9582451, -0.2858807, -0.0062207, 0.2858969, 0.9582586, 0.0018574, 0.00543, -0.0035583, 0.999979) })
					I[33] = new("Pose", I[30], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9518514, 0.3064964, 0.0062596, -0.3064964, 0.9518715, -0.0009814, -0.0062591, -0.0009844, 0.9999803) })
		I[34] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
