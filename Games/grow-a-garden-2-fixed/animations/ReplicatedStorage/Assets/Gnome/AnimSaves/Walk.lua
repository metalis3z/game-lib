-- Generated from animations/ReplicatedStorage/Assets/Gnome/AnimSaves/Walk.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "Head")
						I[8] = new("Pose", I[7], "Eyes")
						I[9] = new("Pose", I[7], "Meshes/Gnome_Circle.003")
					I[10] = new("Pose", I[5], "Meshes/Gnome_Circle.002")
						I[11] = new("Pose", I[10], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.7071342, 0.7070793, 0, -0.7070793, 0.7071342, 0, 0, 0, 1) })
						I[12] = new("Pose", I[10], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.7071342, -0.7070793, 0, 0.7070793, 0.7071342, 0, 0, 0, 1) })
					I[13] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.7071342, 0.7070793, 0, -0.7070793, 0.7071342, 0, 0, 0, 1) })
					I[14] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.7071342, -0.7070793, 0, 0.7070793, 0.7071342, 0, 0, 0, 1) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("IntValue", I[16], "Null")
				I[18] = new("Pose", I[16], "Torso", { Weight = 0 })
					I[19] = new("IntValue", I[18], "Null")
					I[20] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0, -0.033125, 0) })
						I[21] = new("Pose", I[20], "Eyes", { CFrame = CFrame.new(0, -0.007, 0) })
						I[22] = new("Pose", I[20], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0700001, 0) })
					I[23] = new("Pose", I[18], "Meshes/Gnome_Circle.002", { Weight = 0 })
						I[24] = new("IntValue", I[23], "Null")
						I[25] = new("Pose", I[23], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9510684, -0.3089805, 0, 0.3089805, 0.9510684, 0, 0, 0, 1) })
						I[26] = new("Pose", I[23], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9510684, 0.3089805, 0, -0.3089805, 0.9510684, 0, 0, 0, 1) })
					I[27] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.999962, -0.0087184, 0, 0.0087184, 0.999962, 0, 0, 0, 1) })
					I[28] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9510684, 0.3089805, 0, -0.3089805, 0.9510684, 0, 0, 0, 1) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 })
				I[31] = new("IntValue", I[30], "Null")
				I[32] = new("Pose", I[30], "Torso", { Weight = 0 })
					I[33] = new("IntValue", I[32], "Null")
					I[34] = new("Pose", I[32], "Head", { CFrame = CFrame.new(0, -0.03875, 0) })
						I[35] = new("Pose", I[34], "Eyes", { CFrame = CFrame.new(0, -0.0085, 0) })
						I[36] = new("Pose", I[34], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.085, 0) })
					I[37] = new("Pose", I[32], "Meshes/Gnome_Circle.002", { Weight = 0 })
						I[38] = new("IntValue", I[37], "Null")
						I[39] = new("Pose", I[37], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.8526411, -0.5224971, 0, 0.5224971, 0.8526411, 0, 0, 0, 1) })
						I[40] = new("Pose", I[37], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.8526411, 0.5224971, 0, -0.5224971, 0.8526411, 0, 0, 0, 1) })
					I[41] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.9840356, -0.177972, 0, 0.177972, 0.9840356, 0, 0, 0, 1) })
					I[42] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.8526411, 0.5224971, 0, -0.5224971, 0.8526411, 0, 0, 0, 1) })
		I[43] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[44] = new("Pose", I[43], "HumanoidRootPart", { Weight = 0 })
				I[45] = new("IntValue", I[44], "Null")
				I[46] = new("Pose", I[44], "Torso", { Weight = 0 })
					I[47] = new("IntValue", I[46], "Null")
					I[48] = new("Pose", I[46], "Head", { CFrame = CFrame.new(0, -0.033125, 0) })
						I[49] = new("Pose", I[48], "Eyes", { CFrame = CFrame.new(0, -0.007, 0) })
						I[50] = new("Pose", I[48], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0700001, 0) })
					I[51] = new("Pose", I[46], "Meshes/Gnome_Circle.002", { Weight = 0 })
						I[52] = new("IntValue", I[51], "Null")
						I[53] = new("Pose", I[51], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9510684, -0.3089805, 0, 0.3089805, 0.9510684, 0, 0, 0, 1) })
						I[54] = new("Pose", I[51], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9510684, 0.3089805, 0, -0.3089805, 0.9510684, 0, 0, 0, 1) })
					I[55] = new("Pose", I[46], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.999962, -0.0087184, 0, 0.0087184, 0.999962, 0, 0, 0, 1) })
					I[56] = new("Pose", I[46], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.9510684, 0.3089805, 0, -0.3089805, 0.9510684, 0, 0, 0, 1) })
		I[57] = new("Keyframe", I[1], "Keyframe", { Time = 0.6666667 })
			I[58] = new("Pose", I[57], "HumanoidRootPart", { Weight = 0 })
				I[59] = new("IntValue", I[58], "Null")
				I[60] = new("Pose", I[58], "Torso", { Weight = 0 })
					I[61] = new("IntValue", I[60], "Null")
					I[62] = new("Pose", I[60], "Head")
						I[63] = new("Pose", I[62], "Eyes")
						I[64] = new("Pose", I[62], "Meshes/Gnome_Circle.003")
					I[65] = new("Pose", I[60], "Meshes/Gnome_Circle.002")
						I[66] = new("Pose", I[65], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.7071342, 0.7070793, 0, -0.7070793, 0.7071342, 0, 0, 0, 1) })
						I[67] = new("Pose", I[65], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.7071342, -0.7070793, 0, 0.7070793, 0.7071342, 0, 0, 0, 1) })
					I[68] = new("Pose", I[60], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.7071342, 0.7070793, 0, -0.7070793, 0.7071342, 0, 0, 0, 1) })
					I[69] = new("Pose", I[60], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.7071342, -0.7070793, 0, 0.7070793, 0.7071342, 0, 0, 0, 1) })
		I[70] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[71] = new("Pose", I[70], "HumanoidRootPart", { Weight = 0 })
				I[72] = new("IntValue", I[71], "Null")
				I[73] = new("Pose", I[71], "Torso", { Weight = 0 })
					I[74] = new("IntValue", I[73], "Null")
					I[75] = new("Pose", I[73], "Head", { CFrame = CFrame.new(0, -0.02, 0) })
		I[76] = new("Keyframe", I[1], "Keyframe", { Time = 0.5333334 })
			I[77] = new("Pose", I[76], "HumanoidRootPart", { Weight = 0 })
				I[78] = new("IntValue", I[77], "Null")
				I[79] = new("Pose", I[77], "Torso", { Weight = 0 })
					I[80] = new("IntValue", I[79], "Null")
					I[81] = new("Pose", I[79], "Head", { CFrame = CFrame.new(0, -0.02, 0) })
	return I[1]
end

return build
