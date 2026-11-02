-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig/Anim pitchfork.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Anim pitchfork", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1719519067" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(-0.0000305, -0.0000229, -0.4599915, 1.0000019, 0, 0.0000001, 0, 0.7193412, -0.6946591, 0.0000001, 0.6946591, 0.7193398) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0, 0.0000305, -0.0000305, 0.9563067, -0.2923721, 0.0000001, 0.2923722, 0.9563058, -0.000001, 0.0000001, -0.000001, 1.000001) })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0, -0.0800018, 0, 1.000001, -0.0000001, -0.0000001, -0.0000001, 1.0000007, -0.0000004, -0.0000001, -0.0000004, 1.0000005) })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(-0.0000305, -0.0000229, -0.0000305, 0.9510584, -0.3090173, 0.0000001, 0.198633, 0.6113298, -0.7660446, 0.2367208, 0.7285504, 0.6427889) })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(-0.0000305, 0.0000305, -0.0000305, 0.7547138, 0.6560568, -0.0000001, -0.6560568, 0.7547127, -0.000001, 0.0000002, -0.000001, 1.0000012) })
								I[11] = new("Pose", I[10], "RightHand", { CFrame = CFrame.new(0.0000153, 0.0000305, 0, 0.5877866, 0.8090175, 0.0000005, -0.8090164, 0.5877871, -0.000001, 0.0000009, 0, 1.0000008) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[13] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[14] = new("Pose", I[13], "LowerTorso", { Weight = 0 })
					I[15] = new("Pose", I[14], "UpperTorso", { CFrame = CFrame.new(-0.0000458, -0.0000381, 0.0000305, 0.7743232, -0.3592877, -0.520901, 0.5007018, 0.8512338, 0.1571646, 0.3869405, -0.3825116, 0.8390245) })
						I[16] = new("Pose", I[15], "LeftUpperArm", { CFrame = CFrame.new(0, -0.2878036, -0.737793, 0.9916345, 0.0749596, 0.1050883, 0.0257365, 0.6829572, -0.7300058, -0.1264922, 0.726603, 0.6753135) })
							I[17] = new("Pose", I[16], "LeftLowerArm", { CFrame = CFrame.new(0, 0.0000305, -0.0000305, 0.9563067, -0.2923721, 0.0000001, 0.2923722, 0.9563058, -0.000001, 0.0000001, -0.000001, 1.000001) })
								I[18] = new("Pose", I[17], "LeftHand", { CFrame = CFrame.new(0, -0.0800018, 0, 1.000001, -0.0000001, -0.0000001, -0.0000001, 1.0000007, -0.0000004, -0.0000001, -0.0000004, 1.0000005) })
						I[19] = new("Pose", I[15], "RightUpperArm", { CFrame = CFrame.new(0.0419312, -0.2596207, -0.5352173, 0.969532, -0.225084, 0.0966768, 0.2107856, 0.5654491, -0.7973945, 0.1248144, 0.7934772, 0.5956643) })
							I[20] = new("Pose", I[19], "RightLowerArm", { CFrame = CFrame.new(-0.0000305, 0.0000305, -0.0000305, 0.7547138, 0.6560568, -0.0000001, -0.6560568, 0.7547127, -0.000001, 0.0000002, -0.000001, 1.0000012) })
								I[21] = new("Pose", I[20], "RightHand", { CFrame = CFrame.new(0.0000153, 0.0000305, 0, 0.5877866, 0.8090175, 0.0000005, -0.8090164, 0.5877871, -0.000001, 0.0000009, 0, 1.0000008) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("Pose", I[23], "LowerTorso", { Weight = 0 })
					I[25] = new("Pose", I[24], "UpperTorso", { CFrame = CFrame.new(-0.0000458, -0.0000458, 0.0000305, 0.745446, -0.3317297, -0.5781588, 0.5007011, 0.8512342, 0.1571645, 0.4400117, -0.4066417, 0.8006451) })
						I[26] = new("Pose", I[25], "LeftUpperArm", { CFrame = CFrame.new(-0.2383728, -0.1098175, -0.4607697, 0.9570962, 0.2615715, 0.1247018, -0.0897779, 0.6768304, -0.7306462, -0.275519, 0.6881019, 0.6712723) })
						I[27] = new("Pose", I[25], "RightUpperArm", { CFrame = CFrame.new(-0.1994019, -0.314827, -0.5698242, 0.994668, -0.0359538, 0.0966761, 0.0990199, 0.5952851, -0.7973921, -0.0288819, 0.802712, 0.5956685) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "LowerTorso", { Weight = 0 })
					I[31] = new("Pose", I[30], "UpperTorso", { Weight = 0 })
						I[32] = new("Pose", I[31], "LeftUpperArm", { CFrame = CFrame.new(-0.083374, -0.3285751, -0.7787323, 0.9929765, 0.0577336, 0.1032776, 0.0362548, 0.6824242, -0.7300577, -0.1126285, 0.7286738, 0.6755368) })
						I[33] = new("Pose", I[31], "RightUpperArm", { CFrame = CFrame.new(-0.0448914, -0.279541, -0.5476379, 0.9654562, -0.2419707, 0.0966763, 0.2206224, 0.5616886, -0.7973917, 0.1386427, 0.7911751, 0.5956686) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.85 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "LowerTorso", { Weight = 0 })
					I[37] = new("Pose", I[36], "UpperTorso")
						I[38] = new("Pose", I[37], "LeftUpperArm", { CFrame = CFrame.new(-0.0000305, -0.0000229, -0.4599915, 1.0000019, 0, 0.0000001, 0, 0.7193412, -0.6946591, 0.0000001, 0.6946591, 0.7193398) })
							I[39] = new("Pose", I[38], "LeftLowerArm", { CFrame = CFrame.new(0, 0.0000305, -0.0000305, 0.9563067, -0.2923721, 0.0000001, 0.2923722, 0.9563058, -0.000001, 0.0000001, -0.000001, 1.000001) })
								I[40] = new("Pose", I[39], "LeftHand", { CFrame = CFrame.new(0, -0.0800018, 0, 1.000001, -0.0000001, -0.0000001, -0.0000001, 1.0000007, -0.0000004, -0.0000001, -0.0000004, 1.0000005) })
						I[41] = new("Pose", I[37], "RightUpperArm", { CFrame = CFrame.new(-0.0000305, -0.0000229, -0.0000305, 0.9510584, -0.3090173, 0.0000001, 0.198633, 0.6113298, -0.7660446, 0.2367208, 0.7285504, 0.6427889) })
							I[42] = new("Pose", I[41], "RightLowerArm", { CFrame = CFrame.new(-0.0000305, 0.0000305, -0.0000305, 0.7547138, 0.6560568, -0.0000001, -0.6560568, 0.7547127, -0.000001, 0.0000002, -0.000001, 1.0000012) })
								I[43] = new("Pose", I[42], "RightHand", { CFrame = CFrame.new(0.0000153, 0.0000305, 0, 0.5877866, 0.8090175, 0.0000005, -0.8090164, 0.5877871, -0.000001, 0.0000009, 0, 1.0000008) })
		I[44] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
