-- Generated from animations/Workspace/Ignored/Dummy R6/AnimSaves/FNP-45_Equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "FNP-45_Equip", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.1862522, 0.006623, 0.0324405, 0.9459465, 0.0194478, 0.3237393, -0.0249976, 0.9996031, 0.0129931, -0.3233581, -0.0203835, 0.9460571) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[7] = new("Pose", I[6], "Magazine")
							I[8] = new("Pose", I[6], "Slider")
					I[9] = new("Pose", I[4], "Left Arm")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0623465, -0.3393109, -0.1350892, 0.2455184, -0.8502173, 0.4656729, 0.90427, 0.373967, 0.2060206, -0.3493085, 0.3705122, 0.8606418) })
					I[14] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0119796, -0.6312966, 0.101565, 0.4069833, 0.8068778, -0.4281508, -0.7596455, 0.5592717, 0.3318947, 0.507251, 0.1901671, 0.8405551) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { Weight = 0 })
					I[18] = new("Pose", I[17], "Right Arm", { CFrame = CFrame.new(0.1340029, -0.3288021, -0.2226705, -0.1394156, -0.8608367, 0.4894114, 0.9687412, -0.0161532, 0.2475471, -0.2051921, 0.5086249, 0.83618) })
					I[19] = new("Pose", I[17], "Left Arm", { CFrame = CFrame.new(-0.2654014, -0.4661998, -0.5705598, 0.0828559, 0.6920214, -0.7171061, -0.9729881, -0.0994108, -0.2083545, -0.2154738, 0.7149991, 0.6650919) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { Weight = 0 })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.1675031, -0.4110033, -0.2783381, -0.2164545, -0.8770948, 0.4287801, 0.9726339, -0.1557441, 0.1724163, -0.0844455, 0.4543663, 0.8868034) })
						I[24] = new("Pose", I[23], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[25] = new("Pose", I[24], "Magazine")
							I[26] = new("Pose", I[24], "Slider")
					I[27] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-0.3317496, -0.5827506, -0.7131961, 0.0853328, 0.6138346, -0.7848091, -0.8496665, -0.3665546, -0.3790837, -0.5203701, 0.6991743, 0.4902756) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(0.1675032, -0.4110035, -0.278338, -0.2233269, -0.8807269, 0.4176666, 0.9648269, -0.1387677, 0.2232772, -0.1386876, 0.4528398, 0.8807394) })
						I[32] = new("Pose", I[31], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[33] = new("Pose", I[32], "Magazine")
							I[34] = new("Pose", I[32], "Slider")
					I[35] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.3302577, -0.599614, -0.7238464, 0.1175159, 0.6164225, -0.778597, -0.8083732, -0.3960222, -0.4355446, -0.5768212, 0.6805804, 0.4517605) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { Weight = 0 })
					I[39] = new("Pose", I[38], "Right Arm", { CFrame = CFrame.new(0.167503, -0.4110038, -0.278338, -0.2160022, -0.8807123, 0.4215316, 0.9685844, -0.1387866, 0.2063557, -0.1232371, 0.4528622, 0.8830223) })
						I[40] = new("Pose", I[39], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[41] = new("Pose", I[40], "Magazine")
							I[42] = new("Pose", I[40], "Slider")
					I[43] = new("Pose", I[38], "Left Arm", { CFrame = CFrame.new(-0.3302573, -0.5996149, -0.7238461, 0.1019129, 0.6147514, -0.7821089, -0.8293875, -0.3816135, -0.4080285, -0.5492996, 0.6902547, 0.4709759) })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.3666667 })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { Weight = 0 })
				I[46] = new("Pose", I[45], "Torso", { Weight = 0 })
					I[47] = new("Pose", I[46], "Left Arm", { CFrame = CFrame.new(-0.3179774, -0.6069415, -0.7098628, 0.0853328, 0.6138346, -0.7848091, -0.8496665, -0.3665546, -0.3790837, -0.5203701, 0.6991743, 0.4902756) })
	return I[1]
end

return build
