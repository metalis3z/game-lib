-- Generated from animations/Workspace/Ignored/Dummy R6~2/AnimSaves/equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "equip", { Loop = false, Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.9213137, -0.6146363, -0.662987, -0.9109166, -0.3749371, -0.172201, -0.3809562, 0.6040424, 0.7000037, -0.1584406, 0.703246, -0.6930668) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0065789, 0.0113188, 0.0002006, 0.9131371, 0.1436198, -0.3815156, -0.1143723, 0.9885534, 0.0983926, 0.3912796, -0.0462112, 0.9191109) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { Weight = 0 })
					I[11] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(1.1495141, -0.2139255, -0.314943, -0.6013664, -0.7802048, -0.1721595, -0.631916, 0.3325971, 0.7000438, -0.4889178, 0.5297731, -0.6930367) })
						I[12] = new("Pose", I[11], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
					I[13] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(0, 0, 0, 0.7078928, -0.3041203, -0.637494, 0.4936791, 0.8585231, 0.1386327, 0.5051423, -0.4128546, 0.7578802), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { Weight = 0 })
						I[18] = new("Pose", I[17], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "Torso", { Weight = 0 })
					I[22] = new("Pose", I[21], "Right Arm", { CFrame = CFrame.new(1.3075242, -0.4656371, -0.5943782, -0.3983009, -0.897586, 0.188935, 0.2678109, 0.0832055, 0.9598722, -0.877288, 0.4329165, 0.2072422) })
						I[23] = new("Pose", I[22], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { Weight = 0 })
					I[27] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(0.6834717, -0.3887371, -0.2386701, -0.3186992, -0.9184655, 0.2342049, 0.9229903, -0.2444909, 0.2971752, -0.2156842, 0.3108784, 0.9256538) })
						I[28] = new("Pose", I[27], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 })
				I[31] = new("Pose", I[30], "Torso", { Weight = 0 })
					I[32] = new("Pose", I[31], "Right Arm", { CFrame = CFrame.new(0.4360225, -0.2517484, -0.0042304, -0.2819213, -0.9325638, 0.2254897, 0.9416382, -0.3140017, -0.1213302, 0.1839522, 0.1781242, 0.966661) })
						I[33] = new("Pose", I[32], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { Weight = 0 })
					I[37] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(0.3264551, -0.2388493, -0.0096138, -0.1193004, -0.950168, 0.288008, 0.9841591, -0.1514862, -0.092104, 0.1311435, 0.2724576, 0.9531885) })
						I[38] = new("Pose", I[37], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[40] = new("Pose", I[39], "HumanoidRootPart", { Weight = 0 })
				I[41] = new("Pose", I[40], "Torso", { Weight = 0 })
					I[42] = new("Pose", I[41], "Right Arm", { CFrame = CFrame.new(0.2370493, -0.2290666, -0.082164, 0.1031076, -0.9090645, 0.4036964, 0.99273, 0.119388, 0.0152923, -0.0620982, 0.3991847, 0.9147652) })
						I[43] = new("Pose", I[42], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
					I[44] = new("Pose", I[41], "Left Arm", { CFrame = CFrame.new(-0.7141795, -0.1282139, -0.1891067, 0.2937554, 0.9548858, 0.0435985, -0.9205627, 0.294891, -0.2561318, -0.2574335, 0.0351049, 0.9656581) })
		I[45] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[46] = new("Pose", I[45], "HumanoidRootPart", { Weight = 0 })
				I[47] = new("Pose", I[46], "Torso", { Weight = 0 })
					I[48] = new("Pose", I[47], "Right Arm", { CFrame = CFrame.new(0.1506403, -0.1641003, -0.269477, 0.4164721, -0.6369984, 0.6486787, 0.7771478, 0.6197025, 0.1095906, -0.4717968, 0.4584777, 0.7531307) })
						I[49] = new("Pose", I[48], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
					I[50] = new("Pose", I[47], "Left Arm", { CFrame = CFrame.new(-0.5293689, -0.1326456, -0.3260034, 0.416996, 0.9039728, -0.0945906, -0.8927465, 0.3878187, -0.2293476, -0.17064, 0.1800825, 0.9687375) })
		I[51] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[52] = new("Pose", I[51], "HumanoidRootPart", { Weight = 0 })
				I[53] = new("Pose", I[52], "Torso", { Weight = 0 })
					I[54] = new("Pose", I[53], "Right Arm", { CFrame = CFrame.new(0.1477609, -0.154979, -0.2979016, 0.4395249, -0.5906311, 0.6767367, 0.7332853, 0.6710582, 0.1094232, -0.5187585, 0.4481469, 0.728048) })
						I[55] = new("Pose", I[54], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
					I[56] = new("Pose", I[53], "Left Arm", { CFrame = CFrame.new(-0.2421919, -0.1275277, -0.5575048, 0.5847807, 0.7380857, -0.3365428, -0.8108378, 0.5440958, -0.2156428, 0.0239487, 0.3989854, 0.9166445) })
		I[57] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[58] = new("Pose", I[57], "HumanoidRootPart", { Weight = 0 })
				I[59] = new("Pose", I[58], "Torso", { Weight = 0 })
					I[60] = new("Pose", I[59], "Right Arm", { CFrame = CFrame.new(0.1471206, -0.151893, -0.3079716, 0.4526689, -0.6160297, 0.6446694, 0.7814701, 0.6222535, 0.045883, -0.4294131, 0.4830198, 0.7630835) })
						I[61] = new("Pose", I[60], "Handle", { CFrame = CFrame.new(0.1799199, -0.1974863, -1.5954399, -0.8004591, 0.2020381, 0.5643101, -0.4455315, 0.4292416, -0.7856548, -0.4009576, -0.8803024, -0.253576) })
					I[62] = new("Pose", I[59], "Left Arm", { CFrame = CFrame.new(-0.1342257, -0.1022531, -0.7082412, 0.6755901, 0.6840708, -0.2750004, -0.7336507, 0.5868008, -0.3426681, -0.0730388, 0.4332575, 0.8983058) })
		I[63] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[64] = new("Pose", I[63], "HumanoidRootPart", { Weight = 0 })
				I[65] = new("Pose", I[64], "Torso", { Weight = 0 })
					I[66] = new("Pose", I[65], "Left Arm", { CFrame = CFrame.new(-0.0118387, 0.0175598, -0.0008255, 0.8759556, -0.0440271, -0.4803784, 0.1242461, 0.9828202, 0.1364827, 0.4661167, -0.1792379, 0.866377) })
		I[67] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[68] = new("Pose", I[67], "HumanoidRootPart", { Weight = 0 })
				I[69] = new("Pose", I[68], "Torso", { Weight = 0 })
					I[70] = new("Pose", I[69], "Left Arm", { CFrame = CFrame.new(-0.0079948, 0.0102977, -0.0012167, 0.7867714, -0.2132774, -0.5792266, 0.3579933, 0.9221228, 0.1467317, 0.5028235, -0.3228036, 0.8018518) })
		I[71] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[72] = new("Pose", I[71], "HumanoidRootPart", { Weight = 0 })
				I[73] = new("Pose", I[72], "Torso", { Weight = 0 })
					I[74] = new("Pose", I[73], "Left Arm", { CFrame = CFrame.new(-0.1913726, -0.1251187, -0.6031204, 0.60914, 0.6948549, -0.3822632, -0.7901971, 0.5727183, -0.218134, 0.0673577, 0.4349374, 0.8979379) })
	return I[1]
end

return build
