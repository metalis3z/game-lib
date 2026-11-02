-- Generated from animations/ReplicatedStorage/Assets/Gnome/AnimSaves/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso")
					I[6] = new("Pose", I[5], "Head")
						I[7] = new("Pose", I[6], "Eyes")
						I[8] = new("Pose", I[6], "Meshes/Gnome_Circle.003")
						I[9] = new("Pose", I[6], "Beard")
					I[10] = new("Pose", I[5], "Meshes/Gnome_Circle.002")
						I[11] = new("Pose", I[10], "Right Leg")
							I[12] = new("Pose", I[11], "Right Foot")
						I[13] = new("Pose", I[10], "Left Leg")
							I[14] = new("Pose", I[13], "Left Foot")
					I[15] = new("Pose", I[5], "Right Arm")
						I[16] = new("Pose", I[15], "Right Hand")
					I[17] = new("Pose", I[5], "Left Arm")
						I[18] = new("Pose", I[17], "Left Arm")
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("IntValue", I[20], "Null")
				I[22] = new("Pose", I[20], "Torso", { Weight = 0 })
					I[23] = new("IntValue", I[22], "Null")
					I[24] = new("Pose", I[22], "Head", { CFrame = CFrame.new(0, -0.024, 0) })
						I[25] = new("Pose", I[24], "Eyes", { CFrame = CFrame.new(0, 0.024, 0) })
						I[26] = new("Pose", I[24], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0319999, 0) })
					I[27] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0, -0.024, 0) })
					I[28] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(0, -0.024, 0) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 })
				I[31] = new("IntValue", I[30], "Null")
				I[32] = new("Pose", I[30], "Torso", { Weight = 0 })
					I[33] = new("IntValue", I[32], "Null")
					I[34] = new("Pose", I[32], "Head", { CFrame = CFrame.new(0, -0.035625, 0) })
						I[35] = new("Pose", I[34], "Eyes", { CFrame = CFrame.new(0, 0.035625, 0) })
						I[36] = new("Pose", I[34], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0475, 0) })
					I[37] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(0, -0.035625, 0) })
					I[38] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(0, -0.035625, 0) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[40] = new("Pose", I[39], "HumanoidRootPart", { Weight = 0 })
				I[41] = new("IntValue", I[40], "Null")
				I[42] = new("Pose", I[40], "Torso", { Weight = 0 })
					I[43] = new("IntValue", I[42], "Null")
					I[44] = new("Pose", I[42], "Head", { CFrame = CFrame.new(0, -0.045, 0) })
						I[45] = new("Pose", I[44], "Eyes", { CFrame = CFrame.new(0, 0.045, 0) })
						I[46] = new("Pose", I[44], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0599999, 0) })
					I[47] = new("Pose", I[42], "Right Arm", { CFrame = CFrame.new(0, -0.045, 0) })
					I[48] = new("Pose", I[42], "Left Arm", { CFrame = CFrame.new(0, -0.045, 0) })
		I[49] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[50] = new("Pose", I[49], "HumanoidRootPart", { Weight = 0 })
				I[51] = new("IntValue", I[50], "Null")
				I[52] = new("Pose", I[50], "Torso", { Weight = 0 })
					I[53] = new("IntValue", I[52], "Null")
					I[54] = new("Pose", I[52], "Head", { CFrame = CFrame.new(0, -0.04875, 0) })
						I[55] = new("Pose", I[54], "Eyes", { CFrame = CFrame.new(0, 0.04875, 0) })
						I[56] = new("Pose", I[54], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0649999, 0) })
					I[57] = new("Pose", I[52], "Right Arm", { CFrame = CFrame.new(0, -0.04875, 0) })
					I[58] = new("Pose", I[52], "Left Arm", { CFrame = CFrame.new(0, -0.04875, 0) })
		I[59] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[60] = new("Pose", I[59], "HumanoidRootPart", { Weight = 0 })
				I[61] = new("IntValue", I[60], "Null")
				I[62] = new("Pose", I[60], "Torso", { Weight = 0 })
					I[63] = new("IntValue", I[62], "Null")
					I[64] = new("Pose", I[62], "Head", { CFrame = CFrame.new(0, -0.045, 0) })
						I[65] = new("Pose", I[64], "Eyes", { CFrame = CFrame.new(0, 0.045, 0) })
						I[66] = new("Pose", I[64], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0599999, 0) })
					I[67] = new("Pose", I[62], "Right Arm", { CFrame = CFrame.new(0, -0.045, 0) })
					I[68] = new("Pose", I[62], "Left Arm", { CFrame = CFrame.new(0, -0.045, 0) })
		I[69] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[70] = new("Pose", I[69], "HumanoidRootPart", { Weight = 0 })
				I[71] = new("IntValue", I[70], "Null")
				I[72] = new("Pose", I[70], "Torso", { Weight = 0 })
					I[73] = new("IntValue", I[72], "Null")
					I[74] = new("Pose", I[72], "Head", { CFrame = CFrame.new(0, -0.035625, 0) })
						I[75] = new("Pose", I[74], "Eyes", { CFrame = CFrame.new(0, 0.035625, 0) })
						I[76] = new("Pose", I[74], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0475, 0) })
					I[77] = new("Pose", I[72], "Right Arm", { CFrame = CFrame.new(0, -0.035625, 0) })
					I[78] = new("Pose", I[72], "Left Arm", { CFrame = CFrame.new(0, -0.035625, 0) })
		I[79] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[80] = new("Pose", I[79], "HumanoidRootPart", { Weight = 0 })
				I[81] = new("IntValue", I[80], "Null")
				I[82] = new("Pose", I[80], "Torso", { Weight = 0 })
					I[83] = new("IntValue", I[82], "Null")
					I[84] = new("Pose", I[82], "Head", { CFrame = CFrame.new(0, -0.024, 0) })
						I[85] = new("Pose", I[84], "Eyes", { CFrame = CFrame.new(0, 0.024, 0) })
						I[86] = new("Pose", I[84], "Meshes/Gnome_Circle.003", { CFrame = CFrame.new(0, -0.0319999, 0) })
					I[87] = new("Pose", I[82], "Right Arm", { CFrame = CFrame.new(0, -0.024, 0) })
					I[88] = new("Pose", I[82], "Left Arm", { CFrame = CFrame.new(0, -0.024, 0) })
		I[89] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[90] = new("Pose", I[89], "HumanoidRootPart", { Weight = 0 })
				I[91] = new("IntValue", I[90], "Null")
				I[92] = new("Pose", I[90], "Torso")
					I[93] = new("Pose", I[92], "Head")
						I[94] = new("Pose", I[93], "Eyes")
						I[95] = new("Pose", I[93], "Meshes/Gnome_Circle.003")
						I[96] = new("Pose", I[93], "Beard")
					I[97] = new("Pose", I[92], "Meshes/Gnome_Circle.002")
						I[98] = new("Pose", I[97], "Right Leg")
							I[99] = new("Pose", I[98], "Right Foot")
						I[100] = new("Pose", I[97], "Left Leg")
							I[101] = new("Pose", I[100], "Left Foot")
					I[102] = new("Pose", I[92], "Right Arm")
						I[103] = new("Pose", I[102], "Right Hand")
					I[104] = new("Pose", I[92], "Left Arm")
						I[105] = new("Pose", I[104], "Left Arm")
	return I[1]
end

return build
