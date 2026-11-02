-- Generated from animations/Workspace/rake classic anims/AnimSaves/RakeAttack1.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "RakeAttack1", { Loop = false }, nil, { "1595679659" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396927, -0.3420199, 0, 0.3420199, 0.9396927), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.0000004, 0.0000003, 0.0000049, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000029, 0.0000007, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3368239, 0.0593911, -0.3213935, 0.9289983, -0.1834889, -0.1169777, 0.1533352, 0.9812259), EasingDirection = Enum.PoseEasingDirection.Out })
					I[11] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(0.0000002, 0.0000001, 0.0000052, 0.0141761, 0.9949236, -0.0996282, -0.7721632, 0.074196, 0.6310775, 0.6352659, 0.067983, 0.7692948), EasingDirection = Enum.PoseEasingDirection.Out })
					I[12] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000031, 0.0000005, -0.2649395, -0.4058426, -0.8746992, 0.8858889, -0.4606752, -0.0545849, -0.3807994, -0.7893478, 0.4815825), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[10], "Head", { CFrame = CFrame.new(0, 0, 0.0000003, 0.9857236, -0.168369, 0.0008886, 0.165811, 0.9716374, 0.1686041, -0.0292511, -0.1660498, 0.9856834), EasingDirection = Enum.PoseEasingDirection.Out })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8660255, 0.4698461, 0.17101, -0.4698461, 0.8816975, -0.0430586, -0.17101, -0.0430586, 0.9843279), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(0.0000004, 0.0000002, 0.0000051, 0.2263441, 0.9430339, -0.2438343, 0.1692141, 0.2084556, 0.9632823, 0.9592361, -0.2592934, -0.1123921), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000032, 0.0000007, -0.2649395, -0.247787, -0.9318844, 0.8858889, -0.4441979, -0.133751, -0.3807994, -0.8609816, 0.3371973), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[16], "Head", { CFrame = CFrame.new(0, 0, 0.0000002, 0.9935578, 0.0183216, -0.1118349, 0.0164854, 0.9529805, 0.3025825, 0.1121203, -0.3024769, 0.9465393), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, -0.0000002, 0, 0.0000002, 0.8660253, -0.5, 0.0000001, 0.4999999, 0.8660254), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(0.0000004, -0.0000001, 0.0000056, 0.6475176, -0.4181512, 0.6370795, 0.2741511, 0.9078563, 0.3172346, -0.7110283, -0.030759, 0.7024894), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000031, 0.0000006, -0.5164648, -0.8551936, -0.0436811, 0.202456, -0.1715128, 0.9641552, -0.832031, 0.4891087, 0.2617191), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[22], "Head", { CFrame = CFrame.new(0.0045307, 0.0010883, -0.0050853, 0.9963679, 0.0846243, -0.0094692, -0.0732596, 0.9085767, 0.4112436, 0.0434047, -0.4090562, 0.9114763), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8660253, -0.4999999, 0, 0.4330127, 0.7499998, -0.5, 0.2499999, 0.4330126, 0.8660254), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.0000005, -0.0000001, 0.0000055, 0.7873887, -0.3482519, 0.5086643, -0.0577018, 0.7798835, 0.6232592, -0.6137498, -0.520098, 0.5939763), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[30] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.1046343, 0.0505707, -0.0209632, -0.2639012, -0.7313116, 0.6289192, 0.9322593, -0.0260894, 0.3608489, -0.247485, 0.6815441, 0.6886572), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[31] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.0000572, -0.0001435, -0.0013345, 0.939642, 0.3235308, 0.1113578, -0.3419755, 0.87735, 0.3366153, 0.0112056, -0.3543795, 0.9350345), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[32] = new("Keyframe", I[1], "KF0.64999997615814", { Time = 0.65 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396927, -0.3420199, 0, 0.3420199, 0.9396927), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[35] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(0.0000004, 0.0000003, 0.0000049, 0.8607599, 0.5070534, -0.0445987, -0.4554194, 0.8063061, 0.3774435, 0.2273441, -0.3045771, 0.9249576), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[36] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(-0.0000003, 0.0000029, 0.0000007, 0.8607451, -0.5070776, 0.0446091, 0.4554453, 0.8063037, 0.3774179, -0.2273487, -0.3045436, 0.9249679), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[34], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 1, 0, 0, 0, 0.9396926, 0.3420201, 0, -0.3420201, 0.9396926), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
