-- Generated from animations/Workspace/Rake Player Animations/player fall/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848076, -0.1736488, 0, 0.1736488, 0.9848076), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.1667171, 0.7895017, 0, 0.9396923, 0.342021, 0, -0.342021, 0.9396923, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.1667226, 0.5895026, 0, 0.9848075, -0.1736489, 0, 0.1736489, 0.9848075, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0000015, -0.0000051, 0.000001, 0.874751, 0.4773662, -0.0832595, -0.1595541, 0.445983, 0.8807052, 0.4575512, -0.7571134, 0.4662898), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.0000028, -0.0000125, 0.0000063, 0.9852659, 0.1468024, -0.0877505, -0.002603, 0.525884, 0.8505523, 0.1710097, -0.8377917, 0.5185177), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000011, 1, 0, 0, 0, 0.9396924, 0.3420205, 0, -0.3420205, 0.9396924), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0.0000063, 0, -0.0000063, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.3035247, 0.8136301, 0, 1, 0.0000011, 0, -0.0000011, 1, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0.3035345, 0.4136632, 0, 0.9848086, 0.1736431, 0, -0.1736431, 0.9848086, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0000022, -0.0000209, 0.000006, 0.9407992, -0.1918365, 0.2794559, -0.1659175, 0.4582994, 0.8731741, -0.2955811, -0.8678482, 0.3993387), EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(-0.0000019, -0.0000066, -0.0000033, 0.8660252, -0.4330131, 0.25, 0.0000001, 0.4999999, 0.8660254, -0.5000003, -0.7499999, 0.4330125), EasingDirection = Enum.PoseEasingDirection.Out })
					I[17] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0.0000017, -0.0000176, 1, 0, 0, 0, 0.9396938, 0.3420168, 0, -0.3420168, 0.9396938), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9848076, -0.1736488, 0, 0.1736488, 0.9848076), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.1667171, 0.7895017, 0, 0.9396923, 0.342021, 0, -0.342021, 0.9396923, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(0.1667226, 0.5895026, 0, 0.9848075, -0.1736489, 0, 0.1736489, 0.9848075, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.0000015, -0.0000051, 0.000001, 0.874751, 0.4773662, -0.0832595, -0.1595541, 0.445983, 0.8807052, 0.4575512, -0.7571134, 0.4662898), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.0000028, -0.0000125, 0.0000063, 0.9852659, 0.1468024, -0.0877505, -0.002603, 0.525884, 0.8505523, 0.1710097, -0.8377917, 0.5185177), EasingDirection = Enum.PoseEasingDirection.Out })
					I[25] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0.0000011, 1, 0, 0, 0, 0.9396924, 0.3420205, 0, -0.3420205, 0.9396924), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
