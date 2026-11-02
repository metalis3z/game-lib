-- Generated from animations/Workspace/StudioAssets/Pursuer/Pursuer/AnimSaves/PursuerStunned.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "PursuerStunned", { Priority = Enum.AnimationPriority.Action3 }, nil, { "1741504277" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0.6827892, -0.1318277, -0.3443639, 0.7556909, -0.5717261, 0.3194691, 0.637745, 0.7533839, -0.1602936, -0.1490388, 0.3248723, 0.9339408), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-0.6501261, 0.333831, -0.1341235, 0.9606082, -0.2762332, -0.0304485, 0.260975, 0.8589949, 0.4404768, -0.0955192, -0.4310719, 0.8972475), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(-0.1602874, 0.128823, 0.1242673, 0.6089783, -0.1817046, -0.7720938, 0.1343527, 0.9829717, -0.1253638, 0.7817255, -0.0273891, 0.6230209), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0.8012949, -0.3538967, -0.4201825, 0.7464153, 0.4281928, 0.5094264, -0.6637741, 0.5338224, 0.5238681, -0.0476268, -0.7291672, 0.6826764), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[8] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0166618, 0.7937096, -0.2743606, 0.5429101, 0.3947972, 0.9113356, -0.1166303, -0.4627745, 0.3069099, 0.8316526), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[9] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.190528, 0.0673485, -0.2583474, -0.7714236, -0.6065196, 0.1924576, 0.5640107, -0.5117004, 0.6481162, -0.2946146, 0.6085202, 0.7368212), EasingStyle = Enum.PoseEasingStyle.Constant })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0.719718, -0.0599489, -0.3593235, 0.6439598, -0.6727268, 0.3643548, 0.756136, 0.6321634, -0.1691974, -0.1165081, 0.3844581, 0.9157608), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[13] = new("Pose", I[12], "Left Leg", { CFrame = CFrame.new(-0.6908591, 0.4336662, -0.2778133, 0.9842302, -0.0974054, -0.1476584, 0.1552424, 0.8757859, 0.4570544, 0.0847976, -0.4727696, 0.8770965), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[14] = new("Pose", I[12], "Right Leg", { CFrame = CFrame.new(-0.2699361, 0.1158305, 0.0780371, 0.4657416, -0.2060557, -0.8605962, 0.1576782, 0.9762731, -0.1484196, 0.8707596, -0.0665721, 0.4871815), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[15] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(0.8016288, -0.3538901, -0.420043, 0.7474864, 0.4367298, 0.5005308, -0.66317, 0.534101, 0.5243487, -0.0383353, -0.7238806, 0.6888593), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[16] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0.0000001, 0.0000001, 0.0166622, 0.9427258, -0.0863269, 0.3222045, 0.1695897, 0.9558178, -0.2401075, -0.2872411, 0.2809981, 0.9157143), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[17] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.190393, 0.0649104, -0.2623885, -0.7726718, -0.6220213, 0.1267617, 0.5751816, -0.6015072, 0.5543969, -0.2685986, 0.5012776, 0.8225421), EasingStyle = Enum.PoseEasingStyle.Constant })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0.7752931, 0.0596319, -0.3835397, 0.4475589, -0.7830464, 0.4318904, 0.8928642, 0.4182124, -0.1670088, -0.0498462, 0.4603657, 0.8863288), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[21] = new("Pose", I[20], "Left Leg", { CFrame = CFrame.new(-0.6361717, 0.5453041, -0.4768442, 0.9252973, 0.20182, -0.3210821, -0.0157425, 0.8663507, 0.499188, 0.3789158, -0.4568427, 0.8048091), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[22] = new("Pose", I[20], "Right Leg", { CFrame = CFrame.new(-0.4128701, 0.0929178, -0.0351054, 0.2262643, -0.2157768, -0.9498659, 0.1929936, 0.9657542, -0.1734137, 0.9547556, -0.1440807, 0.2601593), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(0.7979958, -0.3539424, -0.421314, 0.7307009, 0.342539, 0.5905449, -0.6690012, 0.5316705, 0.519388, -0.1360647, -0.7745925, 0.617651), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[24] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0.0000001, -0.0000001, 0.0166621, 0.9641604, 0.1397664, 0.2255216, -0.0813483, 0.9647864, -0.2501394, -0.2525412, 0.2228287, 0.9415786), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[25] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.1903953, 0.0653951, -0.2614871, -0.7722659, -0.619408, 0.1412094, 0.5730478, -0.5832093, 0.5757464, -0.2742672, 0.5255488, 0.8053422), EasingStyle = Enum.PoseEasingStyle.Constant })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0.8019906, 0.1252712, -0.3959308, 0.3405164, -0.8175856, 0.4643301, 0.9401857, 0.3013184, -0.1589281, -0.0099739, 0.4906741, 0.8712861), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[29] = new("Pose", I[28], "Left Leg", { CFrame = CFrame.new(-0.5752149, 0.575435, -0.5530618, 0.8469962, 0.3486914, -0.4012627, -0.0969539, 0.8434879, 0.5283257, 0.5226829, -0.4085859, 0.748238), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[30] = new("Pose", I[28], "Right Leg", { CFrame = CFrame.new(-0.4693673, 0.0776506, -0.1132375, 0.1004212, -0.2065053, -0.9732786, 0.2144269, 0.9597274, -0.1815059, 0.9715642, -0.1904701, 0.1406574), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(0.7934603, -0.3539652, -0.4221966, 0.6938995, 0.2218307, 0.6850508, -0.675568, 0.5298294, 0.5127267, -0.2492215, -0.8185793, 0.5175101), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[32] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.0000001, 0.0000002, 0.0166626, 0.9005805, 0.2102115, 0.3804812, -0.120604, 0.9617631, -0.2458992, -0.4176236, 0.1755644, 0.8914974), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[33] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.1907078, 0.0687089, -0.256511, -0.7714427, -0.5957693, 0.2234623, 0.5574917, -0.4635562, 0.6887081, -0.3067238, 0.6558771, 0.6897433), EasingStyle = Enum.PoseEasingStyle.Constant })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.6666667 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0.7698395, 0.0470092, -0.3810716, 0.4683104, -0.7744941, 0.4252579, 0.881701, 0.4408737, -0.1680288, -0.0573477, 0.45364, 0.889338), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[37] = new("Pose", I[36], "Left Leg", { CFrame = CFrame.new(-0.6463089, 0.5370867, -0.4593944, 0.9369607, 0.1717521, -0.3043121, 0.0010885, 0.8694309, 0.4940535, 0.3494331, -0.4632399, 0.8144356), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[38] = new("Pose", I[36], "Right Leg", { CFrame = CFrame.new(-0.4001878, 0.0955492, -0.0213223, 0.2510896, -0.2164545, -0.9434519, 0.1891833, 0.9668538, -0.1714744, 0.9492964, -0.1354299, 0.2837164), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(0.7934005, -0.3539657, -0.4222032, 0.6933445, 0.2201881, 0.6861418, -0.6756068, 0.5298336, 0.5126714, -0.2506568, -0.8190199, 0.5161178), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[40] = new("Pose", I[36], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0166619, 0.807852, 0.0330893, 0.5884558, 0.089898, 0.9798225, -0.1785113, -0.582489, 0.1971117, 0.7885768), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[41] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(0.1912246, 0.0714582, -0.2534061, -0.7727557, -0.5706972, 0.277765, 0.5436175, -0.3692249, 0.7537593, -0.3276106, 0.7334697, 0.5955616), EasingStyle = Enum.PoseEasingStyle.Constant })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.8333333 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { CFrame = CFrame.new(0.7086153, -0.0819842, -0.3547297, 0.6791404, -0.6447114, 0.3508784, 0.7228832, 0.6703899, -0.1673835, -0.1273113, 0.367321, 0.9213399), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[45] = new("Pose", I[44], "Left Leg", { CFrame = CFrame.new(-0.686317, 0.4051483, -0.2344668, 0.9817154, -0.1535408, -0.1125166, 0.1881526, 0.8723394, 0.4512457, 0.028868, -0.4641652, 0.8852781), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[46] = new("Pose", I[44], "Right Leg", { CFrame = CFrame.new(-0.2381642, 0.1197825, 0.0941533, 0.5101357, -0.2001542, -0.8364807, 0.1508885, 0.9782893, -0.1420656, 0.8467552, -0.0537426, 0.5292612), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[47] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(0.7976227, -0.3539461, -0.4214151, 0.7283337, 0.3327025, 0.5990318, -0.6695506, 0.5314477, 0.5189078, -0.1457122, -0.7790201, 0.6098324), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[48] = new("Pose", I[44], "Head", { CFrame = CFrame.new(0.0000001, 0, 0.0166618, 0.7336706, -0.213417, 0.6451206, 0.3344923, 0.9398328, -0.0694922, -0.5914748, 0.2667722, 0.7609141), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[49] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0.1910133, 0.0704423, -0.2544716, -0.7721262, -0.5803932, 0.2587759, 0.548799, -0.4037218, 0.732003, -0.3203761, 0.7072146, 0.6302434), EasingStyle = Enum.PoseEasingStyle.Constant })
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[51] = new("Pose", I[50], "HumanoidRootPart", { Weight = 0 })
				I[52] = new("Pose", I[51], "Torso", { CFrame = CFrame.new(0.6827892, -0.1318277, -0.3443639, 0.7556909, -0.5717261, 0.3194691, 0.637745, 0.7533839, -0.1602936, -0.1490388, 0.3248723, 0.9339408), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[53] = new("Pose", I[52], "Left Leg", { CFrame = CFrame.new(-0.6501261, 0.333831, -0.1341235, 0.9606082, -0.2762332, -0.0304485, 0.260975, 0.8589949, 0.4404768, -0.0955192, -0.4310719, 0.8972475), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[54] = new("Pose", I[52], "Right Leg", { CFrame = CFrame.new(-0.1602874, 0.128823, 0.1242673, 0.6089783, -0.1817046, -0.7720938, 0.1343527, 0.9829717, -0.1253638, 0.7817255, -0.0273891, 0.6230209), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[55] = new("Pose", I[52], "Left Arm", { CFrame = CFrame.new(0.8012949, -0.3538967, -0.4201825, 0.7464153, 0.4281928, 0.5094264, -0.6637741, 0.5338224, 0.5238681, -0.0476268, -0.7291672, 0.6826764), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[56] = new("Pose", I[52], "Head", { CFrame = CFrame.new(0, 0.0000001, 0.0166618, 0.7937096, -0.2743606, 0.5429101, 0.3947972, 0.9113356, -0.1166303, -0.4627745, 0.3069099, 0.8316526), EasingStyle = Enum.PoseEasingStyle.Constant })
					I[57] = new("Pose", I[52], "Right Arm", { CFrame = CFrame.new(0.190528, 0.0673485, -0.2583474, -0.7714236, -0.6065196, 0.1924576, 0.5640107, -0.5117004, 0.6481162, -0.2946146, 0.6085202, 0.7368212), EasingStyle = Enum.PoseEasingStyle.Constant })
	return I[1]
end

return build
