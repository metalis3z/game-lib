-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig/pitchfork Anim.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "pitchfork Anim", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1719519517" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(-0.0000153, -0.0000229, -0.5, 1.0000019, 0, 0.0000001, 0, 0.4067374, -0.9135463, 0.0000001, 0.9135463, 0.4067366) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(-0.0000305, -0.1450195, -0.2511215, 1.000001, 0.0000001, 0, 0, 0.5000014, -0.8660249, 0, 0.8660251, 0.5000022) })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0, -0.1899719, 0, 0.9455205, -0.3255684, -0.0000001, 0.3255687, 0.9455192, 0.0000009, 0, 0.0000008, 1.0000012) })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, 0, -0.5, 1.000001, 0, 0.0000001, 0, 1.000001, 0, 0.0000001, 0, 1) })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(0, 0.000061, -0.0001221, 0.5879891, 0.0343346, 0.808142, 0.706314, 0.4651121, -0.5336616, -0.3941984, 0.884586, 0.249229) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.2166667 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "LowerTorso", { Weight = 0 })
					I[14] = new("Pose", I[13], "UpperTorso", { CFrame = CFrame.new(0.0000153, -0.0000229, 0.0000305, 0.927191, 0.0326476, -0.3731679, 0.0326475, 0.9853631, 0.1673247, 0.3731675, -0.1673246, 0.9125506) })
						I[15] = new("Pose", I[14], "LeftUpperArm", { CFrame = CFrame.new(0.1949463, 0.0242004, -0.7774048, 0.8191552, 0.0000003, -0.5735733, -0.0499766, 0.9961978, -0.0713742, 0.571391, 0.0871318, 0.8160395) })
							I[16] = new("Pose", I[15], "LeftLowerArm", { CFrame = CFrame.new(-0.0000305, -0.2900238, -0.5022583, 1.0000005, -0.0000004, -0.0000002, -0.0000001, 0.5000028, -0.8660251, -0.0000004, 0.8660246, 0.5000026) })
						I[17] = new("Pose", I[14], "RightUpperArm", { CFrame = CFrame.new(-0.0161743, -0.080925, -0.5357971, 0.8762105, -0.4471955, 0.1796465, 0.0378457, 0.4354627, 0.8994119, -0.4804419, -0.7812738, 0.3984808) })
							I[18] = new("Pose", I[17], "RightLowerArm", { CFrame = CFrame.new(-0.0235748, -0.2084656, -0.431366, 0.9765273, 0.0874216, 0.1968618, 0.1571839, 0.3356711, -0.9287729, -0.1472752, 0.937916, 0.3140495) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.95 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "LowerTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "UpperTorso")
						I[23] = new("Pose", I[22], "LeftUpperArm", { CFrame = CFrame.new(-0.0000153, -0.0000229, -0.5, 1.0000019, 0, 0.0000001, 0, 0.4067374, -0.9135463, 0.0000001, 0.9135463, 0.4067366) })
							I[24] = new("Pose", I[23], "LeftLowerArm", { CFrame = CFrame.new(-0.0000305, -0.1450195, -0.2511215, 1.000001, 0.0000001, 0, 0, 0.5000014, -0.8660249, 0, 0.8660251, 0.5000022) })
								I[25] = new("Pose", I[24], "LeftHand", { CFrame = CFrame.new(0, -0.1899719, 0, 0.9455205, -0.3255684, -0.0000001, 0.3255687, 0.9455192, 0.0000009, 0, 0.0000008, 1.0000012) })
						I[26] = new("Pose", I[22], "RightUpperArm", { CFrame = CFrame.new(0, 0, -0.5, 1.000001, 0, 0.0000001, 0, 1.000001, 0, 0.0000001, 0, 1) })
							I[27] = new("Pose", I[26], "RightLowerArm", { CFrame = CFrame.new(0, 0.000061, -0.0001221, 0.5879891, 0.0343346, 0.808142, 0.706314, 0.4651121, -0.5336616, -0.3941984, 0.884586, 0.249229) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "LowerTorso", { Weight = 0 })
					I[31] = new("Pose", I[30], "UpperTorso", { CFrame = CFrame.new(0.0000305, -0.0000305, 0.000061, 0.6874093, 0.0969492, -0.7197725, 0.1715388, 0.9413389, 0.290619, 0.7057233, -0.3232419, 0.630452) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "LowerTorso", { Weight = 0 })
					I[35] = new("Pose", I[34], "UpperTorso", { CFrame = CFrame.new(0.2057495, -0.2027054, -0.2468872, 0.8124883, 0.2157722, -0.5415781, 0.1335801, 0.8353645, 0.5332208, 0.5674683, -0.5055788, 0.6498997) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "LowerTorso", { Weight = 0 })
					I[39] = new("Pose", I[38], "UpperTorso", { CFrame = CFrame.new(-0.0028839, -0.0051422, -0.0080872, 0.9582409, 0.0289839, 0.2844932, -0.176065, 0.8437313, 0.5070705, -0.2253384, -0.5359839, 0.8135993) })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 0.8333333 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "LowerTorso", { Weight = 0 })
					I[43] = new("Pose", I[42], "UpperTorso", { CFrame = CFrame.new(-0.0000458, -0.0000534, 0.0000305, 0.9924666, 0.0969481, -0.07493, -0.0669827, 0.9413406, 0.3307498, 0.1026006, -0.323238, 0.9407395) })
		I[44] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
