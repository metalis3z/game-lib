-- Generated from animations/Workspace/StudioAssets/Subject_0/AnimSaves/Test.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Test", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart")
				I[4] = new("Pose", I[3], "Torso")
					I[5] = new("Pose", I[4], "Left Leg")
					I[6] = new("Pose", I[4], "Right Leg")
					I[7] = new("Pose", I[4], "Left Arm")
					I[8] = new("Pose", I[4], "Right Arm")
					I[9] = new("Pose", I[4], "Head")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[11] = new("Pose", I[10], "HumanoidRootPart")
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0.3965192, 0.992043, -0.1212485, -0.0339035, 0.1211778, 0.9926222, -0.0041382, 0.0341551, -0.000003, 0.9994165) })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.967357, -0.2530844, -0.012987, 0.2534174, 0.9660904, 0.0494871, 0.0000222, -0.0511628, 0.9986903) })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9559327, -0.2931918, 0.0152036, 0.2935857, 0.9546477, -0.0495502, 0.0000136, 0.0518302, 0.9986559) })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0, 0, 0, -0.383742, 0.9234404, 0, -0.9234404, -0.383742, 0, 0, 0, 1) })
					I[16] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.3327015, -0.9430323, 0, 0.9430323, 0.3327015, 0, 0, 0, 1) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[18] = new("Pose", I[17], "HumanoidRootPart")
				I[19] = new("Pose", I[18], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9909579, 0.1333319, 0.015003, -0.1333162, 0.9910715, -0.0020428, -0.0151414, 0.0000242, 0.9998854) })
					I[20] = new("Pose", I[19], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9689061, 0.2457549, -0.0287307, -0.2474286, 0.9623513, -0.1125128, -0.0000016, 0.1161232, 0.9932348) })
					I[21] = new("Pose", I[19], "Right Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9669095, 0.2540223, 0.0236354, -0.2551195, 0.9627388, 0.0897113, 0.0000339, -0.0927726, 0.9956873) })
					I[22] = new("Pose", I[19], "Left Arm", { CFrame = CFrame.new(0.0000001, 0.0000001, 0.0000001, 0.2259265, 0.9741443, 0, -0.9741443, 0.2259265, 0, 0, 0, 1) })
					I[23] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(0, 0, 0, -0.3289069, -0.9443625, 0, 0.9443625, -0.3289069, 0, 0, 0, 1) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[25] = new("Pose", I[24], "HumanoidRootPart")
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, 0, 0.3965192, 0.9917908, -0.1212566, -0.0405944, 0.1211544, 0.9926212, -0.0049777, 0.0408984, 0.0000187, 0.9991633) })
					I[27] = new("Pose", I[26], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9673663, -0.2528485, -0.0164362, 0.2533821, 0.9653271, 0.062777, -0.0000068, -0.064893, 0.9978922) })
					I[28] = new("Pose", I[26], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9559266, -0.2934721, 0.0088589, 0.2936058, 0.9554932, -0.0287815, -0.0000181, 0.0301141, 0.9995465) })
					I[29] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(0, 0, 0, -0.383742, 0.9234404, 0, -0.9234404, -0.383742, 0, 0, 0, 1) })
					I[30] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.3327015, -0.9430323, 0, 0.9430323, 0.3327015, 0, 0, 0, 1) })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 0.95 })
			I[32] = new("Pose", I[31], "HumanoidRootPart")
				I[33] = new("Pose", I[32], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9904729, 0.1333481, 0.0343768, -0.1332674, 0.9910693, -0.0046379, -0.0346883, 0.0000124, 0.9993982) })
					I[34] = new("Pose", I[33], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9688989, 0.2473791, -0.0062046, -0.2474569, 0.9685904, -0.0244485, -0.0000384, 0.0252235, 0.9996818) })
					I[35] = new("Pose", I[33], "Right Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9668972, 0.2542228, 0.0219205, -0.2551661, 0.9633141, 0.0831644, 0.000026, -0.0860047, 0.9962947) })
					I[36] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(0.0000001, 0.0000001, 0.0000001, 0.2259265, 0.9741443, 0, -0.9741443, 0.2259265, 0, 0, 0, 1) })
					I[37] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(0, 0, 0, -0.3289069, -0.9443625, 0, 0.9443625, -0.3289069, 0, 0, 0, 1) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 1.25 })
			I[39] = new("Pose", I[38], "HumanoidRootPart")
				I[40] = new("Pose", I[39], "Torso", { CFrame = CFrame.new(0, 0, 0.3965192, 0.9996867, 0, -0.0250314, 0, 1, 0, 0.0250314, 0, 0.9996867) })
					I[41] = new("Pose", I[40], "Left Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.967347, -0.2529654, -0.0157552, 0.2534556, 0.9654739, 0.0601704, -0.0000098, -0.0621989, 0.9980637) })
					I[42] = new("Pose", I[40], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9559194, -0.2934001, 0.0115951, 0.2936291, 0.9551755, -0.0377064, -0.0000123, 0.0394489, 0.9992216) })
					I[43] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(0, 0, 0, -0.383742, 0.9234404, 0, -0.9234404, -0.383742, 0, 0, 0, 1) })
					I[44] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 0.3327015, -0.9430323, 0, 0.9430323, 0.3327015, 0, 0, 0, 1) })
		I[45] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[46] = new("Pose", I[45], "HumanoidRootPart")
				I[47] = new("Pose", I[46], "Torso")
		I[48] = new("Keyframe", I[1], "Keyframe", { Time = 1.75 })
			I[49] = new("Pose", I[48], "HumanoidRootPart")
				I[50] = new("Pose", I[49], "Torso", { CFrame = CFrame.new(0, 0, 0.3965192, 0.9993396, 0, 0.0363356, 0, 1, 0, -0.0363356, 0, 0.9993396) })
					I[51] = new("Pose", I[50], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9689059, 0.2471203, -0.0123625, -0.2474293, 0.9676892, -0.0485433, -0.000033, 0.0500927, 0.9987445) })
					I[52] = new("Pose", I[50], "Right Leg", { CFrame = CFrame.new(0.0341402, 0.1293765, 0.0060874, 0.9668977, 0.2549137, 0.0113109, -0.2551645, 0.9659448, 0.0429148, 0.0000139, -0.0443804, 0.9990147) })
					I[53] = new("Pose", I[50], "Left Arm", { CFrame = CFrame.new(0, 0, -0.0000001, -0.9997529, -0.0220417, -0.0029015, 0.0222318, -0.9913598, -0.1292729, -0.0000271, -0.1293054, 0.9916048) })
					I[54] = new("Pose", I[50], "Right Arm", { CFrame = CFrame.new(0, 0.0000001, 0, -0.9987358, -0.0494107, -0.0092408, 0.0502674, -0.9818592, -0.182827, -0.0000396, -0.1830604, 0.9831017) })
		I[55] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[56] = new("Pose", I[55], "HumanoidRootPart")
				I[57] = new("Pose", I[56], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9995719, 0, -0.02926, 0, 1, 0, 0.02926, 0, 0.9995719) })
					I[58] = new("Pose", I[57], "Left Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9673586, -0.2520795, -0.025948, 0.2534115, 0.9622921, 0.098877, 0.0000447, -0.102225, 0.9947613) })
					I[59] = new("Pose", I[57], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.9559219, -0.2934245, 0.0107457, 0.2936212, 0.9552826, -0.034955, -0.0000085, 0.0365694, 0.9993311) })
					I[60] = new("Pose", I[57], "Left Arm", { CFrame = CFrame.new(0, 0, -0.0000001, -0.9997525, -0.0202791, -0.0091446, 0.0222456, -0.9107822, -0.4122872, 0.0000321, -0.4123886, 0.911008) })
					I[61] = new("Pose", I[57], "Right Arm", { CFrame = CFrame.new(0, 0, 0.0000001, -0.9987386, -0.0461474, -0.0197945, 0.0502136, -0.9177439, -0.393986, 0.0000151, -0.394483, 0.9189032) })
		I[62] = new("Keyframe", I[1], "Keyframe", { Time = 2.25 })
			I[63] = new("Pose", I[62], "HumanoidRootPart")
				I[64] = new("Pose", I[63], "Torso", { CFrame = CFrame.new(0, 0, 0.3965192, 0.9993645, 0, 0.0356453, 0, 1, 0, -0.0356453, 0, 0.9993645) })
					I[65] = new("Pose", I[64], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9689065, 0.2471278, -0.0121693, -0.2474272, 0.9677317, -0.0476983, -0.0000109, 0.0492262, 0.9987876) })
					I[66] = new("Pose", I[64], "Right Leg", { CFrame = CFrame.new(0.0000001, 0.0000002, 0, 0.966901, 0.2542694, 0.0212018, -0.2551518, 0.9635603, 0.0803061, -0.0000098, -0.0830577, 0.9965447) })
					I[67] = new("Pose", I[64], "Left Arm", { CFrame = CFrame.new(0, 0, -0.0000001, -0.9997529, -0.0220417, -0.0029015, 0.0222318, -0.9913598, -0.1292729, -0.0000271, -0.1293054, 0.9916048) })
					I[68] = new("Pose", I[64], "Right Arm", { CFrame = CFrame.new(0, 0.0000001, 0, -0.9987358, -0.0494107, -0.0092408, 0.0502674, -0.9818592, -0.182827, -0.0000396, -0.1830604, 0.9831017) })
		I[69] = new("Keyframe", I[1], "Keyframe", { Time = 2.5 })
			I[70] = new("Pose", I[69], "HumanoidRootPart")
				I[71] = new("Pose", I[70], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9985493, 0, -0.0538454, 0, 1, 0, 0.0538454, 0, 0.9985493) })
					I[72] = new("Pose", I[71], "Left Leg", { CFrame = CFrame.new(0, 0, 0, 0.9673647, -0.2511236, -0.0338021, 0.2533883, 0.958732, 0.1289469, 0.0000256, -0.1333037, 0.9910752) })
					I[73] = new("Pose", I[71], "Right Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9559204, -0.2934105, 0.0112451, 0.2936259, 0.9552219, -0.0365376, -0.0000211, 0.0382289, 0.999269) })
					I[74] = new("Pose", I[71], "Left Arm", { CFrame = CFrame.new(0, 0, -0.0000001, -0.9997525, -0.0202791, -0.0091446, 0.0222456, -0.9107822, -0.4122872, 0.0000321, -0.4123886, 0.911008) })
					I[75] = new("Pose", I[71], "Right Arm", { CFrame = CFrame.new(0, 0, 0.0000001, -0.9987386, -0.0461474, -0.0197945, 0.0502136, -0.9177439, -0.393986, 0.0000151, -0.394483, 0.9189032) })
		I[76] = new("Keyframe", I[1], "Keyframe", { Time = 2.75 })
			I[77] = new("Pose", I[76], "HumanoidRootPart")
				I[78] = new("Pose", I[77], "Torso", { CFrame = CFrame.new(0, 0, 0.3965192, 0.9990945, 0, 0.0425471, 0, 1, 0, -0.0425471, 0, 0.9990945) })
					I[79] = new("Pose", I[78], "Left Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.968894, 0.2466372, -0.0203589, -0.247476, 0.9656125, -0.0796745, 0.0000081, 0.0822344, 0.996613) })
					I[80] = new("Pose", I[78], "Right Leg", { CFrame = CFrame.new(0.054651, 0.2071034, 0, 0.9669116, 0.2543933, 0.019134, -0.2551118, 0.9641963, 0.0724114, -0.000028, -0.0748968, 0.9971913) })
					I[81] = new("Pose", I[78], "Left Arm", { CFrame = CFrame.new(0, 0, -0.0000001, -0.9997529, -0.0220417, -0.0029015, 0.0222318, -0.9913598, -0.1292729, -0.0000271, -0.1293054, 0.9916048) })
					I[82] = new("Pose", I[78], "Right Arm", { CFrame = CFrame.new(0, 0.0000001, 0, -0.9987358, -0.0494107, -0.0092408, 0.0502674, -0.9818592, -0.182827, -0.0000396, -0.1830604, 0.9831017) })
		I[83] = new("Keyframe", I[1], "End", { Time = 3 })
			I[84] = new("Pose", I[83], "HumanoidRootPart")
				I[85] = new("Pose", I[84], "Torso")
					I[86] = new("Pose", I[85], "Left Leg")
					I[87] = new("Pose", I[85], "Right Leg")
					I[88] = new("Pose", I[85], "Left Arm")
					I[89] = new("Pose", I[85], "Right Arm")
					I[90] = new("Pose", I[85], "Head")
	return I[1]
end

return build
