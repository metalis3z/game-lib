-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig/Magic Stick Anim.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Magic Stick Anim", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1719530114" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.3299408, 0.0000076, 0.0000305, 0.9781497, -0.1703104, -0.1192535, 0.0000003, 0.5735813, -0.8191507, 0.2079109, 0.8012496, 0.5610459) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0.1821594, -0.1931458, -0.286438, 0.6889223, -0.4914659, -0.532775, 0.2969547, 0.8618826, -0.4110689, 0.6612149, 0.1249835, 0.7397125) })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0.1313171, -0.1506348, -0.1502151, 1.0000002, -0.0000004, -0.0000002, -0.0000004, 1.0000006, -0.0000002, -0.0000002, -0.0000002, 1.000001) })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(-0.1100006, 0.0000076, 0, 0.9848087, 0.172354, 0.0211624, -0.0000004, 0.1218714, -0.9925468, -0.1736481, 0.9774669, 0.1200199) })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(-0.2159729, -0.072052, 0.2430267, 0.9283997, 0.3457519, 0.1361305, -0.3632528, 0.9216291, 0.136555, -0.0782475, -0.1762276, 0.9812356) })
								I[11] = new("Pose", I[10], "RightHand", { CFrame = CFrame.new(-0.1475372, -0.4214783, -0.0529709, 0.9563587, -0.2794478, -0.0853714, 0.2802868, 0.959914, -0.0022495, 0.082578, -0.0217775, 0.9963477) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[13] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[14] = new("Pose", I[13], "LowerTorso", { Weight = 0 })
					I[15] = new("Pose", I[14], "UpperTorso", { Weight = 0 })
						I[16] = new("Pose", I[15], "LeftUpperArm", { CFrame = CFrame.new(0.3299408, 0.0000153, 0.0000305, 0.9781488, -0.1703099, -0.1192533, -0.1364013, -0.0927787, -0.9863004, 0.1569124, 0.9810133, -0.1139817) })
						I[17] = new("Pose", I[15], "RightUpperArm", { CFrame = CFrame.new(-0.1100006, 0.0000305, 0, 0.9848088, 0.172354, 0.0211623, 0.1139231, -0.5492985, -0.8278252, -0.1310542, 0.8176588, -0.5605883) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "LowerTorso", { Weight = 0 })
					I[21] = new("Pose", I[20], "UpperTorso", { Weight = 0 })
						I[22] = new("Pose", I[21], "LeftUpperArm", { CFrame = CFrame.new(0.2757111, -0.7328796, -0.4934692, 0.9732822, -0.0447582, -0.2252118, -0.1046892, 0.7864451, -0.6087249, 0.2043619, 0.616037, 0.7607461) })
							I[23] = new("Pose", I[22], "LeftLowerArm", { CFrame = CFrame.new(0.2388611, -0.454895, 0.0106583, 0.6904809, -0.4322182, -0.5800221, 0.0195048, 0.8126869, -0.5823747, 0.7230885, 0.3908044, 0.5695751) })
						I[24] = new("Pose", I[21], "RightUpperArm", { CFrame = CFrame.new(-0.2363739, -0.9341583, -0.4276123, 0.9645374, 0.2286113, -0.1319329, -0.2075977, 0.3483537, -0.9140868, -0.1630108, 0.9090582, 0.3834589) })
							I[25] = new("Pose", I[24], "RightLowerArm", { CFrame = CFrame.new(-0.1186752, -0.2454529, 0.653717, 0.8996285, 0.3832018, 0.2093479, -0.3485194, 0.9189738, -0.1844487, -0.2630661, 0.0929732, 0.9602884) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5333334 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "LowerTorso", { Weight = 0 })
					I[29] = new("Pose", I[28], "UpperTorso", { CFrame = CFrame.new(-0.0000305, -0.0000076, 0, 0.402177, 0.0144506, -0.9154484, -0.0006849, 0.9998809, 0.0154825, 0.9155622, -0.0055998, 0.4021387) })
						I[30] = new("Pose", I[29], "LeftUpperArm", { CFrame = CFrame.new(0.5694885, -0.0697479, -0.2180176, 0.8392343, 0.1770624, -0.5141361, -0.5104725, 0.5823248, -0.6327084, 0.1873637, 0.7934419, 0.5790924) })
						I[31] = new("Pose", I[29], "RightUpperArm", { CFrame = CFrame.new(-0.1011963, -0.8857269, -0.2505951, 0.8342627, 0.2378294, -0.4974379, -0.5160456, 0.0190725, -0.8563513, -0.1941793, 0.9711209, 0.1386426) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "LowerTorso", { Weight = 0 })
					I[35] = new("Pose", I[34], "UpperTorso", { CFrame = CFrame.new(0, -0.0000076, -0.0000305, 0.3907294, -0.0117891, 0.9204306, 0, 0.9999189, 0.0128072, -0.9205062, -0.0050042, 0.3906973) })
						I[36] = new("Pose", I[35], "LeftUpperArm", { CFrame = CFrame.new(0.5789795, -1.5496292, -0.6473389, 0.7628716, -0.6356841, 0.1180391, 0.4561037, 0.3997188, -0.795109, 0.4582565, 0.660403, 0.5948717) })
						I[37] = new("Pose", I[35], "RightUpperArm", { CFrame = CFrame.new(-0.1099701, -0.8119049, -0.2341919, 0.8770244, -0.1894735, 0.4415073, 0.4710772, 0.1585242, -0.8677329, 0.0944238, 0.969006, 0.2282865) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.9666666 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("Pose", I[39], "LowerTorso", { Weight = 0 })
					I[41] = new("Pose", I[40], "UpperTorso")
						I[42] = new("Pose", I[41], "LeftUpperArm", { CFrame = CFrame.new(0.3299408, 0.0000076, 0.0000305, 0.9781497, -0.1703104, -0.1192535, 0.0000003, 0.5735813, -0.8191507, 0.2079109, 0.8012496, 0.5610459) })
							I[43] = new("Pose", I[42], "LeftLowerArm", { CFrame = CFrame.new(0.1821594, -0.1931458, -0.286438, 0.6889223, -0.4914659, -0.532775, 0.2969547, 0.8618826, -0.4110689, 0.6612149, 0.1249835, 0.7397125) })
								I[44] = new("Pose", I[43], "LeftHand", { CFrame = CFrame.new(0.1313171, -0.1506348, -0.1502151, 1.0000002, -0.0000004, -0.0000002, -0.0000004, 1.0000006, -0.0000002, -0.0000002, -0.0000002, 1.000001) })
						I[45] = new("Pose", I[41], "RightUpperArm", { CFrame = CFrame.new(-0.1100006, 0.0000076, 0, 0.9848087, 0.172354, 0.0211624, -0.0000004, 0.1218714, -0.9925468, -0.1736481, 0.9774669, 0.1200199) })
							I[46] = new("Pose", I[45], "RightLowerArm", { CFrame = CFrame.new(-0.2159729, -0.072052, 0.2430267, 0.9283997, 0.3457519, 0.1361305, -0.3632528, 0.9216291, 0.136555, -0.0782475, -0.1762276, 0.9812356) })
								I[47] = new("Pose", I[46], "RightHand", { CFrame = CFrame.new(-0.1475372, -0.4214783, -0.0529709, 0.9563587, -0.2794478, -0.0853714, 0.2802868, 0.959914, -0.0022495, 0.082578, -0.0217775, 0.9963477) })
		I[48] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[49] = new("Pose", I[48], "HumanoidRootPart", { Weight = 0 })
				I[50] = new("Pose", I[49], "LowerTorso", { Weight = 0 })
					I[51] = new("Pose", I[50], "UpperTorso", { CFrame = CFrame.new(0, -0.0000076, 0, 1.000001, 0, 0.0000001, 0, 0.9455195, -0.3255683, 0.0000001, 0.3255683, 0.9455186) })
		I[52] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[53] = new("Pose", I[52], "HumanoidRootPart", { Weight = 0 })
				I[54] = new("Pose", I[53], "LowerTorso", { Weight = 0 })
					I[55] = new("Pose", I[54], "UpperTorso", { CFrame = CFrame.new(0, -0.0000076, 0, 1.000001, 0, 0.0000001, 0, 0.9998485, 0.017455, 0.0000001, -0.0174553, 0.9998477) })
		I[56] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
