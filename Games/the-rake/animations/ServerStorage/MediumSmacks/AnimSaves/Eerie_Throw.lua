-- Generated from animations/ServerStorage/MediumSmacks/AnimSaves/Eerie_Throw.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Eerie_Throw", { Loop = false }, nil, { "1618105821" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.2516869, -0.2659064, -0.3827918, -0.2532127, -0.9047398, 0.3425335, 0.7425312, -0.4087203, -0.5306552, 0.6201053, 0.1199732, 0.7752907), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.2516869, -0.2659063, -0.3827916, -0.2532128, 0.9047397, -0.3425334, -0.7425311, -0.4087204, -0.5306553, -0.6201054, 0.119973, 0.7752907), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[4], "Head", { EasingStyle = Enum.PoseEasingStyle.Cubic })
			I[8] = new("Pose", I[2], "HHandle", { CFrame = CFrame.new(0, 1.2, -1.0000001), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8886885, 0.4541053, 0.0634117, -0.4585114, 0.8801486, 0.1229047, 0, -0.138299, 0.9903905), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(0.224241, -0.0949251, 0.0560168, -0.943795, -0.0698856, -0.3230589, 0.1740229, -0.9360202, -0.3059123, -0.2810107, -0.3449382, 0.895573), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.0004271, -0.0000083, 0.0000381, 0.6806186, 0.6562823, 0.3256563, -0.6980339, 0.7158817, 0.016196, -0.2225022, -0.2383424, 0.9453496), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[11], "Head", { CFrame = CFrame.new(0.0000746, -0.0002086, -0.0000099, 0.8836305, -0.4625153, 0.0726414, 0.468185, 0.8729298, -0.1371, 0, 0.1551553, 0.9878901), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8770662, -0.4802779, 0.0093877, 0.4617582, 0.8375371, -0.2920804, 0.1324172, 0.2605087, 0.9563477), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[17], "Right Arm", { CFrame = CFrame.new(0.2248107, -0.1003443, -0.5999131, 0.5588033, -0.2935883, 0.7755932, 0.8017923, 0.4301442, -0.4148552, -0.2118202, 0.853687, 0.4757629), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[17], "Left Arm", { CFrame = CFrame.new(-0.0009336, 0.0001646, 0.000018, 0.9330639, -0.2443532, 0.2639756, 0.156039, 0.9361658, 0.3150321, -0.324104, -0.2527547, 0.9116312), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[20] = new("Pose", I[17], "Head", { CFrame = CFrame.new(-0.0000223, -0.0004836, 0.0001611, 0.8605942, 0.470582, 0.194757, -0.4920048, 0.8669792, 0.0792357, -0.1315634, -0.1640112, 0.9776458), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 0.7333333 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { Weight = 0 })
				I[23] = new("Pose", I[22], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8254823, -0.5643499, 0.0093877, 0.542026, 0.7879702, -0.2920802, 0.1574382, 0.2461954, 0.9563478), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(0.2247648, -0.1002871, -0.5998982, 0.5181934, -0.3114625, 0.7965342, 0.8517842, 0.2718646, -0.4478318, -0.0770667, 0.9105387, 0.4061772), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[23], "Left Arm", { CFrame = CFrame.new(-0.000945, 0.0001841, -0.0000005, 0.9330636, -0.2592312, 0.249382, 0.156039, 0.9163501, 0.36872, -0.324105, -0.3051258, 0.8954631), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[26] = new("Pose", I[23], "Head", { CFrame = CFrame.new(-0.0000198, -0.0004943, 0.0001678, 0.8199569, 0.5382754, 0.1947571, -0.5601426, 0.8245983, 0.0792356, -0.1179457, -0.1740615, 0.9776459), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 1.3333334 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 })
				I[29] = new("Pose", I[28], "Torso")
					I[30] = new("Pose", I[29], "Right Arm")
					I[31] = new("Pose", I[29], "Left Arm")
					I[32] = new("Pose", I[29], "Head")
	return I[1]
end

return build
