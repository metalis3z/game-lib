-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig/Scissors.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Scissors", { Loop = false, Priority = Enum.AnimationPriority.Movement }, nil, { "1719523869" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0, -0.2600021, -0.3599854, 0.8746223, 0.0000002, -0.4848069, -0.1007969, 0.9781487, -0.1818436, 0.4742124, 0.2079111, 0.855509) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0.0210876, -0.2054749, 0.0379944, 0.9214127, -0.2851887, -0.2639466, 0.1283412, 0.8644745, -0.4860187, 0.3667809, 0.4139479, 0.8331382) })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0.1326904, -0.1923523, -0.1982422, 0.9913551, -0.0943861, 0.0911452, 0.1079296, 0.9816209, -0.1573952, -0.0746149, 0.1658715, 0.9833212) })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, -0.2600174, -0.4299927, 0.9905626, -0.0439334, 0.1298368, 0.0631688, 0.9869738, -0.1479676, -0.1216444, 0.1547725, 0.9804326) })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(-0.005722, -0.1083527, 0.0177917, 0.964179, 0.0311616, 0.2634192, 0.0595613, 0.9422838, -0.3294777, -0.258482, 0.3333641, 0.9066728) })
								I[11] = new("Pose", I[10], "RightHand", { CFrame = CFrame.new(-0.0000076, 0.0000305, 0.000061, 0.9571561, -0.1088846, -0.268324, 0.1108463, 0.9938071, -0.0078769, 0.2675202, -0.022204, 0.9632968) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[13] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[14] = new("Pose", I[13], "LowerTorso", { Weight = 0 })
					I[15] = new("Pose", I[14], "UpperTorso", { CFrame = CFrame.new(0, -0.0000153, 0, 0.9819172, -0.1134578, -0.1515516, 0.160304, 0.9241526, 0.3467656, 0.1007134, -0.3647889, 0.9256272) })
						I[16] = new("Pose", I[15], "LeftUpperArm", { CFrame = CFrame.new(-0.0443573, -0.099472, -0.767334, 0.8908589, -0.042557, -0.4522846, 0.0745424, 0.9958023, 0.0531266, 0.4481244, -0.081042, 0.8902903) })
						I[17] = new("Pose", I[15], "RightUpperArm", { CFrame = CFrame.new(-0.0493774, -0.040802, -0.9135437, 0.9826624, -0.0882705, 0.1630491, 0.0644972, 0.9872185, 0.1457435, -0.1738298, -0.1326996, 0.9757941) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "LowerTorso", { Weight = 0 })
					I[21] = new("Pose", I[20], "UpperTorso", { Weight = 0 })
						I[22] = new("Pose", I[21], "LeftUpperArm", { CFrame = CFrame.new(-0.1104889, -0.2062225, -1.1155396, 0.8908604, -0.042557, -0.4522814, 0.0745419, 0.9958025, 0.0531262, 0.4481213, -0.0810412, 0.890292) })
						I[23] = new("Pose", I[21], "RightUpperArm", { CFrame = CFrame.new(-0.1154785, -0.1475906, -1.2617188, 0.9826635, -0.0882673, 0.163044, 0.0644955, 0.9872193, 0.1457385, -0.1738239, -0.1326955, 0.9757957) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "LowerTorso", { Weight = 0 })
					I[27] = new("Pose", I[26], "UpperTorso", { Weight = 0 })
						I[28] = new("Pose", I[27], "LeftUpperArm", { CFrame = CFrame.new(-0.0312042, -0.0420227, -0.7245483, 0.8908629, -0.042557, -0.4522766, 0.0745411, 0.9958025, 0.0531257, 0.4481166, -0.0810402, 0.8902944) })
						I[29] = new("Pose", I[27], "RightUpperArm", { CFrame = CFrame.new(-0.0362244, 0.0165482, -0.8706665, 0.9826654, -0.0882621, 0.1630358, 0.0644928, 0.9872208, 0.1457306, -0.1738146, -0.1326889, 0.9757983) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { Weight = 0 })
				I[32] = new("Pose", I[31], "LowerTorso", { Weight = 0 })
					I[33] = new("Pose", I[32], "UpperTorso", { Weight = 0 })
						I[34] = new("Pose", I[33], "LeftUpperArm", { CFrame = CFrame.new(-0.0312195, -0.0420074, -0.7245483, 0.8641339, 0.0159868, -0.50301, -0.1839449, 0.9403737, -0.2861167, 0.4684425, 0.3397695, 0.8155481) })
						I[35] = new("Pose", I[33], "RightUpperArm", { CFrame = CFrame.new(-0.0307617, -0.0770798, -0.7650452, 0.9935812, -0.0268266, 0.1099044, 0.0571801, 0.9573391, -0.2832547, -0.0976169, 0.2877212, 0.9527265) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.7833334 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "LowerTorso", { Weight = 0 })
					I[39] = new("Pose", I[38], "UpperTorso")
						I[40] = new("Pose", I[39], "LeftUpperArm", { CFrame = CFrame.new(0, -0.2600021, -0.3599854, 0.8746223, 0.0000002, -0.4848069, -0.1007969, 0.9781487, -0.1818436, 0.4742124, 0.2079111, 0.855509) })
							I[41] = new("Pose", I[40], "LeftLowerArm", { CFrame = CFrame.new(0.0210876, -0.2054749, 0.0379944, 0.9214127, -0.2851887, -0.2639466, 0.1283412, 0.8644745, -0.4860187, 0.3667809, 0.4139479, 0.8331382) })
								I[42] = new("Pose", I[41], "LeftHand", { CFrame = CFrame.new(0.1326904, -0.1923523, -0.1982422, 0.9913551, -0.0943861, 0.0911452, 0.1079296, 0.9816209, -0.1573952, -0.0746149, 0.1658715, 0.9833212) })
						I[43] = new("Pose", I[39], "RightUpperArm", { CFrame = CFrame.new(0, -0.2600174, -0.4299927, 0.9905626, -0.0439334, 0.1298368, 0.0631688, 0.9869738, -0.1479676, -0.1216444, 0.1547725, 0.9804326) })
							I[44] = new("Pose", I[43], "RightLowerArm", { CFrame = CFrame.new(-0.005722, -0.1083527, 0.0177917, 0.964179, 0.0311616, 0.2634192, 0.0595613, 0.9422838, -0.3294777, -0.258482, 0.3333641, 0.9066728) })
								I[45] = new("Pose", I[44], "RightHand", { CFrame = CFrame.new(-0.0000076, 0.0000305, 0.000061, 0.9571561, -0.1088846, -0.268324, 0.1108463, 0.9938071, -0.0078769, 0.2675202, -0.022204, 0.9632968) })
		I[46] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[47] = new("Pose", I[46], "HumanoidRootPart", { Weight = 0 })
				I[48] = new("Pose", I[47], "LowerTorso", { Weight = 0 })
					I[49] = new("Pose", I[48], "UpperTorso", { CFrame = CFrame.new(0, -0.0000153, 0, 0.8290393, 0, -0.559192, 0.1447295, 0.9659268, 0.2145711, 0.5401375, -0.2588192, 0.8007897) })
		I[50] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
