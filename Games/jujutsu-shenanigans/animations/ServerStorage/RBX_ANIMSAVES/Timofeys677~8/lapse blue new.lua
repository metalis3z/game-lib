-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677~8/lapse blue new.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "lapse blue new", { Loop = false }, nil, { "1736611313" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0.0751574, 0.0332959, -0.1887066, 0.9296012, -0.3549967, 0.0990906, 0.3555509, 0.9345719, 0.0126079, -0.0970831, 0.0235114, 0.9949985) })
					I[5] = new("Pose", I[4], "Left Leg")
					I[6] = new("Pose", I[4], "Right Leg")
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.3833333 })
			I[8] = new("Pose", I[7], "HumanoidRootPart", { Weight = 0 })
				I[9] = new("Pose", I[8], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.6256114, -0.7790733, -0.0406839, 0.7582234, 0.5949397, 0.2667286, -0.1835967, -0.197716, 0.9629126) })
					I[10] = new("Pose", I[9], "Left Leg", { CFrame = CFrame.new(0.0000001, -0.0000002, 0, 0.8454862, -0.5339974, 0, 0.5339974, 0.8454862, 0, 0, 0, 1) })
					I[11] = new("Pose", I[9], "Right Arm", { CFrame = CFrame.new(-0.3607306, -0.2500037, -0.0141835, 0.0230151, 0.9824371, -0.1851696, -0.307726, 0.1831877, 0.9336739, 0.9511966, 0.0354929, 0.3065376) })
					I[12] = new("Pose", I[9], "Head", { CFrame = CFrame.new(0, 0, 0, 0.6407425, 0.7310077, -0.2346844, -0.7677559, 0.6100738, -0.1958595, 0, 0.3056758, 0.9521356) })
					I[13] = new("Pose", I[9], "Right Leg", { CFrame = CFrame.new(0.3957258, 0.3995716, 0.6337974, 0.0650018, -0.5799285, -0.8120704, 0.8983487, -0.3202906, 0.3006388, -0.4344474, -0.7490642, 0.5001585) })
					I[14] = new("Pose", I[9], "Left Arm", { CFrame = CFrame.new(-0.5080709, -0.2273921, -0.3648684, -0.3461589, 0.9135691, -0.2134609, -0.6165668, -0.0500363, 0.7857109, 0.7071204, 0.4035938, 0.5805969) })
			I[15] = new("KeyframeMarker", I[7], "Function", { Value = "Hitbox2" })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.5210932, -0.8048922, -0.2839197, 0.8164988, 0.3732282, 0.440489, -0.2485794, -0.4613559, 0.8516802) })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.7419869, -0.6704143, 0, 0.6704143, 0.7419869, 0, 0, 0, 1) })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(-0.1411038, 0.4857063, 0.5688277, -0.0466506, -0.864689, -0.5001372, 0.7458106, -0.3632275, 0.5584196, -0.6645228, -0.3469568, 0.6618389) })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { Weight = 0 })
				I[23] = new("Pose", I[22], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.4937653, -0.8529677, -0.1692395, 0.8694406, 0.4879091, 0.0775754, 0.0164042, -0.1854477, 0.9825172) })
					I[24] = new("Pose", I[23], "Left Leg", { CFrame = CFrame.new(0, 0.0000001, 0, 0.9588657, -0.28386, 0, 0.28386, 0.9588657, 0, 0, 0, 1) })
					I[25] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(-0.3607305, -0.2500037, -0.0141835, 0.0230151, 0.9824371, -0.1851696, -0.307726, 0.1831877, 0.9336739, 0.9511966, 0.0354929, 0.3065376) })
					I[26] = new("Pose", I[23], "Head", { CFrame = CFrame.new(0, 0, 0, 0.6407425, 0.7310077, -0.2346844, -0.7677559, 0.6100738, -0.1958595, 0, 0.3056758, 0.9521356) })
					I[27] = new("Pose", I[23], "Right Leg", { CFrame = CFrame.new(-0.2008411, 1.1681659, 0.7626041, 0.5791653, -0.4736123, -0.6635206, 0.6735454, 0.7365248, 0.0621938, 0.4592434, -0.4829315, 0.7455688) })
					I[28] = new("Pose", I[23], "Left Arm", { CFrame = CFrame.new(-0.5080709, -0.2273921, -0.3648684, -0.3461589, 0.9135691, -0.2134609, -0.6165668, -0.0500363, 0.7857109, 0.7071204, 0.4035938, 0.5805969) })
			I[29] = new("KeyframeMarker", I[21], "Function", { Value = "End" })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { Weight = 0 })
				I[32] = new("Pose", I[31], "Torso", { CFrame = CFrame.new(0.0751564, 0.7500952, -0.5834335, -0.0669836, -0.8504437, 0.5217841, 0.9950379, -0.0183763, 0.0977859, -0.0735729, 0.5257449, 0.8474546) })
		I[33] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[34] = new("Pose", I[33], "HumanoidRootPart", { Weight = 0 })
				I[35] = new("Pose", I[34], "Torso", { CFrame = CFrame.new(-0.3154334, 0.7500817, -0.5834415, -0.9909123, -0.1237018, 0.0528264, 0.1287014, -0.757788, 0.6396822, -0.0390987, 0.6406678, 0.766822) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { CFrame = CFrame.new(-0.3154335, 0.7500815, -0.5834416, -0.1589297, 0.9460796, 0.2822673, -0.9012688, -0.2557448, 0.3497272, 0.4030582, -0.1988167, 0.8933174) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[40] = new("Pose", I[39], "HumanoidRootPart", { Weight = 0 })
				I[41] = new("Pose", I[40], "Torso", { CFrame = CFrame.new(-0.3154337, 0.7500815, -0.5834414, 0.5308471, 0.8455423, 0.0570926, -0.8150219, 0.4909009, 0.3078241, 0.2322515, -0.2099392, 0.9497287) })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { Weight = 0 })
					I[45] = new("Pose", I[44], "Right Leg", { CFrame = CFrame.new(0.8445736, 0.5242423, 0.3528822, 0.8941402, 0.4477877, -0.0000001, -0.4477876, 0.89414, 0, -0.0000001, 0, 1.0000001) })
		I[46] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[47] = new("Pose", I[46], "HumanoidRootPart", { Weight = 0 })
				I[48] = new("Pose", I[47], "Torso", { Weight = 0 })
					I[49] = new("Pose", I[48], "Right Leg", { CFrame = CFrame.new(1.0581369, 0.9506841, -0.0758936, 0.8941402, 0.3329978, 0.2993765, -0.4477876, 0.6649282, 0.5977933, -0.0000001, -0.668568, 0.7436512) })
	return I[1]
end

return build
