-- Generated from animations/ReplicatedStorage/Auras/Eldritch/AnimSaves/EDLRITCHV2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "EDLRITCHV2", nil, nil, { "1708432834" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0.8020313, 1, 0, 0, 0, 0.9981377, 0.0610012, 0, -0.0610012, 0.9981377) })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.0844792, 0.2112509, 0.0043814, 0.9879004, -0.1550896, -0.0000238, 0.1550557, 0.9876872, -0.020781, 0.0032464, 0.0205258, 0.9997841) })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.1777518, -0.2208283, -0.075888, 0.6925501, -0.7213698, 0.0000232, 0.6838025, 0.656494, 0.3184804, -0.2297574, -0.2205478, 0.9479294) })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9942528, -0.1070578, 0, 0.1070578, 0.9942528) })
					I[8] = new("Pose", I[4], "Part", { CFrame = CFrame.new(0.0006918, -0.6368689, 0.0546829) })
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.388425, -0.2485242, -0.2522336, 0.7391036, 0.6565129, 0.1507211, -0.6626207, 0.6684103, 0.337878, 0.1210777, -0.3495977, 0.9290434) })
					I[10] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.1703039, 0.2495582, 0, 0.9922743, 0.1240634, 0, -0.1240634, 0.9922743, 0, 0, 0, 1) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 2.5166667 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0.0436561, 1.5159041, 1, 0, 0, 0, 0.9981377, 0.0610012, 0, -0.0610012, 0.9981377) })
					I[14] = new("Pose", I[13], "Left Leg", { CFrame = CFrame.new(0.0844792, 0.2112508, 0.0043814, 0.9540151, -0.2997585, 0.0000305, 0.2996949, 0.9538107, -0.0206919, 0.0061735, 0.0197495, 0.9997859) })
					I[15] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(-0.1777518, -0.2208283, -0.075888, 0.6049773, -0.7962427, -0.0000366, 0.7547925, 0.5734691, 0.3184676, -0.2535565, -0.1926933, 0.9479337) })
					I[16] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9999962, 0.0027623, 0, -0.0027623, 0.9999962) })
					I[17] = new("Pose", I[13], "Part", { CFrame = CFrame.new(0.0003142, -0.2892475, 0.0248354) })
					I[18] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(0.388425, -0.2485243, -0.2522336, 0.6884778, 0.7094296, 0.1506921, -0.7102751, 0.6175253, 0.3378933, 0.1466553, -0.3396648, 0.9290425) })
					I[19] = new("Pose", I[13], "Right Leg", { CFrame = CFrame.new(0.1703039, 0.2495582, 0, 0.9999081, 0.0135522, 0, -0.0135522, 0.9999081, 0, 0, 0, 1) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 4.8000002 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, -0.003342, 0.7473828, 1, 0, 0, 0, 0.9981377, 0.0610012, 0, -0.0610012, 0.9981377) })
					I[23] = new("Pose", I[22], "Left Leg", { CFrame = CFrame.new(0.0844792, 0.2112509, 0.0043814, 0.9879004, -0.1550896, -0.0000238, 0.1550557, 0.9876872, -0.020781, 0.0032464, 0.0205258, 0.9997841) })
					I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(-0.1777518, -0.2208283, -0.075888, 0.6735475, -0.739144, -0.000039, 0.700663, 0.6384647, 0.3184873, -0.2353831, -0.2145436, 0.9479271) })
					I[25] = new("Pose", I[22], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.992708, -0.1205441, 0, 0.1205441, 0.992708) })
					I[26] = new("Pose", I[22], "Part", { CFrame = CFrame.new(0.0007666, -0.7056948, 0.0605924) })
					I[27] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(0.388425, -0.2485243, -0.2522335, 0.7650092, 0.6261365, 0.1507117, -0.6350931, 0.6946305, 0.3378541, 0.1068539, -0.3541775, 0.9290536) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 4.7833333 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "Right Leg", { CFrame = CFrame.new(0.2108733, 0.2743254, 0, 0.9882748, 0.1526857, 0, -0.1526857, 0.9882748, 0, 0, 0, 1) })
	return I[1]
end

return build
