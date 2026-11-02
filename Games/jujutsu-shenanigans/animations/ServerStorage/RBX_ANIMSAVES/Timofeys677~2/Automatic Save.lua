-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677~2/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false }, nil, { "1735483560" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7376963, 0.6604125, -0.1402121, -0.6747352, 0.7140614, -0.186678, -0.0231645, 0.2323177, 0.9723641) })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0, -0.0000001, 0.7863574, -0.527587, 0.3213938, 0.1116189, 0.6330222, 0.7660444, -0.6076045, -0.566511, 0.5566704) })
					I[6] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000001, 0, 0.0000004, 0.7917163, -0.6095655, -0.0401906, 0.6003579, 0.7885454, -0.1332906, 0.1129414, 0.0813996, 0.9902618) })
					I[7] = new("Pose", I[4], "Right Leg")
					I[8] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, 0, -0.0000001, 0.8137977, 0.4698463, -0.3420201, -0.5, 0.8660254, 0, 0.2961981, 0.1710101, 0.9396926) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(-0.6503556, 0.0551256, -0.230962, 0.5684496, -0.8013653, -0.1862223, 0.3437122, 0.0256706, 0.9387242, -0.7474805, -0.5976242, 0.2900314) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 })
			I[14] = new("Pose", I[13], "HumanoidRootPart", { Weight = 0 })
				I[15] = new("Pose", I[14], "Torso", { Weight = 0 })
					I[16] = new("Pose", I[15], "Right Arm", { CFrame = CFrame.new(-0.5825703, 0.0986771, 0.1583166, 0.5360842, -0.8086039, -0.2424322, 0.4961585, 0.0694655, 0.8654485, -0.6829644, -0.5842381, 0.4384351) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("Pose", I[18], "Torso", { CFrame = CFrame.new(-0.5000021, 0.0000036, 0.0000015, -0.0560835, 0.9983631, -0.0112213, -0.9761074, -0.0571894, -0.2096278, -0.2099264, -0.0008034, 0.9777168) })
					I[20] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(-0.1585209, 0.1644456, 0.2903261, -0.5648392, -0.7590243, -0.3237883, -0.0003004, -0.392186, 0.919886, -0.825201, 0.5196848, 0.2212939) })
					I[21] = new("Pose", I[19], "Head", { CFrame = CFrame.new(0, 0, -0.0000002, 0.9212654, -0.3866993, 0.0416355, 0.3819539, 0.9197227, 0.0906717, -0.0733558, -0.0676299, 0.9950101) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("Pose", I[23], "Torso", { Weight = 0 })
					I[25] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(0.0535035, 0.19733, 0.3563308, -0.0648524, -0.9162726, -0.3952705, 0.1081886, -0.4002255, 0.9100083, -0.9920129, 0.0162523, 0.1250857) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.5261816, -0.593783, 0.6087318, 0.8190395, 0.5464008, -0.1749866, -0.2287075, 0.5906502, 0.7738379) })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(1.8309921, 0.9986648, 0.8685764, 0.526761, -0.7193195, -0.4528823, 0.1739746, -0.4302784, 0.8857727, -0.832019, -0.5453804, -0.1015106) })
					I[30] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0, -0.0000001, -0.0000005, 0.7379633, 0.6637706, 0.1217329, -0.6747233, 0.7290979, 0.1147374, -0.0125959, -0.166808, 0.9859089) })
					I[31] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.4603133, -1.0948043, -0.0199155, -0.8994504, 0.3575133, -0.2513427, -0.418017, -0.5360475, 0.7334269, 0.1274782, 0.7647467, 0.6315947) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.2166667 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { Weight = 0 })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(2.1938753, 0.9257895, 0.6666756, 0.0273811, -0.9099535, -0.4138055, -0.2469104, -0.4072906, 0.8792894, -0.9686514, 0.078097, -0.2358292) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { CFrame = CFrame.new(0.4000024, 0.0000064, 0.0000009, 0.210707, -0.8637392, 0.4577739, 0.9407489, 0.0518877, -0.3351107, 0.2656954, 0.5012605, 0.8234949) })
					I[39] = new("Pose", I[38], "Right Arm", { CFrame = CFrame.new(0.7357537, -0.1974661, 0.4503015, 0.0909774, -0.9580957, -0.2716174, -0.4661487, -0.2819937, 0.8385613, -0.8800162, 0.0503239, -0.4722701) })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.5101331, -0.821823, 0.2537144, 0.8590269, 0.4721286, -0.1979075, 0.0428591, 0.3189067, 0.9468166) })
					I[43] = new("Pose", I[42], "Right Arm", { CFrame = CFrame.new(0.9196491, -0.5137281, 0.3581311, -0.3476158, -0.9374024, -0.0209753, -0.0691463, 0.0033192, 0.9976009, -0.9350838, 0.3482324, -0.0659717) })
					I[44] = new("Pose", I[42], "Head", { CFrame = CFrame.new(0, -0.0000001, -0.0000004, 0.7443246, 0.6637706, -0.073414, -0.6220364, 0.7290979, 0.285459, 0.2430053, -0.166808, 0.9555749) })
					I[45] = new("Pose", I[42], "Right Leg", { CFrame = CFrame.new(0, 0.0293008, 0) })
					I[46] = new("Pose", I[42], "Left Arm", { CFrame = CFrame.new(-0.2957668, -0.6919464, 0.2167469, -0.6612029, 0.7068504, -0.2513427, -0.6066544, -0.3066847, 0.7334269, 0.4413401, 0.6374222, 0.6315947) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 })
				I[49] = new("Pose", I[48], "Torso", { Weight = 0 })
					I[50] = new("Pose", I[49], "Head", { CFrame = CFrame.new(0, 0, -0.0000001, 0.7927945, -0.6094743, -0.0042359, 0.6094222, 0.7925856, 0.0203113, -0.0090219, -0.0186841, 0.9997847) })
					I[51] = new("Pose", I[49], "Left Arm", { CFrame = CFrame.new(-0.8443112, -0.3661903, 0.2728435, 0.3930597, 0.8773636, 0.275204, -0.0951582, -0.258874, 0.9612123, 0.9145759, -0.4040018, -0.0182646) })
			I[52] = new("KeyframeMarker", I[47], "swing")
		I[53] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[54] = new("Pose", I[53], "HumanoidRootPart", { Weight = 0 })
				I[55] = new("Pose", I[54], "Torso", { CFrame = CFrame.new(-0.8000008, 0.0000015, -0.0000005, 0.4752999, 0.8786393, -0.0456413, -0.8655397, 0.4576439, -0.2034773, -0.1578957, 0.1362171, 0.9780152) })
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[57] = new("Pose", I[56], "HumanoidRootPart", { Weight = 0 })
				I[58] = new("Pose", I[57], "Torso", { CFrame = CFrame.new(0.4666637, 0.0000098, -0.0000016, 0.3102486, -0.8685904, 0.3863891, 0.9324816, 0.1989533, -0.3014892, 0.1849973, 0.4538373, 0.8716695) })
		I[59] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[60] = new("KeyframeMarker", I[59], "hit")
		I[61] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[62] = new("KeyframeMarker", I[61], "end")
	return I[1]
end

return build
