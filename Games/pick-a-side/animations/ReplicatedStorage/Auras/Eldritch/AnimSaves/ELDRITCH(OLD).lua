-- Generated from animations/ReplicatedStorage/Auras/Eldritch/AnimSaves/ELDRITCH(OLD).rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "ELDRITCH(OLD)")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 1.1017931, 1, 0, 0, 0, 0.9976571, 0.0684133, 0, -0.0684133, 0.9976571) })
					I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9923705, 0, -0.123291, 0, 1, 0, 0.123291, 0, 0.9923705) })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(0.1170007, 0.0146336, 0, 0.9922743, -0.1240634, 0, 0.1240634, 0.9922743, 0, 0, 0, 1) })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.7157335, -0.3922038, -0.2837393, 0.7355011, -0.6722717, -0.0841964, 0.6177732, 0.6144122, 0.4907686, -0.2781985, -0.4129751, 0.8672123) })
					I[9] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.27262, 0.277354, 0, 0.9776909, 0.2100486, 0, -0.2100486, 0.9776909, 0, 0, 0, 1) })
					I[10] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(0.4495191, -0.3187042, -0.2127602, 0.8197292, 0.5309014, 0.2149132, -0.5707776, 0.7260915, 0.383411, 0.0475067, -0.4369609, 0.8982251) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 2.2666667 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("IntValue", I[12], "Null")
				I[14] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0.031708, 1.5641246, 1, 0, 0, 0, 0.9976571, 0.0684133, 0, -0.0684133, 0.9976571) })
					I[15] = new("Pose", I[14], "Left Leg", { CFrame = CFrame.new(0.0964196, 0.1791856, 0, 0.9922743, -0.1240634, 0, 0.1240634, 0.9922743, 0, 0, 0, 1) })
					I[16] = new("Pose", I[14], "Right Arm", { CFrame = CFrame.new(-0.7157335, -0.3922038, -0.2837393, 0.4783928, -0.8741023, -0.0841751, 0.7833187, 0.3814409, 0.4908306, -0.3969283, -0.3007458, 0.8671793) })
					I[17] = new("Pose", I[14], "Right Leg", { CFrame = CFrame.new(0.3018029, 0.4132057, 0, 0.9776909, 0.2100486, 0, -0.2100486, 0.9776909, 0, 0, 0, 1) })
					I[18] = new("Pose", I[14], "Left Arm", { CFrame = CFrame.new(0.4495191, -0.3187042, -0.2127601, 0.5891626, 0.7789237, 0.2148612, -0.7844124, 0.4875604, 0.3833825, 0.1938679, -0.3944144, 0.8982497) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 3.9000001 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("IntValue", I[20], "Null")
				I[22] = new("Pose", I[20], "Torso", { CFrame = CFrame.new(0, 0.0012267, 1.1196799, 1, 0, 0, 0, 0.9976571, 0.0684133, 0, -0.0684133, 0.9976571) })
					I[23] = new("Pose", I[22], "Left Leg", { CFrame = CFrame.new(0.1221079, -0.0262005, 0, 0.9922743, -0.1240634, 0, 0.1240634, 0.9922743, 0, 0, 0, 1) })
					I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(-0.7157336, -0.3922038, -0.2837393, 0.7549857, -0.650314, -0.0841922, 0.5993996, 0.6323373, 0.4907847, -0.2659263, -0.4210002, 0.8672036) })
					I[25] = new("Pose", I[22], "Right Leg", { CFrame = CFrame.new(0.2645139, 0.2396187, 0, 0.9776909, 0.2100486, 0, -0.2100486, 0.9776909, 0, 0, 0, 1) })
					I[26] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(0.4495191, -0.3187042, -0.2127601, 0.8296953, 0.5152092, 0.2148607, -0.5568357, 0.7368212, 0.3834431, 0.0392395, -0.4377831, 0.8982239) })
	return I[1]
end

return build
