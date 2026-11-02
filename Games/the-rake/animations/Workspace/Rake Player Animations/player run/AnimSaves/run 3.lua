-- Generated from animations/Workspace/Rake Player Animations/player run/AnimSaves/run 3.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "run 3", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(-0.0031302, -0.0150616, 0.0598574, 0.9987423, 0.0464432, -0.0188905, -0.0496499, 0.9685793, -0.2436986, 0.0069789, 0.24433, 0.969667), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.2483267, -0.0784431, -0.0350658, 0.3694679, 0.9292019, 0.0088081, -0.9243541, 0.3684784, -0.0989618, -0.095201, 0.0284214, 0.9950523), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(-0.2369374, 0.0062529, 0.0000093, 0.2258217, 0.9697315, 0.0928724, -0.9728608, 0.2195531, 0.0730622, 0.0504603, -0.1068509, 0.9929937), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3548248, 0.0028396, -0.1997119, -0.5625864, 0.7671236, -0.3082499, -0.8165665, -0.5739043, 0.0620718, -0.1292892, 0.2866273, 0.9492781), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.360227, -0.1270584, -0.0506119, 0.4805754, 0.8719147, 0.0938722, -0.8714907, 0.4867671, -0.059681, -0.0977306, -0.0531275, 0.9937938), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, -0.0000002, 1, 0, 0, 0, 0.9987842, 0.0492958, 0, -0.0492958, 0.9987842), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(-0.0008672, 0.0873836, -0.1397313, 0.9998573, -0.012936, 0.0108649, 0.0152175, 0.9689606, -0.2467463, -0.0073357, 0.2468764, 0.9690192), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.1281415, 0.0873452, 0.0000001, 0.9566665, 0.2878141, 0.0441835, -0.2896298, 0.9562019, 0.0423396, -0.0300624, -0.0533018, 0.9981259), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.5172478, 0.3064297, -0.0000024, 0.6168612, 0.7863248, 0.0342872, -0.7852872, 0.6178102, -0.040431, -0.0529748, -0.001985, 0.9985938), EasingDirection = Enum.PoseEasingDirection.Out })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[16] = new("Pose", I[15], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[17] = new("Pose", I[16], "Left Leg", { CFrame = CFrame.new(-0.000001, 0.0000036, 0.0000005, 0.9556381, -0.2944324, -0.0080929, 0.2945436, 0.9552773, 0.0262571, 0, -0.0274759, 0.9996225), EasingDirection = Enum.PoseEasingDirection.Out })
				I[18] = new("Pose", I[16], "Right Leg", { CFrame = CFrame.new(1.2691315, 0.0151061, -0.0377795, 0.4710706, 0.8809435, 0.0450667, -0.879854, 0.4728999, -0.0471457, -0.0628448, -0.0174431, 0.9978709), EasingDirection = Enum.PoseEasingDirection.Out })
				I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.2496625, -0.2337453, -0.1865633, 0.2610674, 0.902169, -0.3434164, -0.9599507, 0.2801028, 0.0060808, 0.1016778, 0.3280753, 0.9391636), EasingDirection = Enum.PoseEasingDirection.Out })
				I[20] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(0.1238419, -0.5217876, -0.0450613, 0.8726861, 0.3632212, 0.3263269, -0.4177827, 0.9013681, 0.1139873, -0.252738, -0.2358089, 0.938359), EasingDirection = Enum.PoseEasingDirection.Out })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[23] = new("Pose", I[22], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9971296, -0.0579371, 0.0487429, 0.0682053, 0.9668574, -0.2460381, -0.0328728, 0.2486565, 0.9680338), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[23], "Left Leg", { CFrame = CFrame.new(0.2197143, -0.0906682, -0.0000001, 0.2519107, -0.9630145, -0.0956248, 0.9584457, 0.2345984, 0.1623131, -0.1338765, -0.1325396, 0.9820949), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[23], "Right Leg", { CFrame = CFrame.new(0.4167381, -0.024246, -0.0129244, 0.4596929, -0.8880635, -0.0050529, 0.881202, 0.456833, -0.1216002, 0.1102971, 0.0514461, 0.9925663), EasingDirection = Enum.PoseEasingDirection.Out })
					I[26] = new("Pose", I[23], "Left Arm", { CFrame = CFrame.new(0.431857, -0.0719666, -0.1650732, 0.377584, -0.9106354, -0.1678497, 0.9234196, 0.3837624, -0.0047612, 0.0687502, -0.153198, 0.9858011), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[27] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(0.2893757, 0.1373371, -0.0139596, -0.5391893, -0.8093451, 0.2328849, 0.8412139, -0.5042948, 0.1950535, -0.040423, 0.3010768, 0.9527427), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[28] = new("Pose", I[23], "Head", { CFrame = CFrame.new(0, 0, -0.0000002, 1, 0, 0, 0, 0.9966815, 0.0814003, 0, -0.0814003, 0.9966815), EasingDirection = Enum.PoseEasingDirection.Out })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[30] = new("Pose", I[29], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[31] = new("Pose", I[30], "Left Leg", { CFrame = CFrame.new(-0.5201814, 0.0751105, 0.0000011, 0.5408981, -0.8402749, -0.0369786, 0.838771, 0.5421476, -0.0503911, 0.0623902, -0.0037602, 0.9980447), EasingDirection = Enum.PoseEasingDirection.Out })
				I[32] = new("Pose", I[30], "Right Leg", { CFrame = CFrame.new(0.2326536, 0.0450613, 0.0000001, 0.9671028, -0.2515366, -0.0379678, 0.2518263, 0.9677679, 0.002973, 0.0359962, -0.0124365, 0.9992746), EasingDirection = Enum.PoseEasingDirection.Out })
				I[33] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(0.2779723, -0.3344596, -0.1649498, 0.5459715, -0.7769395, -0.3134968, 0.8286166, 0.5560185, 0.0650991, 0.123732, -0.2953109, 0.9473552), EasingDirection = Enum.PoseEasingDirection.Out })
				I[34] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(0.3459665, -0.1329872, -0.0185245, -0.1429013, -0.9422091, 0.30302, 0.9810324, -0.094327, 0.1693455, -0.1309759, 0.3214721, 0.9378172), EasingDirection = Enum.PoseEasingDirection.Out })
		I[35] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[36] = new("Pose", I[35], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[37] = new("Pose", I[36], "Torso", { CFrame = CFrame.new(-0.0021071, 0.1236779, -0.2064023, 0.9998573, -0.012178, 0.0117082, 0.0152175, 0.9502256, -0.3111909, -0.0073357, 0.3113246, 0.9502753), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[38] = new("Pose", I[37], "Left Leg", { CFrame = CFrame.new(-1.3966427, 0.5538799, -0.0001556, 0.6151064, -0.7878995, -0.0293008, 0.7870258, 0.6158038, -0.037095, 0.0472707, -0.0002431, 0.9988821), EasingDirection = Enum.PoseEasingDirection.Out })
					I[39] = new("Pose", I[37], "Right Leg", { CFrame = CFrame.new(0.1424842, 0.0085005, -0.0000011, 0.9283508, 0.3713129, 0.0170725, -0.3717052, 0.9273711, 0.0426393, 0, -0.0459302, 0.9989446), EasingDirection = Enum.PoseEasingDirection.Out })
					I[40] = new("Pose", I[37], "Left Arm", { CFrame = CFrame.new(-0.2521003, -0.0967547, -0.1817563, 0.9674969, 0.0152853, -0.2524204, -0.0043273, 0.9990261, 0.0439102, 0.2528457, -0.0413906, 0.9666209), EasingDirection = Enum.PoseEasingDirection.Out })
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[42] = new("Pose", I[41], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[43] = new("Pose", I[42], "Torso", { CFrame = CFrame.new(-0.0031302, -0.0150616, 0.0598574, 0.9987423, 0.0464432, -0.0188905, -0.0496499, 0.9685793, -0.2436986, 0.0069789, 0.24433, 0.969667), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[44] = new("Pose", I[43], "Left Leg", { CFrame = CFrame.new(-0.2483267, -0.0784431, -0.0350658, 0.3694679, 0.9292019, 0.0088081, -0.9243541, 0.3684784, -0.0989618, -0.095201, 0.0284214, 0.9950523), EasingDirection = Enum.PoseEasingDirection.Out })
					I[45] = new("Pose", I[43], "Right Leg", { CFrame = CFrame.new(-0.2369374, 0.0062529, 0.0000093, 0.2258217, 0.9697315, 0.0928724, -0.9728608, 0.2195531, 0.0730622, 0.0504603, -0.1068509, 0.9929937), EasingDirection = Enum.PoseEasingDirection.Out })
					I[46] = new("Pose", I[43], "Left Arm", { CFrame = CFrame.new(-0.3548248, 0.0028396, -0.1997119, -0.5625864, 0.7671236, -0.3082499, -0.8165665, -0.5739043, 0.0620718, -0.1292892, 0.2866273, 0.9492781), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[47] = new("Pose", I[43], "Right Arm", { CFrame = CFrame.new(-0.360227, -0.1270584, -0.0506119, 0.4805754, 0.8719147, 0.0938722, -0.8714907, 0.4867671, -0.059681, -0.0977306, -0.0531275, 0.9937938), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[48] = new("Pose", I[43], "Head", { CFrame = CFrame.new(0, 0, -0.0000002, 1, 0, 0, 0, 0.9987842, 0.0492958, 0, -0.0492958, 0.9987842), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
