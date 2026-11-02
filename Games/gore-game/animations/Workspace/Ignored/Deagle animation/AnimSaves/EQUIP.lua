-- Generated from animations/Workspace/Ignored/Deagle animation/AnimSaves/EQUIP.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "EQUIP", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0.0000013, 0.0000001, 0.9076804, 0.3619141, 0.2124487, -0.3303771, 0.9284048, -0.1700457, -0.2587803, 0.0841589, 0.962263) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.2073669, -0.9428148, -0.2431202, 0.9810101, 0.1861934, -0.0543258, 0.085949, -0.1662291, 0.9823343, 0.1738736, -0.968349, -0.1790756) })
							I[7] = new("Pose", I[6], "Mag")
							I[8] = new("Pose", I[6], "Slide")
					I[9] = new("Pose", I[4], "Left Arm")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.3889397, -0.3034466, -0.0815198, 0.4667583, -0.7778746, 0.4207706, 0.7316636, 0.6069125, 0.3103635, -0.4967948, 0.1629978, 0.852424) })
					I[14] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.6973425, -0.5245439, -0.8551106, 0.2814137, 0.6745133, -0.6825234, -0.9095483, -0.0391872, -0.4137465, -0.3058236, 0.737222, 0.6024747) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { Weight = 0 })
					I[18] = new("Pose", I[17], "Right Arm", { CFrame = CFrame.new(0.20851, -0.4479207, -0.0526269, -0.2455995, -0.9110104, 0.3312726, 0.7390157, 0.0451915, 0.6721709, -0.6273254, 0.4099002, 0.6621516) })
						I[19] = new("Pose", I[18], "Handle", { CFrame = CFrame.new(-0.0504608, -0.9290409, -0.2153473, 0.9810101, 0.1861934, -0.0543258, 0.085949, -0.1662291, 0.9823343, 0.1738736, -0.968349, -0.1790756) })
					I[20] = new("Pose", I[17], "Left Arm", { CFrame = CFrame.new(-0.456395, -0.7322829, -0.7016035, -0.1323199, 0.4964331, -0.8579313, -0.7852618, -0.5806774, -0.2148911, -0.6048601, 0.6452662, 0.4666647) })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { Weight = 0 })
				I[23] = new("Pose", I[22], "Torso", { Weight = 0 })
					I[24] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(0.3409232, -0.8962651, 0.1852303, -0.542439, -0.7720549, 0.3311965, 0.709885, -0.2104194, 0.672151, -0.4492473, 0.5997124, 0.6622099) })
						I[25] = new("Pose", I[24], "Handle", { CFrame = CFrame.new(-0.2073631, -0.9428482, -0.2430782, 0.9810079, 0.1484551, -0.1248387, 0.0860134, 0.2439194, 0.9659737, 0.1738542, -0.9583655, 0.2265177) })
							I[26] = new("Pose", I[25], "Slide")
					I[27] = new("Pose", I[23], "Left Arm", { CFrame = CFrame.new(-0.4425099, -1.0442271, -0.5155837, -0.6044319, 0.2784442, -0.746412, -0.7150924, -0.6026065, 0.3542713, -0.3511479, 0.7478864, 0.563348) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(0.3295012, -0.992292, 0.2884204, -0.7180228, -0.6637561, 0.2094545, 0.5728617, -0.3926592, 0.719478, -0.3953137, 0.6365899, 0.6621785) })
						I[32] = new("Pose", I[31], "Handle", { CFrame = CFrame.new(-0.1288681, -0.9359722, -0.2292023, 0.9810101, 0.1861934, -0.0543258, 0.085949, -0.1662291, 0.9823343, 0.1738736, -0.968349, -0.1790756) })
							I[33] = new("Pose", I[32], "Slide", { CFrame = CFrame.new(0, 0, 0.5) })
					I[34] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.4496104, -1.0881724, -0.4260376, -0.7194314, -0.070967, -0.6909285, -0.5992687, -0.4394788, 0.6691303, -0.3511346, 0.8954452, 0.2736465) })
		I[35] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[36] = new("Pose", I[35], "HumanoidRootPart", { Weight = 0 })
				I[37] = new("Pose", I[36], "Torso", { Weight = 0 })
					I[38] = new("Pose", I[37], "Right Arm", { CFrame = CFrame.new(0.1893341, -0.6124487, -0.0008175, -0.2649951, -0.8965597, 0.354906, 0.8441407, -0.0378045, 0.5347872, -0.4660516, 0.4413066, 0.7668405) })
						I[39] = new("Pose", I[38], "Handle", { CFrame = CFrame.new(-0.2073669, -0.9428148, -0.2431202, 0.9810101, 0.1861934, -0.0543258, 0.085949, -0.1662291, 0.9823343, 0.1738736, -0.968349, -0.1790756) })
							I[40] = new("Pose", I[39], "Slide", { CFrame = CFrame.new(0, 0, 0.1) })
					I[41] = new("Pose", I[37], "Left Arm", { CFrame = CFrame.new(-0.5037568, -1.2103817, -0.5305158, -0.8127899, -0.0897685, -0.5755988, -0.5216693, -0.3276254, 0.7877326, -0.2592944, 0.9405334, 0.2194613) })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { Weight = 0 })
					I[45] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0.1845511, -0.4474198, -0.1136976, -0.0239636, -0.9345923, 0.3549128, 0.8251732, 0.1819264, 0.5347822, -0.5643713, 0.3056798, 0.7668408) })
						I[46] = new("Pose", I[45], "Handle", { CFrame = CFrame.new(-0.2073669, -0.9428148, -0.2431202, 0.9810101, 0.1861934, -0.0543258, 0.085949, -0.1662291, 0.9823343, 0.1738736, -0.968349, -0.1790756) })
							I[47] = new("Pose", I[46], "Slide")
		I[48] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[49] = new("Pose", I[48], "HumanoidRootPart", { Weight = 0 })
				I[50] = new("Pose", I[49], "Torso", { Weight = 0 })
					I[51] = new("Pose", I[50], "Right Arm", { CFrame = CFrame.new(0.4796317, -0.4015179, -0.437336, -0.1858636, -0.9810687, 0.0543975, 0.9672307, -0.1729344, 0.1858989, -0.1729724, 0.0871667, 0.9810619) })
						I[52] = new("Pose", I[51], "Handle", { CFrame = CFrame.new(-0.2073669, -0.9428148, -0.2431202, 0.9810101, 0.1861934, -0.0543258, 0.085949, -0.1662291, 0.9823343, 0.1738736, -0.968349, -0.1790756) })
							I[53] = new("Pose", I[52], "Mag")
							I[54] = new("Pose", I[52], "Slide")
					I[55] = new("Pose", I[50], "Left Arm", { CFrame = CFrame.new(-0.4561421, -0.5233755, -0.9345948, -0.2469556, 0.6487355, -0.7198299, -0.9571278, -0.0472459, 0.285787, 0.1513912, 0.7595459, 0.6325905) })
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[57] = new("Pose", I[56], "HumanoidRootPart", { Weight = 0 })
				I[58] = new("Pose", I[57], "Torso", { Weight = 0 })
					I[59] = new("Pose", I[58], "Left Arm", { CFrame = CFrame.new(-0.4617004, -1.101261, -0.3076606, -0.7259037, -0.0482738, -0.6861002, -0.6769843, -0.1260314, 0.7251264, -0.1214747, 0.990851, 0.0588061) })
	return I[1]
end

return build
