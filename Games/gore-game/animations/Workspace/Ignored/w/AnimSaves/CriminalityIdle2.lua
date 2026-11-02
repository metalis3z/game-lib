-- Generated from animations/Workspace/Ignored/w/AnimSaves/CriminalityIdle2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "CriminalityIdle2", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso")
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0, -0.0000002, 0) })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0, -0.0000002, 0) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, -0.0000001, 0) })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0, -0.0000001, 0) })
					I[9] = new("Pose", I[4], "Head")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso")
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0, -0.0000075, -0.0000362, 1, 0, 0, 0, 0.9963705, 0.0851225, 0, -0.0851225, 0.9963705) })
					I[14] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.0000001, 0.0000007, 0.0000226, 0.8110725, 0.5849456, 0, -0.5849456, 0.8110725, 0, 0, 0, 1) })
					I[15] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(-0.0000007, -0.0000025, 0.000027, 0.7839507, -0.6208231, 0, 0.6208231, 0.7839507, 0, 0, 0, 1) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso")
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(0, -0.0000002, 0) })
					I[20] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(0, -0.0000001, 0) })
					I[21] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0, -0.0000001, 0) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("Pose", I[23], "Torso")
					I[25] = new("Pose", I[24], "Left Leg", { CFrame = CFrame.new(-0.0000008, -0.0000021, -0.0000054, 0.999349, -0.0360767, 0, 0.0360767, 0.999349, 0, 0, 0, 1) })
					I[26] = new("Pose", I[24], "Right Leg", { CFrame = CFrame.new(0.0000006, -0.0000023, -0.0000054, 0.9975374, -0.0701366, 0, 0.0701366, 0.9975374, 0, 0, 0, 1) })
					I[27] = new("Pose", I[24], "Left Arm", { CFrame = CFrame.new(0.0000001, -0.0000005, 0.0000246, 0.8764316, -0.4815263, 0, 0.4815263, 0.8764316, 0, 0, 0, 1) })
					I[28] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(0.0000004, -0.0000004, 0.0000244, 0.9565495, 0.2915699, 0, -0.2915699, 0.9565495, 0, 0, 0, 1) })
		I[29] = new("Keyframe", I[1], "End", { Time = 2 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 })
				I[31] = new("Pose", I[30], "Torso")
					I[32] = new("Pose", I[31], "Left Leg", { CFrame = CFrame.new(0, -0.0000002, 0) })
					I[33] = new("Pose", I[31], "Right Leg", { CFrame = CFrame.new(0, -0.0000002, 0) })
					I[34] = new("Pose", I[31], "Left Arm", { CFrame = CFrame.new(0, -0.0000001, 0) })
					I[35] = new("Pose", I[31], "Right Arm", { CFrame = CFrame.new(0, -0.0000001, 0) })
	return I[1]
end

return build
