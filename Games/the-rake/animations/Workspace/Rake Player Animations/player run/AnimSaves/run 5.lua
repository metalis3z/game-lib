-- Generated from animations/Workspace/Rake Player Animations/player run/AnimSaves/run 5.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "run 5", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999619, 0, -0.0087265, -0.003222, 0.9293429, -0.3692039, 0.0081099, 0.3692179, 0.9293075), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.1831811, -0.0802851, 0, 0.4383715, -0.8987939, 0, 0.8987939, 0.4383715, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.5727218, -0.0540392, 0, 0.2419221, -0.9702957, 0, 0.9702957, 0.2419221, 0, 0, -0.0000001, 1) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.4402065, 0.0252483, 0.0032434, 0.7992592, -0.5379815, 0.2678816, 0.5119555, 0.8429419, 0.1653792, -0.3147797, 0.0049626, 0.9491518), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.5069816, -0.1603369, -0.0008476, -0.7725936, -0.6346021, 0.0194748, 0.5526965, -0.6571496, 0.5125241, -0.3124511, 0.4067366, 0.8584519), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.000001, 1, 0, 0, 0, 0.9975641, 0.0697562, 0, -0.0697562, 0.9975641), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.125 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, -0.0000014, -0.2000001, 1, 0, 0, 0, 0.9293429, -0.3692178, 0, 0.3692178, 0.9293429), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-1.2445674, 0.6537061, -0.0000024, 0.7660444, -0.6427876, 0, 0.6427876, 0.7660444, 0, 0, 0, 1) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999619, 0, 0.0087265, 0.003222, 0.9293429, -0.3692039, -0.0081099, 0.3692179, 0.9293075), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[16], "Left Leg", { CFrame = CFrame.new(-0.5281551, -0.0429286, 0, 0.2419217, 0.9702958, 0, -0.9702958, 0.2419217, 0, 0, 0, 1) })
					I[18] = new("Pose", I[16], "Right Leg", { CFrame = CFrame.new(-0.1831765, -0.0802815, 0, 0.4383715, 0.8987939, 0, -0.8987939, 0.4383715, 0, 0, 0, 1) })
					I[19] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.5302643, -0.2308399, 0.000384, -0.7725937, 0.6346021, -0.019475, -0.5526967, -0.6571496, 0.5125239, 0.3124507, 0.4067366, 0.8584521), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[20] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(-0.4402003, 0.0252688, 0.0032319, 0.7992595, 0.5379813, -0.2678813, -0.5119554, 0.8429422, 0.1653788, 0.3147791, 0.0049627, 0.949152), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[21] = new("Pose", I[16], "Head", { CFrame = CFrame.new(0, -0.0000016, 0.0000034, 1, 0, 0, 0, 0.9902681, 0.1391726, 0, -0.1391726, 0.9902681), EasingDirection = Enum.PoseEasingDirection.Out })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[24] = new("Pose", I[23], "Torso", { CFrame = CFrame.new(0, -0.0000014, -0.2000001, 1, 0, 0, 0, 0.9293429, -0.3692178, 0, 0.3692178, 0.9293429), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[24], "Right Leg", { CFrame = CFrame.new(1.1054657, 0.4879254, -0.0000024, 0.7660445, 0.6427876, 0, -0.6427876, 0.7660445, 0, 0, 0, 1) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9999619, 0, -0.0087265, -0.003222, 0.9293429, -0.3692039, 0.0081099, 0.3692179, 0.9293075), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(0.1831811, -0.0802851, 0, 0.4383715, -0.8987939, 0, 0.8987939, 0.4383715, 0, 0, 0, 1) })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(0.5727218, -0.0540392, 0, 0.2419221, -0.9702957, 0, 0.9702957, 0.2419221, 0, 0, -0.0000001, 1) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.4402065, 0.0252483, 0.0032434, 0.7992592, -0.5379815, 0.2678816, 0.5119555, 0.8429419, 0.1653792, -0.3147797, 0.0049626, 0.9491518), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.5069816, -0.1603369, -0.0008476, -0.7725936, -0.6346021, 0.0194748, 0.5526965, -0.6571496, 0.5125241, -0.3124511, 0.4067366, 0.8584519), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.000001, 1, 0, 0, 0, 0.9975641, 0.0697562, 0, -0.0697562, 0.9975641), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
