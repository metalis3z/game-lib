-- Generated from animations/ServerStorage/Ban/AnimSaves/Ban.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Ban", { Loop = false }, nil, { "1616036987" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.5613394, -0.793815, -0.2340001, 0.8275857, 0.5384332, 0.1587187, 0.0000001, -0.2827501, 0.9591936), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.2395644, 0.7992184, 0.1198421, 0.8297874, 0.5057338, 0.2359793, -0.5034474, 0.8608065, -0.0745179, -0.2408188, -0.0569692, 0.9688967), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.6494051, -0.1286854, -0.6070726, -0.2137709, -0.4760508, 0.8530403, 0.8755472, 0.2939239, 0.3834394, -0.4332656, 0.8288453, 0.3539726), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[7] = new("Pose", I[6], "BanHammer", { CFrame = CFrame.new(0.35281, 0.1895283, 0.2805643, -0.0031025, 0.3590867, -0.9332991, -0.2966543, 0.89096, 0.3437828, 0.9549798, 0.2779337, 0.1037606), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[8] = new("Pose", I[4], "Head", { CFrame = CFrame.new(-0.0000068, -0.0000076, 0.0000013, 0.4708058, 0.8642603, -0.1771892, -0.8822369, 0.4612126, -0.0945569, 0.0000001, 0.2008408, 0.9796237), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.4201938, 0.4271545, 0.0584901, 0.8801153, 0.4162425, -0.2283405, -0.3932386, 0.9086187, 0.1406251, 0.2660085, -0.033974, 0.9633718), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.0815074, 0.033897, -0.0813147, -0.384435, 0.9222864, -0.0399712, -0.9231521, -0.3840746, 0.0166423, -0.000003, 0.0432974, 0.9990624), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.3665851, 0.9004775, -0.2339993, -0.8993628, 0.4073759, 0.1587181, 0.2382478, 0.1522665, 0.9591939), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[13], "Left Leg", { CFrame = CFrame.new(-0.2395667, 0.7992142, 0.1198394, 0.811438, 0.5346797, 0.2359789, -0.5334885, 0.8425183, -0.0745176, -0.2386596, -0.0654256, 0.9688969), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[15] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.6495805, -0.1285598, -0.6071336, 0.2682216, -0.655283, -0.7061596, 0.8977246, -0.0959157, 0.4299894, -0.3494965, -0.7492692, 0.562537), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[16] = new("Pose", I[15], "BanHammer", { CFrame = CFrame.new(0.9119663, -1.5647049, 0.2289009, -0.010101, 0.9509221, 0.3092658, 0.9820991, -0.0487427, 0.1819496, 0.1880944, 0.3055674, -0.9334073), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[13], "Head", { CFrame = CFrame.new(-0.00002, -0.0000543, 0.0000201, 0.7853737, -0.6158513, 0.0625743, 0.6188626, 0.7834442, -0.0567858, -0.0140519, 0.083323, 0.9964236), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[13], "Right Leg", { CFrame = CFrame.new(0.4201938, 0.4271545, 0.0584901, 0.8801153, 0.4162425, -0.2283405, -0.3932386, 0.9086187, 0.1406251, 0.2660085, -0.033974, 0.9633718), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-0.1981347, -0.37697, -1.3550355, 0.0571254, 0.5804307, -0.8123037, -0.9167914, -0.2916246, -0.2728536, -0.3952603, 0.7602996, 0.5154746), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 3 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.3665857, 0.872656, -0.3226236, -0.8993624, 0.4211727, 0.1173055, 0.2382476, 0.2471531, 0.9392301), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[22], "Left Leg", { CFrame = CFrame.new(-0.239576, 0.7991979, 0.1198287, 0.7295938, 0.6418782, 0.2359772, -0.6450019, 0.7605395, -0.0745165, -0.2273006, -0.097839, 0.9688973), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.6495805, -0.1285598, -0.6071336, 0.2682216, -0.655283, -0.7061596, 0.8977246, -0.0959157, 0.4299894, -0.3494965, -0.7492692, 0.562537), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[25] = new("Pose", I[24], "BanHammer", { CFrame = CFrame.new(0.9119663, -1.5647049, 0.2289009, -0.010101, 0.9509221, 0.3092658, 0.9820991, -0.0487427, 0.1819496, 0.1880944, 0.3055674, -0.9334073), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[26] = new("Pose", I[22], "Head", { CFrame = CFrame.new(-0.0000328, -0.0000617, 0.0000137, 0.7853756, -0.6056349, 0.1280301, 0.61886, 0.7728908, -0.1401859, -0.0140517, 0.1893314, 0.981813), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[27] = new("Pose", I[22], "Right Leg", { CFrame = CFrame.new(0.4202146, 0.4271215, 0.0585224, 0.9268987, 0.2978638, -0.2283334, -0.2713401, 0.952156, 0.1406198, 0.2592945, -0.0683844, 0.9633743), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[28] = new("Pose", I[22], "Left Arm", { CFrame = CFrame.new(-0.1981347, -0.37697, -1.3550355, 0.0571254, 0.5804307, -0.8123037, -0.9167914, -0.2916246, -0.2728536, -0.3952603, 0.7602996, 0.5154746), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 3.9333334 })
			I[30] = new("Pose", I[29], "HumanoidRootPart", { Weight = 0 })
				I[31] = new("Pose", I[30], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8644838, -0.5026606, 0, 0.5026606, 0.8644838, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[32] = new("Pose", I[31], "Left Leg", { CFrame = CFrame.new(0.0000004, 0.1099999, 0.0000102, 0.9645475, 0, 0.2639093, 0, 1, 0, -0.2639093, 0, 0.9645475), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[33] = new("Pose", I[31], "Right Arm", { CFrame = CFrame.new(0.0000139, 0.0000002, -0.0000203, 0.7913834, 0.0923173, -0.6043093, 0, 0.9885318, 0.1510131, 0.61132, -0.1195093, 0.7823077), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[34] = new("Pose", I[33], "BanHammer", { CFrame = CFrame.new(0.2130263, -0.1105339, 0.0000004, 0.8876535, 0.4605117, 0.0000001, -0.4605118, 0.8876536, 0, -0.0000001, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[35] = new("Pose", I[31], "Head", { CFrame = CFrame.new(0.0000358, -0.0000129, 0, 0.8703181, 0.4924009, -0.0093693, -0.4911096, 0.8662981, -0.0913172, -0.0368481, 0.0840764, 0.9957778), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[36] = new("Pose", I[31], "Right Leg", { CFrame = CFrame.new(0.0489315, 0.2466327, 0.0295316, 0.8534797, 0.0591965, -0.5177531, -0.0691928, 0.9976033, 0, 0.5165122, 0.0358248, 0.85553), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[37] = new("Pose", I[31], "Left Arm", { CFrame = CFrame.new(-0.0000032, 0, 0.0000072, 0.9799438, 0, 0.1992743, 0, 1, 0, -0.1992743, 0, 0.9799438), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 7 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.864484, -0.5012425, 0.0377294, 0.5026605, 0.8620453, -0.0648876, 0, 0.0750593, 0.9971791), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[41] = new("Pose", I[40], "Left Leg", { CFrame = CFrame.new(0.0000011, 0.1100065, 0.0000243, 0.9585842, 0.1213448, 0.257666, -0.1191318, 0.9925824, -0.0242441, -0.2586965, -0.0074562, 0.9659298), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[42] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(-0.0020323, -0.0689802, 0.0117035, 0.7962102, 0.0292877, -0.6043107, 0.0783691, 0.9854202, 0.1510133, 0.5999229, -0.1675976, 0.7823066), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[43] = new("Pose", I[42], "BanHammer", { CFrame = CFrame.new(0.2584705, -0.0228615, -0.1293381, 0.8876475, 0.4533752, 0.0808251, -0.4605233, 0.8738695, 0.1557897, 0.0000006, -0.1755082, 0.9844779), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[44] = new("Pose", I[40], "Head", { CFrame = CFrame.new(0.0000358, -0.0000129, 0, 0.8703181, 0.4924009, -0.0093693, -0.4911096, 0.8662981, -0.0913172, -0.0368481, 0.0840764, 0.9957778), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[45] = new("Pose", I[40], "Right Leg", { CFrame = CFrame.new(0.0489585, 0.2466369, 0.0295173, 0.8545508, -0.0526638, -0.5166907, 0.0190456, 0.997354, -0.070156, 0.5190183, 0.0501112, 0.8532928), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[46] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(-0.0047091, -0.0497694, 0.0009685, 0.9754117, 0.0941242, 0.19928, -0.0960508, 0.9953763, -0.0000002, -0.1983586, -0.0191408, 0.9799427), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 10.0333338 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 })
				I[49] = new("Pose", I[48], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.8644838, -0.5026606, 0, 0.5026606, 0.8644838, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[50] = new("Pose", I[49], "Left Leg", { CFrame = CFrame.new(0.0000004, 0.1099999, 0.0000102, 0.9645475, 0, 0.2639093, 0, 1, 0, -0.2639093, 0, 0.9645475), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[51] = new("Pose", I[49], "Right Arm", { CFrame = CFrame.new(0.0000139, 0.0000002, -0.0000203, 0.7913834, 0.0923173, -0.6043093, 0, 0.9885318, 0.1510131, 0.61132, -0.1195093, 0.7823077), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[52] = new("Pose", I[51], "BanHammer", { CFrame = CFrame.new(0.2130263, -0.1105339, 0.0000004, 0.8876535, 0.4605117, 0.0000001, -0.4605118, 0.8876536, 0, -0.0000001, 0, 1), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[53] = new("Pose", I[49], "Head", { CFrame = CFrame.new(0.0000358, -0.0000129, 0, 0.8703181, 0.4924009, -0.0093693, -0.4911096, 0.8662981, -0.0913172, -0.0368481, 0.0840764, 0.9957778), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[54] = new("Pose", I[49], "Right Leg", { CFrame = CFrame.new(0.0489315, 0.2466327, 0.0295316, 0.8534797, 0.0591965, -0.5177531, -0.0691928, 0.9976033, 0, 0.5165122, 0.0358248, 0.85553), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[55] = new("Pose", I[49], "Left Arm", { CFrame = CFrame.new(-0.0000032, 0, 0.0000072, 0.9799438, 0, 0.1992743, 0, 1, 0, -0.1992743, 0, 0.9799438), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[57] = new("Pose", I[56], "HumanoidRootPart", { Weight = 0 })
				I[58] = new("Pose", I[57], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.6865759, 0.6883734, -0.2339992, -0.6715556, 0.7237553, 0.1587181, 0.2786154, 0.0481714, 0.9591939), EasingDirection = Enum.PoseEasingDirection.Out })
					I[59] = new("Pose", I[58], "Right Arm", { CFrame = CFrame.new(0.6495372, -0.1285761, -0.6070843, 0.2682182, -0.922532, -0.2774774, 0.8977255, 0.1348576, 0.4194069, -0.3494964, -0.3615912, 0.8643517), EasingDirection = Enum.PoseEasingDirection.Out })
						I[60] = new("Pose", I[59], "BanHammer", { CFrame = CFrame.new(1.0063323, -1.6009854, -0.2150091, 0.2522143, 0.9291649, -0.2702593, 0.9406229, -0.1698362, 0.2939123, 0.2271932, -0.3283409, -0.9168292), EasingDirection = Enum.PoseEasingDirection.Out })
					I[61] = new("Pose", I[58], "Head", { CFrame = CFrame.new(-0.0000229, -0.0000433, 0.0000164, 0.9458076, -0.318641, 0.0625763, 0.3221237, 0.9449929, -0.0567868, -0.0410395, 0.0738667, 0.9964234), EasingDirection = Enum.PoseEasingDirection.Out })
					I[62] = new("Pose", I[58], "Right Leg", { CFrame = CFrame.new(0.4201938, 0.4271545, 0.0584901, 0.8801153, 0.4162425, -0.2283405, -0.3932386, 0.9086187, 0.1406251, 0.2660085, -0.033974, 0.9633718), EasingDirection = Enum.PoseEasingDirection.Out })
					I[63] = new("Pose", I[58], "Left Arm", { CFrame = CFrame.new(-0.1981164, -0.376975, -1.3550651, 0.0571241, 0.8435077, -0.5340709, -0.9167913, -0.1674681, -0.3625576, -0.3952601, 0.5103424, 0.763754), EasingDirection = Enum.PoseEasingDirection.Out })
		I[64] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[65] = new("Pose", I[64], "HumanoidRootPart", { Weight = 0 })
				I[66] = new("Pose", I[65], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.4496776, 0.8619944, -0.2339993, -0.857047, 0.4901827, 0.1587181, 0.2515166, 0.1291764, 0.9591939), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[67] = new("Pose", I[66], "Right Arm", { CFrame = CFrame.new(0.6495719, -0.1285702, -0.6071197, 0.2682223, -0.7194142, -0.6407028, 0.8977247, -0.0546252, 0.4371574, -0.3494956, -0.6924301, 0.6311842), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[68] = new("Pose", I[67], "BanHammer", { CFrame = CFrame.new(0.9490644, -1.5428684, 0.1168837, -0.0099005, 0.9845071, 0.1750647, 0.9821166, -0.0233439, 0.1868202, 0.1880126, 0.1737834, -0.9666697), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[69] = new("Pose", I[66], "Head", { CFrame = CFrame.new(-0.0000222, -0.0000542, 0.0000201, 0.8400962, -0.5388162, 0.0625748, 0.5419965, 0.8384601, -0.0567859, -0.0218693, 0.081621, 0.9964237), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[70] = new("Pose", I[66], "Right Leg", { CFrame = CFrame.new(0.4201938, 0.4271545, 0.0584901, 0.8801153, 0.4162425, -0.2283405, -0.3932386, 0.9086187, 0.1406251, 0.2660085, -0.033974, 0.9633718), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[71] = new("Pose", I[66], "Left Arm", { CFrame = CFrame.new(-0.198131, -0.3769743, -1.3550413, 0.0571258, 0.6460475, -0.7611565, -0.9167913, -0.267894, -0.2961871, -0.3952602, 0.7147416, 0.5769873), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[72] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[73] = new("Pose", I[72], "HumanoidRootPart", { Weight = 0 })
				I[74] = new("Pose", I[73], "Torso", { Weight = 0 })
					I[75] = new("Pose", I[74], "Right Arm", { Weight = 0 })
						I[76] = new("Pose", I[75], "BanHammer", { CFrame = CFrame.new(-0.2811452, -0.7314994, -0.2238731, 0.6298505, 0.3175031, -0.7088574, 0.6584475, 0.2658182, 0.7041213, 0.4119881, -0.9102371, -0.0416333) })
	return I[1]
end

return build
