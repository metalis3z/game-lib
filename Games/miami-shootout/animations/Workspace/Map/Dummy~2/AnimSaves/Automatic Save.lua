-- Generated from animations/Workspace/Map/Dummy~2/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Action2 }, nil, { "1680933948" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.9840353, 0, 0.1779737, 0, 1, 0, -0.1779737, 0, 0.9840353) })
						I[6] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(-0.171051, -0.0324304, 0.1417236, 0.8887042, 0.387224, 0.2454842, 0.2358889, 0.0729505, -0.969038, -0.3931429, 0.9190951, -0.0265104) })
							I[7] = new("Pose", I[6], "RightLowerArm", { CFrame = CFrame.new(-0.0000305, 0.0002441, 0.0000458, 1.0000002, -0.0000001, -0.0000001, -0.0000001, 0.9815736, -0.1910855, 0, 0.1910856, 0.9815734) })
								I[8] = new("Pose", I[7], "RightHand", { CFrame = CFrame.new(0, 0, 0.0000153, 0.976211, 0.0247202, -0.2154156, 0.0215974, 0.9774551, 0.2100381, 0.2157508, -0.2096936, 0.9536672) })
									I[9] = new("Pose", I[8], "Handle", { CFrame = CFrame.new(-0.0001221, 0.0607834, -0.0305176, 1.0000001, 0, 0.0000001, 0, 0.9978029, -0.0662441, 0.0000001, 0.066244, 0.9978032) })
										I[10] = new("Pose", I[9], "1")
										I[11] = new("Pose", I[9], "2")
										I[12] = new("Pose", I[9], "3")
										I[13] = new("Pose", I[9], "Slide")
										I[14] = new("Pose", I[9], "4")
						I[15] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.1530151, 0.0231533, -0.307251, 0.5000001, -0.8528686, -0.1503834, -0.0000002, 0.1736476, -0.9848078, 0.8660253, 0.4924041, 0.0868236) })
							I[16] = new("Pose", I[15], "LeftLowerArm", { CFrame = CFrame.new(0, 0.0001526, 0.0000381, 0.9961951, -0.0868226, 0.0075961, 0.0858298, 0.9621935, -0.2584905, 0.0151343, 0.2581586, 0.9659845) })
								I[17] = new("Pose", I[16], "LeftHand", { CFrame = CFrame.new(0.0911865, 0.0067139, -0.0025673, 0.1714452, -0.0713939, 0.9826036, 0.0616285, 0.9961949, 0.0616283, -0.9832644, 0.0499904, 0.1751929) })
						I[18] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 0.979338, 0, -0.2022302, 0, 1, 0, 0.2022302, 0, 0.979338) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.0333333 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "UpperTorso", { Weight = 0 })
						I[23] = new("Pose", I[22], "RightUpperArm", { Weight = 0 })
							I[24] = new("Pose", I[23], "RightLowerArm", { Weight = 0 })
								I[25] = new("Pose", I[24], "RightHand", { Weight = 0 })
									I[26] = new("Pose", I[25], "Handle", { Weight = 0 })
										I[27] = new("Pose", I[26], "1", { CFrame = CFrame.new(0, -0.1205444, -0.3582153, 1.0000001, 0, 0, 0, 0.9999997, 0.0000001, 0, 0.0000001, 0.9999998) })
										I[28] = new("Pose", I[26], "2", { CFrame = CFrame.new(-0.000061, -0.1205139, -0.3583374, 1.0000001, 0, 0, 0, 0.9999995, 0.0000001, 0, 0.0000001, 0.9999998) })
										I[29] = new("Pose", I[26], "3", { CFrame = CFrame.new(0, -0.1205444, -0.3583374, 1.0000002, 0, 0.0000001, 0, 0.9999993, 0.0000001, 0.0000001, 0.0000001, 0.9999998) })
										I[30] = new("Pose", I[26], "Slide", { CFrame = CFrame.new(0, 0.0000038, 0.3621216, 1.0000001, 0, 0, 0, 0.9999994, 0, 0, 0, 0.9999998) })
										I[31] = new("Pose", I[26], "4", { CFrame = CFrame.new(0, -0.1205444, -0.3583374, 1.0000001, 0, 0, 0, 0.9999997, 0.0000001, 0, 0.0000001, 0.9999998) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "LowerTorso", { Weight = 0 })
					I[35] = new("Pose", I[34], "UpperTorso", { Weight = 0 })
						I[36] = new("Pose", I[35], "RightUpperArm", { Weight = 0 })
							I[37] = new("Pose", I[36], "RightLowerArm", { Weight = 0 })
								I[38] = new("Pose", I[37], "RightHand", { Weight = 0 })
									I[39] = new("Pose", I[38], "Handle", { Weight = 0 })
										I[40] = new("Pose", I[39], "1", { CFrame = CFrame.new(0.000061, -0.0353394, -0.1035156, 1.0000007, 0, 0, 0, 0.9999999, 0, 0, 0, 1) })
										I[41] = new("Pose", I[39], "2", { CFrame = CFrame.new(0, -0.0352783, -0.1036377, 1.0000007, 0, 0, 0, 0.9999996, 0, 0, 0, 1) })
										I[42] = new("Pose", I[39], "3", { CFrame = CFrame.new(0, -0.0353088, -0.1037598, 1.0000006, 0, 0, 0, 0.9999996, 0, 0, 0, 1) })
										I[43] = new("Pose", I[39], "Slide", { CFrame = CFrame.new(0, 0.0000076, 0.1015015, 1.0000006, 0, 0, 0, 0.9999997, 0.0000001, 0, 0.0000001, 1) })
										I[44] = new("Pose", I[39], "4", { CFrame = CFrame.new(0.000061, -0.0353394, -0.1036377, 1.0000007, 0, 0, 0, 0.9999999, 0, 0, 0, 1) })
		I[45] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[46] = new("Pose", I[45], "HumanoidRootPart", { Weight = 0 })
				I[47] = new("Pose", I[46], "LowerTorso", { Weight = 0 })
					I[48] = new("Pose", I[47], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.9840353, 0, 0.1779737, 0, 1, 0, -0.1779737, 0, 0.9840353) })
						I[49] = new("Pose", I[48], "RightUpperArm", { CFrame = CFrame.new(-0.171051, -0.0324304, 0.1417236, 0.8887042, 0.387224, 0.2454842, 0.2358889, 0.0729505, -0.969038, -0.3931429, 0.9190951, -0.0265104) })
							I[50] = new("Pose", I[49], "RightLowerArm", { CFrame = CFrame.new(-0.0000305, 0.0002441, 0.0000458, 1.0000002, -0.0000001, -0.0000001, -0.0000001, 0.9815736, -0.1910855, 0, 0.1910856, 0.9815734) })
								I[51] = new("Pose", I[50], "RightHand", { CFrame = CFrame.new(0, 0, 0.0000153, 0.976211, 0.0247202, -0.2154156, 0.0215974, 0.9774551, 0.2100381, 0.2157508, -0.2096936, 0.9536672) })
									I[52] = new("Pose", I[51], "Handle", { CFrame = CFrame.new(-0.0001221, 0.0607834, -0.0305176, 1.0000001, 0, 0.0000001, 0, 0.9978029, -0.0662441, 0.0000001, 0.066244, 0.9978032) })
										I[53] = new("Pose", I[52], "1")
										I[54] = new("Pose", I[52], "2")
										I[55] = new("Pose", I[52], "3")
										I[56] = new("Pose", I[52], "Slide")
										I[57] = new("Pose", I[52], "4")
						I[58] = new("Pose", I[48], "LeftUpperArm", { CFrame = CFrame.new(0.1530151, 0.0231533, -0.307251, 0.5000001, -0.8528686, -0.1503834, -0.0000002, 0.1736476, -0.9848078, 0.8660253, 0.4924041, 0.0868236) })
							I[59] = new("Pose", I[58], "LeftLowerArm", { CFrame = CFrame.new(0, 0.0001526, 0.0000381, 0.9961951, -0.0868226, 0.0075961, 0.0858298, 0.9621935, -0.2584905, 0.0151343, 0.2581586, 0.9659845) })
								I[60] = new("Pose", I[59], "LeftHand", { CFrame = CFrame.new(0.0911865, 0.0067139, -0.0025673, 0.1714452, -0.0713939, 0.9826036, 0.0616285, 0.9961949, 0.0616283, -0.9832644, 0.0499904, 0.1751929) })
						I[61] = new("Pose", I[48], "Head", { CFrame = CFrame.new(0, 0, 0, 0.979338, 0, -0.2022302, 0, 1, 0, 0.2022302, 0, 0.979338) })
	return I[1]
end

return build
