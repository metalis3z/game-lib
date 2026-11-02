-- Generated from animations/ServerStorage/TrickySignAnims/AnimSaves/Tricky-Sign-Equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Tricky-Sign-Equip", { Loop = false }, nil, { "1619254238" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000009, 0.0000017, 0.0000021, -0.8541177, -0.5125306, -0.0882917, 0.5200798, -0.8417197, -0.1449999, 0, -0.1697657, 0.9854848) })
						I[6] = new("Pose", I[5], "ArmAttach", { Weight = 0 })
							I[7] = new("Pose", I[6], "Base", { CFrame = CFrame.new(2.3728716, -1.497759, 1.1631552, 0.4510436, 0.8924913, 0.0043244, 0.0072999, 0.0011558, -0.9999727, -0.8924718, 0.4510627, -0.0059938) })
					I[8] = new("Pose", I[4], "Left Arm")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(-0.0000009, 0.0000017, 0.0000021, -0.8541177, -0.5125306, -0.0882917, 0.5200798, -0.8417197, -0.1449999, 0, -0.1697657, 0.9854848), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[13] = new("Pose", I[12], "ArmAttach", { Weight = 0 })
							I[14] = new("Pose", I[13], "Base", { CFrame = CFrame.new(2.3728716, -1.497759, 1.1631552, 0.4510436, 0.8924913, 0.0043244, 0.0072999, 0.0011558, -0.9999727, -0.8924718, 0.4510627, -0.0059938), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[15] = new("Pose", I[11], "Left Arm", { EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[19] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0.1213754, -0.4926789, 0.0153329, -0.0160417, -0.8168226, 0.5766658, 0.6851259, 0.4110842, 0.6013421, -0.7282481, 0.4047353, 0.5530318) })
						I[20] = new("Pose", I[19], "ArmAttach", { Weight = 0 })
							I[21] = new("Pose", I[20], "Base", { CFrame = CFrame.new(-0.0002289, -0.1515241, 0.119567, 1.0000002, -0.0000001, -0.0000003, 0, 0.9955464, -0.0942747, 0.0000002, 0.0942747, 0.9955461) })
					I[22] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.1511318, -0.1121649, 0.0943285, -0.1794908, 0.7042186, -0.68692, -0.4951327, -0.6680406, -0.5554865, -0.8500744, 0.2404119, 0.4685888) })
	return I[1]
end

return build
