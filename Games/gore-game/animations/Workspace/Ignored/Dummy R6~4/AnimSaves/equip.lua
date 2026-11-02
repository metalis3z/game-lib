-- Generated from animations/Workspace/Ignored/Dummy R6~4/AnimSaves/equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "equip", { Loop = false, Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.290934, -0.3532888, 0.3436561, -0.2897016, 0.6944562, -0.658638, -0.9212955, -0.388835, -0.0047494, -0.2593996, 0.6054242, 0.752445) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.10075, -0.8125057, -0.2165775, -0.2382528, -0.9524693, 0.1898362, 0.4613903, -0.2830025, -0.8408499, 0.8546079, -0.1127462, 0.5068862) })
							I[7] = new("Pose", I[6], "Bolt")
					I[8] = new("Pose", I[4], "Left Arm")
					I[9] = new("Pose", I[4], "Head")
			I[10] = new("Pose", I[2], "Mag6D", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { Weight = 0 })
					I[14] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.0356466, -0.6700708, 0.1629695, -0.9496012, -0.0013382, -0.313459, -0.0722584, -0.9721252, 0.2230517, -0.3050198, 0.2344601, 0.9230338) })
						I[15] = new("Pose", I[14], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[19] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.3, -0.9999985, 0.0000014, -0.6036129, -0.763118, -0.2308731, 0.7544237, -0.6403564, 0.1441816, -0.2578687, -0.0871463, 0.9622418) })
						I[20] = new("Pose", I[19], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.7565618, -0.302819, -1.4355975, -0.3671608, 0.5358765, -0.7602828, -0.9241832, -0.3026608, 0.2329856, -0.1052561, 0.7881837, 0.6063728) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("Pose", I[23], "Torso", { Weight = 0 })
					I[25] = new("Pose", I[24], "Right Arm", { CFrame = CFrame.new(-0.5999746, -0.399868, 0.0000254, -0.0374558, -0.9385759, 0.3430346, 0.9710636, -0.1152097, -0.2091948, 0.235866, 0.3252729, 0.9157318) })
						I[26] = new("Pose", I[25], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
					I[27] = new("Pose", I[24], "Left Arm", { CFrame = CFrame.new(-0.9482576, -0.3797195, -1.1989832, -0.070302, 0.7466879, -0.6614491, -0.9641907, 0.1191225, 0.2369522, 0.2557228, 0.6544212, 0.7115749) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(-0.599973, -0.3998488, 0.0000246, 0.066716, -0.9406091, 0.3328716, 0.9929038, 0.0296715, -0.1151592, 0.098443, 0.3381925, 0.9359139) })
						I[32] = new("Pose", I[31], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
					I[33] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.9482568, -0.3796961, -1.1989813, 0.1530188, 0.7166872, -0.6804004, -0.9630257, 0.2626302, 0.0600569, 0.2217357, 0.6460532, 0.7303756) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { Weight = 0 })
					I[37] = new("Pose", I[36], "Right Arm", { CFrame = CFrame.new(-0.5999665, -0.7998421, -0.0999666, -0.0654371, -0.9352227, 0.3479607, 0.8871141, 0.1051394, 0.4494156, -0.4568881, 0.3380892, 0.8227691) })
						I[38] = new("Pose", I[37], "Handle", { CFrame = CFrame.new(-0.1007767, -0.8125172, -0.2165537, -0.2445706, -0.9474973, 0.2059955, 0.9604409, -0.2075413, 0.1856874, -0.1331857, 0.2432602, 0.9607737) })
					I[39] = new("Pose", I[36], "Left Arm", { CFrame = CFrame.new(-1.4485948, -0.3170543, -0.1602311, -0.8920388, 0.4507467, -0.0330758, -0.0913339, -0.1081105, 0.9899344, 0.4426338, 0.8860809, 0.1376074) })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "Torso", { Weight = 0 })
					I[43] = new("Pose", I[42], "Right Arm", { CFrame = CFrame.new(-0.6056541, -0.8716429, -0.1424433, -0.1593145, -0.9458559, 0.2828002, 0.87247, -0.0008478, 0.4886672, -0.461969, 0.3245863, 0.8253657) })
						I[44] = new("Pose", I[43], "Handle", { CFrame = CFrame.new(-0.1007767, -0.8125172, -0.2165537, -0.2445706, -0.9474973, 0.2059955, 0.9604409, -0.2075413, 0.1856874, -0.1331857, 0.2432602, 0.9607737) })
							I[45] = new("Pose", I[44], "Bolt")
					I[46] = new("Pose", I[42], "Left Arm", { CFrame = CFrame.new(-1.4034234, -0.3381687, -0.0735473, -0.8920567, 0.4517006, 0.0142199, -0.091339, -0.2110217, 0.9732048, 0.4425978, 0.8668546, 0.2295007) })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[48] = new("Pose", I[47], "HumanoidRootPart", { Weight = 0 })
				I[49] = new("Pose", I[48], "Torso", { Weight = 0 })
					I[50] = new("Pose", I[49], "Right Arm", { CFrame = CFrame.new(-0.599995, -0.9998945, 0.0999982, -0.3447037, -0.9329487, 0.1038556, 0.7755957, -0.2207332, 0.5913782, -0.5288012, 0.2844002, 0.7996786) })
						I[51] = new("Pose", I[50], "Handle", { CFrame = CFrame.new(-0.0635304, -0.7079942, -0.1176467, -0.1770813, -0.8482721, 0.4990759, 0.9834546, -0.1721928, 0.0562741, 0.0382015, 0.5007836, 0.8647292) })
							I[52] = new("Pose", I[51], "Bolt", { CFrame = CFrame.new(0.3499889, -0.0000191, 0.0000248) })
					I[53] = new("Pose", I[49], "Left Arm", { CFrame = CFrame.new(-1.165163, -0.1983065, -0.2596874, -0.9465578, 0.0071532, 0.3224547, 0.3037278, -0.3166238, 0.8986093, 0.1085247, 0.9485242, 0.2975302) })
			I[54] = new("Pose", I[47], "Mag6D", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[55] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[56] = new("Pose", I[55], "HumanoidRootPart", { Weight = 0 })
				I[57] = new("Pose", I[56], "Torso", { Weight = 0 })
					I[58] = new("Pose", I[57], "Right Arm", { CFrame = CFrame.new(-0.600006, -1.1219623, 0.1000039, -0.3979324, -0.9152937, 0.0623488, 0.7847437, -0.3043953, 0.5399269, -0.475213, 0.2637821, 0.8393996) })
						I[59] = new("Pose", I[58], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
							I[60] = new("Pose", I[59], "Bolt")
					I[61] = new("Pose", I[57], "Left Arm", { CFrame = CFrame.new(-1.0266535, -0.5741623, -0.5630441, -0.9090959, 0.215735, 0.3563752, 0.0557197, -0.784808, 0.6172292, 0.412844, 0.5809775, 0.7014449) })
			I[62] = new("Pose", I[55], "Mag6D", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[63] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[64] = new("Pose", I[63], "HumanoidRootPart", { Weight = 0 })
				I[65] = new("Pose", I[64], "Torso", { Weight = 0 })
					I[66] = new("Pose", I[65], "Right Arm", { CFrame = CFrame.new(-0.4206698, -0.543398, -0.0525444, -0.0082397, -0.9617512, 0.2738007, 0.94737, 0.0801237, 0.3099521, -0.3200347, 0.2619445, 0.910474) })
						I[67] = new("Pose", I[66], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
							I[68] = new("Pose", I[67], "Bolt")
					I[69] = new("Pose", I[65], "Left Arm", { CFrame = CFrame.new(-1.0516587, -0.830992, -1.0149863, -0.4270226, 0.9040242, 0.0197996, -0.7620839, -0.3715891, 0.5302354, 0.4867029, 0.2113336, 0.8476192) })
		I[70] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[71] = new("Pose", I[70], "HumanoidRootPart", { Weight = 0 })
				I[72] = new("Pose", I[71], "Torso", { Weight = 0 })
					I[73] = new("Pose", I[72], "Right Arm", { CFrame = CFrame.new(-0.2612547, -0.4763037, -0.1777392, -0.130497, -0.9351608, 0.3293095, 0.9716938, -0.0546609, 0.2298333, -0.1969308, 0.3499806, 0.915823) })
					I[74] = new("Pose", I[72], "Left Arm", { CFrame = CFrame.new(-0.9934258, -0.7016861, -1.0991092, -0.3513986, 0.8203846, -0.4510974, -0.9361656, -0.3024151, 0.1792751, 0.010656, 0.4852988, 0.8742835) })
		I[75] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[76] = new("Pose", I[75], "HumanoidRootPart", { Weight = 0 })
				I[77] = new("Pose", I[76], "Torso", { Weight = 0 })
					I[78] = new("Pose", I[77], "Right Arm", { CFrame = CFrame.new(-0.5054764, -0.3999339, -0.2000026, -0.1612819, -0.951068, 0.2635489, 0.9668823, -0.0987474, 0.235346, -0.1978052, 0.2927778, 0.9354968) })
						I[79] = new("Pose", I[78], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
							I[80] = new("Pose", I[79], "Bolt")
					I[81] = new("Pose", I[77], "Left Arm", { CFrame = CFrame.new(-1.0944928, -0.5998635, -1.099982, -0.3734294, 0.7125599, -0.5939772, -0.9170254, -0.3802221, 0.1203973, -0.1400529, 0.5896521, 0.7954217) })
			I[82] = new("Pose", I[75], "Mag6D", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[83] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[84] = new("Pose", I[83], "HumanoidRootPart", { Weight = 0 })
				I[85] = new("Pose", I[84], "Torso", { Weight = 0 })
					I[86] = new("Pose", I[85], "Right Arm", { CFrame = CFrame.new(-0.5999864, -0.3999354, -0.2000028, -0.1269083, -0.9548316, 0.2686838, 0.9854813, -0.0905713, 0.143609, -0.1127874, 0.283008, 0.9524629) })
						I[87] = new("Pose", I[86], "Handle", { CFrame = CFrame.new(-0.1007549, -0.8125049, -0.2165798, -0.2687341, -0.9524572, -0.1435525, 0.9548169, -0.2830528, 0.0905854, -0.1269116, -0.112723, 0.9854882) })
							I[88] = new("Pose", I[87], "Bolt")
					I[89] = new("Pose", I[85], "Left Arm", { CFrame = CFrame.new(-0.9999834, -0.5998653, -1.099982, -0.3408877, 0.7235741, -0.6001967, -0.9382147, -0.3023012, 0.1684255, -0.0595719, 0.6205276, 0.7819186) })
			I[90] = new("Pose", I[83], "Mag6D", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[91] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[92] = new("Pose", I[91], "HumanoidRootPart", { Weight = 0 })
				I[93] = new("Pose", I[92], "Torso", { Weight = 0 })
					I[94] = new("Pose", I[93], "Left Arm", { CFrame = CFrame.new(-1.1121062, -0.6861498, -0.2538827, -0.7092528, 0.6402645, -0.2949963, -0.61127, -0.3501153, 0.7097669, 0.3511558, 0.6837262, 0.639694) })
					I[95] = new("Pose", I[93], "Head", { CFrame = CFrame.new(0, 0, 0.0000002) })
		I[96] = new("Keyframe", I[1], "Keyframe", { Time = 0.2833333 })
			I[97] = new("Pose", I[96], "HumanoidRootPart", { Weight = 0 })
				I[98] = new("Pose", I[97], "Torso", { Weight = 0 })
					I[99] = new("Pose", I[98], "Right Arm", { Weight = 0 })
						I[100] = new("Pose", I[99], "Handle", { CFrame = CFrame.new(-0.1007385, -0.8125029, -0.2165742, -0.3893446, -0.9187182, -0.0660899, 0.911761, -0.3945943, 0.113962, -0.1307776, -0.0158877, 0.9912844) })
	return I[1]
end

return build
