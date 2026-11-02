-- Generated from animations/Workspace/Rake Player Animations/player run/AnimSaves/run 2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "run 2", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9987174, 0.049693, -0.0097029, -0.0501523, 0.9446277, -0.3242889, -0.0069492, 0.3243596, 0.9459083), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.3844178, 0.2620333, 0, 0.0886541, 0.9960626, 0, -0.9960626, 0.0886541, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(-0.2369392, 0.006258, -0.0000038, 0.4546381, 0.8906763, 0, -0.8906763, 0.4546381, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.3904487, -0.1751439, -0.0190064, 0.7200254, -0.6477744, -0.248901, 0.6939477, 0.672117, 0.2582544, 0, -0.358674, 0.9334629), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.3181727, 0.1475462, -0.2369486, -0.5176772, -0.7497211, 0.412224, 0.855576, -0.4536283, 0.2494215, -0.0000001, 0.4818088, 0.8762764), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000076, 0, 0.0000009, 0.9999149, -0.0048516, 0.0121098, 0.0017484, 0.9697379, 0.2441424, -0.0129278, -0.2441004, 0.9696637), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(-0.0000054, 0.0451124, -0.0950493, 0.9999614, 0.0087805, -0.0000292, -0.0075088, 0.8534005, -0.5212017, -0.0045515, 0.5211818, 0.8534335), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.1647385, -0.2361547, 0.0013166, 0.6472657, -0.7599631, -0.0591885, 0.7596197, 0.6366097, 0.133064, -0.0634438, -0.1310885, 0.9893385), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.1616835, -0.2317572, -0.0012822, -0.5827022, -0.7003782, 0.412224, 0.8115408, -0.5283849, 0.2494211, 0.0431238, 0.4798749, 0.8762764), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0000076, 0.0000001, 0.0000009, 0.9999149, -0.0071557, 0.0109079, 0.0017484, 0.9021028, 0.4315178, -0.0129278, -0.431462, 0.9020384), EasingDirection = Enum.PoseEasingDirection.Out })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(-0.0000081, 0.0676685, -0.1425739, 0.9998573, -0.0127091, 0.0111294, 0.0162602, 0.9026916, -0.4299807, -0.0045818, 0.4301004, 0.9027694), EasingDirection = Enum.PoseEasingDirection.Out })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9556381, -0.2945436, 0, 0.2945436, 0.9556381, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(0.8943402, 0.4565082, 0.0000016, 0.6909889, 0.7228653, 0, -0.7228653, 0.6909889, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.1473837, -0.2184432, -0.0012116, 0.9142151, 0.4024154, 0.0476722, -0.4052293, 0.9078668, 0.1075504, 0, -0.1176424, 0.993056), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0.1134582, -0.1681662, 0.0009308, 0.8267562, -0.5600172, -0.0534317, 0.5625604, 0.8230186, 0.0785248, 0, -0.0949794, 0.9954792), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0.0000076, 0.0000003, 0.0000011, 0.9999149, -0.0054495, 0.0118528, 0.0017484, 0.9563553, 0.2922013, -0.0129278, -0.2921558, 0.9562833), EasingDirection = Enum.PoseEasingDirection.Out })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9981362, -0.0598166, 0.0120859, 0.0606815, 0.9518588, -0.3004708, 0.006469, 0.3006441, 0.9537144), EasingDirection = Enum.PoseEasingDirection.Out })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(0.219717, -0.0906685, 0, 0.3814709, -0.9243809, 0, 0.9243809, 0.3814709, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(0.4129915, 0.1181859, 0.0000001, 0.0415173, -0.9991378, 0, 0.9991378, 0.0415173, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[29] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.3458151, 0.1704149, -0.3038507, -0.4801939, 0.7113193, -0.5132629, -0.8699585, -0.4610451, 0.1749561, -0.1121877, 0.5305303, 0.8402092), EasingDirection = Enum.PoseEasingDirection.Out })
					I[30] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(-0.3807059, -0.1735416, -0.0189324, 0.4394898, 0.8563963, 0.2709871, -0.8982475, 0.4190131, 0.1325871, 0, -0.3016842, 0.9534079), EasingDirection = Enum.PoseEasingDirection.Out })
					I[31] = new("Pose", I[26], "Head", { CFrame = CFrame.new(0.0000076, 0, 0.0000009, 0.9999149, -0.0041801, 0.0123577, 0.0017484, 0.9816683, 0.1905896, -0.0129278, -0.1905518, 0.981592), EasingDirection = Enum.PoseEasingDirection.Out })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999396, -0.0109637, -0.0007381, 0.0086646, 0.8279947, -0.5606689, 0.0067581, 0.5606286, 0.8280397), EasingDirection = Enum.PoseEasingDirection.Out })
					I[35] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-0.1652274, -0.2118136, -0.001691, -0.6437759, 0.5675507, -0.5132629, -0.7259023, -0.6651739, 0.1749561, -0.2421127, 0.4852112, 0.8402092), EasingDirection = Enum.PoseEasingDirection.Out })
					I[36] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.1053642, -0.1350803, 0.0010906, 0.6936154, 0.7101799, 0.1205905, -0.7200358, 0.6786246, 0.1449723, 0.0211207, -0.1873845, 0.9820595), EasingDirection = Enum.PoseEasingDirection.Out })
					I[37] = new("Pose", I[34], "Head", { CFrame = CFrame.new(0.0000076, 0, 0.0000009, 0.9999149, -0.0071535, 0.0109093, 0.0017484, 0.9021906, 0.431334, -0.0129278, -0.4312783, 0.9021263), EasingDirection = Enum.PoseEasingDirection.Out })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999583, 0.0083657, 0.0036609, -0.0054285, 0.8669546, -0.4983574, -0.007343, 0.4983168, 0.866964), EasingDirection = Enum.PoseEasingDirection.Out })
					I[41] = new("Pose", I[40], "Left Leg", { CFrame = CFrame.new(-0.8901281, 0.1580007, -0.0000031, 0.8481404, -0.5297716, 0, 0.5297716, 0.8481404, 0, 0, 0, 0.9999999), EasingDirection = Enum.PoseEasingDirection.Out })
					I[42] = new("Pose", I[40], "Right Leg", { CFrame = CFrame.new(0.1424846, 0.0084994, 0.0000001, 0.9283508, 0.3717052, 0, -0.3717052, 0.9283508, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[43] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(-0.1097929, -0.1564828, 0.0006562, 0.9279414, 0.3713312, 0.0322163, -0.3727261, 0.9244686, 0.0802061, 0, -0.0864344, 0.9962575), EasingDirection = Enum.PoseEasingDirection.Out })
					I[44] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.1628186, -0.2320585, -0.000976, 0.9038278, -0.4242172, -0.0559911, 0.4278963, 0.8960567, 0.1182677, 0, -0.130852, 0.9914019), EasingDirection = Enum.PoseEasingDirection.Out })
					I[45] = new("Pose", I[40], "Head", { CFrame = CFrame.new(0.0000076, 0.0000001, 0.0000013, 0.9999149, -0.00689, 0.0110776, 0.0017484, 0.912266, 0.4095947, -0.0129278, -0.4095404, 0.9122003), EasingDirection = Enum.PoseEasingDirection.Out })
		I[46] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[47] = new("Pose", I[46], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[48] = new("Pose", I[47], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9987174, 0.049693, -0.0097029, -0.0501523, 0.9446277, -0.3242889, -0.0069492, 0.3243596, 0.9459083), EasingDirection = Enum.PoseEasingDirection.Out })
					I[49] = new("Pose", I[48], "Left Leg", { CFrame = CFrame.new(-0.3844178, 0.2620333, 0, 0.0886541, 0.9960626, 0, -0.9960626, 0.0886541, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[50] = new("Pose", I[48], "Right Leg", { CFrame = CFrame.new(-0.2369392, 0.006258, -0.0000038, 0.4546381, 0.8906763, 0, -0.8906763, 0.4546381, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[51] = new("Pose", I[48], "Left Arm", { CFrame = CFrame.new(0.3904487, -0.1751439, -0.0190064, 0.7200254, -0.6477744, -0.248901, 0.6939477, 0.672117, 0.2582544, 0, -0.358674, 0.9334629), EasingDirection = Enum.PoseEasingDirection.Out })
					I[52] = new("Pose", I[48], "Right Arm", { CFrame = CFrame.new(0.3181727, 0.1475462, -0.2369486, -0.5176772, -0.7497211, 0.412224, 0.855576, -0.4536283, 0.2494215, -0.0000001, 0.4818088, 0.8762764), EasingDirection = Enum.PoseEasingDirection.Out })
					I[53] = new("Pose", I[48], "Head", { CFrame = CFrame.new(0.0000076, 0, 0.0000009, 0.9999149, -0.0048516, 0.0121098, 0.0017484, 0.9697379, 0.2441424, -0.0129278, -0.2441004, 0.9696637), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
