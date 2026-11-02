-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677/Punch1.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Punch1", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.2734434, 0.9618881, 0, -0.9618881, 0.2734434, 0, 0, 0, 1) })
					I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 0.5820163, -0.8131771, 0, 0.8131771, 0.5820163, 0, 0, 0, 1) })
					I[7] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0.0000001, 0, 0, 0.0847818, -0.5719348, -0.815906, 0.9963995, 0.0486649, 0.0694239, 0, -0.8188543, 0.5740015) })
					I[8] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.1144499, -0.3605689, 0, -0.3025397, 0.9531368, 0, -0.9531368, -0.3025397, 0, 0, 0, 1) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[10] = new("KeyframeMarker", I[9], "swing", { Value = "0" })
			I[11] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("IntValue", I[11], "Null")
				I[13] = new("Pose", I[11], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.0591151, 0.9979486, 0.0245793, -0.9982512, 0.0590972, 0.0014556, 0, -0.0246223, 0.9996969) })
					I[14] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0, 0, -0.0000001, 0.5820163, -0.8097668, 0.074396, 0.8131771, 0.5795754, -0.0532475, 0, 0.091488, 0.9958062) })
					I[15] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.0000001, 0, 0.0000002, 0.1216655, -0.5652388, -0.815906, 0.9911518, 0.1131301, 0.0694239, 0.0530624, -0.8171332, 0.5740015) })
					I[16] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-0.11445, -0.3605689, 0, -0.3934825, 0.9193321, 0, -0.9193321, -0.3934825, 0, 0, 0, 1) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("IntValue", I[18], "Null")
				I[20] = new("Pose", I[18], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.1783409, 0.9836618, 0.0245793, -0.9839644, 0.1783594, 0.0014556, -0.0029522, -0.0244447, 0.9996969) })
					I[21] = new("Pose", I[20], "Head", { CFrame = CFrame.new(0, 0, 0, 0.5820163, -0.8119484, 0.0446854, 0.8131771, 0.5811369, -0.0319827, 0, 0.0549516, 0.998489) })
					I[22] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.0000001, 0, 0.0000002, 0.1216655, -0.5068464, -0.8534074, 0.9911518, 0.1080027, 0.0771591, 0.0530624, -0.855244, 0.5155019) })
					I[23] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.1144498, -0.3605689, 0, -0.3291165, 0.9442894, 0, -0.9442894, -0.3291165, 0, 0, 0, 1) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[25] = new("KeyframeMarker", I[24], "hit")
			I[26] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[27] = new("IntValue", I[26], "Null")
				I[28] = new("Pose", I[26], "Torso", { CFrame = CFrame.new(0, 0, 0, -0.045721, -0.9619758, 0.2692807, 0.9906515, -0.078345, -0.1116767, 0.1285271, 0.2616573, 0.9565648) })
					I[29] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, 0, 0, 0.8022211, 0.5953525, 0.0446854, -0.5944935, 0.8034641, -0.0319827, -0.0549441, -0.000908, 0.998489) })
					I[30] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.5312846, -0.0056648, 0.6280551, -0.1515468, -0.0084033, -0.9884143, 0.9861526, -0.0694252, -0.1506097, -0.0673552, -0.9975518, 0.0188081) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.11445, -0.3605689, -0.0000001, -0.3291165, 0.9345906, 0.1349917, -0.9442894, -0.3257361, -0.0470491, 0, -0.1429558, 0.989729) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.2833333 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("IntValue", I[33], "Null")
				I[35] = new("Pose", I[33], "Torso", { CFrame = CFrame.new(0, 0, 0, -0.1803784, -0.9565792, 0.2289539, 0.9741387, -0.2059403, -0.0929647, 0.1360789, 0.206264, 0.9689879) })
					I[36] = new("Pose", I[35], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7808633, 0.6231018, 0.0446854, -0.622287, 0.7821356, -0.0319827, -0.0548786, -0.002833, 0.998489) })
					I[37] = new("Pose", I[35], "Right Arm", { CFrame = CFrame.new(0.7003003, -0.0047557, 0.2610824, -0.1515468, -0.8287147, -0.5387627, 0.9861526, -0.1639027, -0.0252795, -0.0673552, -0.5351334, 0.8420781) })
					I[38] = new("Pose", I[35], "Left Arm", { CFrame = CFrame.new(-0.1144501, -0.3605689, 0.0000001, -0.284759, 0.9490467, 0.1349917, -0.9585755, -0.2809259, -0.0470491, -0.0067291, -0.1427974, 0.989729) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[40] = new("KeyframeMarker", I[39], "end", { Value = "0" })
			I[41] = new("Pose", I[39], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("IntValue", I[41], "Null")
				I[43] = new("Pose", I[41], "Torso", { CFrame = CFrame.new(0, 0, 0, -0.0670088, -0.96987, 0.2342266, 0.9906702, -0.0925949, -0.0999943, 0.1186697, 0.2253408, 0.9670258) })
					I[44] = new("Pose", I[43], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7267053, 0.6854947, 0.0446854, -0.6847876, 0.7280405, -0.0319827, -0.0544568, -0.007358, 0.998489) })
					I[45] = new("Pose", I[43], "Right Arm", { CFrame = CFrame.new(0.7003006, -0.0047557, 0.2610825, -0.1515468, -0.8613731, -0.4848399, 0.9861526, -0.1651808, -0.0147799, -0.0673552, -0.4803661, 0.874478) })
					I[46] = new("Pose", I[43], "Left Arm", { CFrame = CFrame.new(-0.1144502, -0.3605689, -0.0000001, -0.284759, 0.9533331, 0.100341, -0.9585755, -0.282453, -0.0367875, -0.0067291, -0.10666, 0.9942728) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.4166667 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 })
				I[49] = new("IntValue", I[48], "Null")
				I[50] = new("Pose", I[48], "Torso", { CFrame = CFrame.new(0, 0, 0, -0.0641369, -0.9711754, 0.2295756, 0.9911802, -0.0887269, -0.0984342, 0.1159664, 0.2212375, 0.9683003) })
					I[51] = new("Pose", I[50], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7267053, 0.6865112, 0.0245363, -0.6847876, 0.7267874, -0.0533482, -0.0544568, 0.0219662, 0.9982745) })
					I[52] = new("Pose", I[50], "Right Arm", { CFrame = CFrame.new(0.7003004, -0.0047558, 0.2610825, -0.1230466, -0.8659039, -0.4848399, 0.9910653, -0.1325566, -0.0147799, -0.0514707, -0.4823267, 0.874478) })
					I[53] = new("Pose", I[50], "Left Arm", { CFrame = CFrame.new(-0.1144502, -0.3605688, 0.0000001, -0.3090697, 0.9457313, 0.100341, -0.951031, -0.3068986, -0.0367875, -0.0039966, -0.1067973, 0.9942728) })
		I[54] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[55] = new("Pose", I[54], "HumanoidRootPart", { Weight = 0 })
				I[56] = new("IntValue", I[55], "Null")
				I[57] = new("Pose", I[55], "Torso", { CFrame = CFrame.new(0, 0, 0, -0.0641369, -0.9711754, 0.2295756, 0.9911802, -0.0887269, -0.0984342, 0.1159664, 0.2212375, 0.9683003) })
					I[58] = new("Pose", I[57], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7267053, 0.6865112, 0.0245363, -0.6847876, 0.7267874, -0.0533482, -0.0544568, 0.0219662, 0.9982745) })
					I[59] = new("Pose", I[57], "Right Arm", { CFrame = CFrame.new(0.7003004, -0.0047558, 0.2610825, -0.1230466, -0.8659039, -0.4848399, 0.9910653, -0.1325566, -0.0147799, -0.0514707, -0.4823267, 0.874478) })
					I[60] = new("Pose", I[57], "Left Arm", { CFrame = CFrame.new(-0.1144502, -0.3605688, 0.0000001, -0.3090697, 0.9457313, 0.100341, -0.951031, -0.3068986, -0.0367875, -0.0039966, -0.1067973, 0.9942728) })
	return I[1]
end

return build
