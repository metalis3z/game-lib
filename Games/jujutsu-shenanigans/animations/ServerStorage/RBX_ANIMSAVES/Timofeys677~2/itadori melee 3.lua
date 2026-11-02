-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677~2/itadori melee 3.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "itadori melee 3", { Loop = false }, nil, { "1735483825" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0.2901267, 0.0146766, 0.107392, 0.3673941, 0.9249543, -0.0973693, -0.929868, 0.3674545, -0.0179651, 0.0191618, 0.097141, 0.9950862) })
					I[5] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.1427036, -0.7225572, -0.0283629, -0.4894674, 0.7892848, 0.3707439, -0.8652975, -0.4923064, -0.0943108, 0.1080815, -0.3669659, 0.9239342) })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1697659, -0.1959001, 0.4608236, -0.2796818, -0.9572001, -0.0744699, 0.3354186, -0.1700931, 0.9265864, -0.8995956, 0.234171, 0.3686348) })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 0.5735765, -0.816035, 0.0713938, 0.8191521, 0.5713938, -0.0499905, 0, 0.0871557, 0.9961947) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { CFrame = CFrame.new(-0.2098732, 0.0146724, 0.1073907, 0.3673941, 0.7018295, -0.6102923, -0.929868, 0.2906967, -0.2254794, 0.0191618, 0.6503312, 0.7594091) })
					I[11] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(-0.9655266, -0.1011661, -0.2868869, 0.1773255, 0.9728045, -0.1490195, -0.956847, 0.2058381, 0.2051205, 0.2302161, 0.1062158, 0.9673256) })
					I[12] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(-0.6799272, -0.8211663, 0.1492786, 0.0645668, -0.7724492, -0.6317857, 0.3733657, -0.5684245, 0.7331381, -0.9254345, -0.2832234, 0.2517049) })
					I[13] = new("Pose", I[10], "Head", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0, 0.4896645, -0.8677148, 0.0854388, 0.7635307, 0.4740501, 0.4385172, -0.4210101, -0.1494911, 0.8946524) })
			I[14] = new("KeyframeMarker", I[8], "swing")
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { CFrame = CFrame.new(-0.2098732, 0.0146724, 0.1073906, 0.7606012, 0.4700352, -0.4478309, -0.6492023, 0.5456433, -0.5299149, -0.0047227, 0.6937869, 0.7201648) })
					I[18] = new("Pose", I[17], "Left Arm", { CFrame = CFrame.new(-0.3522306, 0.476007, 0.2477687, -0.267596, 0.749303, 0.6057534, -0.5249534, -0.6405585, 0.5604538, 0.8079704, -0.1680171, 0.5647602) })
					I[19] = new("Pose", I[17], "Right Arm", { CFrame = CFrame.new(-1.4464469, -1.4023309, -0.4628426, 0.0645668, -0.7144461, -0.6967049, 0.3733657, -0.6301587, 0.6808069, -0.9254345, -0.3040831, 0.2260625) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7071068, 0, 0.7071068, 0.3535534, 0.8660254, -0.3535534, -0.6123724, 0.5, 0.6123724) })
					I[23] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(0.2913108, -0.1947083, -0.6631922, 0.0214133, -0.273048, 0.961762, -0.9511595, -0.3018802, -0.0645278, 0.3079561, -0.9134074, -0.2661765) })
					I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(2.1023698, 0.6411303, 0.3390431, -0.2434206, -0.6747952, -0.6967049, 0.0720676, -0.7289089, 0.6808069, -0.9672395, 0.1155126, 0.2260625) })
					I[25] = new("Pose", I[22], "Head", { CFrame = CFrame.new(0, 0, 0, 0.902859, -0.4210101, 0.0871557, 0.4226183, 0.9063078, 0, -0.0789899, 0.0368336, 0.9961947) })
			I[26] = new("KeyframeMarker", I[20], "hit")
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 })
				I[29] = new("Pose", I[28], "Torso", { CFrame = CFrame.new(0.300002, 0.0000005, 0.0000002, 0.5, -0.711691, 0.4934529, 0.8623724, 0.461441, -0.2082928, -0.0794593, 0.5296866, 0.8444632) })
					I[30] = new("Pose", I[29], "Left Arm", { CFrame = CFrame.new(0.6637534, -0.3190445, -0.2483622, 0.4289944, 0.6963863, 0.5753345, -0.6476966, -0.2068228, 0.7332894, 0.6296451, -0.6872193, 0.3623213) })
					I[31] = new("Pose", I[29], "Right Arm", { CFrame = CFrame.new(0.4284022, -0.3131637, 0.4169143, 0.5864398, -0.8098444, -0.0154925, 0.0723798, 0.0333437, 0.9968196, -0.8067523, -0.5856959, 0.0781706) })
					I[32] = new("Pose", I[29], "Head", { CFrame = CFrame.new(0, 0, 0, 0.8745896, 0.4447309, 0.1931514, -0.3989615, 0.8864574, -0.2345697, -0.2755409, 0.1280923, 0.9527169) })
		I[33] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[34] = new("Pose", I[33], "HumanoidRootPart", { Weight = 0 })
				I[35] = new("Pose", I[34], "Torso", { CFrame = CFrame.new(0.0401269, 0.0146745, 0.1073913, 0.3192561, 0.919827, -0.2280218, -0.9069772, 0.3663212, 0.207849, 0.2747144, 0.1404536, 0.9512122) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { CFrame = CFrame.new(0.1000007, 0.0000002, 0, 0.5534475, -0.4335543, 0.7111446, 0.7596146, 0.6129296, -0.2174923, -0.3415869, 0.6605663, 0.6685585) })
					I[39] = new("Pose", I[38], "Right Arm", { CFrame = CFrame.new(0.9078016, -0.0913382, 0.5468299, 0.4614603, -0.7619187, -0.4544606, 0.3892371, -0.2864453, 0.8754676, -0.7972133, -0.5808865, 0.1643839) })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "Torso", { CFrame = CFrame.new(0.2000016, 0.0000003, 0, 0.4867114, -0.6256282, 0.6096732, 0.8595425, 0.4675163, -0.2064347, -0.1558808, 0.6245142, 0.7652994) })
					I[43] = new("Pose", I[42], "Right Arm", { CFrame = CFrame.new(0.6681023, -0.202251, 0.4818726, 0.6242571, -0.7068151, -0.3327392, 0.418053, -0.0575649, 0.906597, -0.6599505, -0.7050523, 0.2595509) })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[45] = new("KeyframeMarker", I[44], "")
	return I[1]
end

return build
