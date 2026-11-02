-- Generated from animations/ServerStorage/MediumSmacks/AnimSaves/Reload_Hunting_Rifle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Reload_Hunting_Rifle", { Loop = false }, nil, { "1617618202" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7959675, 0.6053392, 0, -0.6053392, 0.7959675, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "Attach", { Weight = 0 })
							I[7] = new("Pose", I[6], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[8] = new("Pose", I[6], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7949504, -0.6066747, 0, 0.6066747, 0.7949504, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-1.2952459, -0.2657436, -0.6223054, -0.2307129, 0.9670577, -0.1075682, -0.9685596, -0.2388225, -0.0696858, -0.0930799, 0.0881087, 0.9917525), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[14] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[15] = new("Pose", I[14], "Attach", { Weight = 0 })
							I[16] = new("Pose", I[15], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[17] = new("Pose", I[15], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[18] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0.0000384, -0.00002, -0.0000003, 0.9302444, -0.3540853, 0.0962747, 0.3669404, 0.8976553, -0.2440694, -0.0000001, 0.2623713, 0.964967), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[19] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-1.0743072, -0.3914087, -0.6093127, -0.3785028, 0.7728807, -0.5093047, -0.7276513, -0.5885375, -0.3523453, -0.5720659, 0.2372325, 0.7851509), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.7333333 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[23] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.8333333 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[27] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[28] = new("Pose", I[27], "Attach", { Weight = 0 })
							I[29] = new("Pose", I[28], "Mag", { CFrame = CFrame.new(-1.6882172, -1.1687936, 4.6654739, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[30] = new("Pose", I[28], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[31] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.8469583, -0.4269396, -0.7142997, -0.3785027, 0.7106891, -0.5930066, -0.7276515, -0.6244344, -0.2839102, -0.5720656, 0.3240414, 0.7534841), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 1.3333334 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[36] = new("Pose", I[35], "Attach", { Weight = 0 })
							I[37] = new("Pose", I[36], "Mag", { CFrame = CFrame.new(-0.0256691, -0.0869293, -0.4148674, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[38] = new("Pose", I[36], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[39] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-1.1871872, -0.489918, -0.4175304, -0.5197106, 0.4075172, -0.7508865, -0.4999959, -0.8577502, -0.1194519, -0.6927517, 0.3133598, 0.6495387), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[43] = new("Pose", I[42], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[44] = new("Pose", I[43], "Attach", { Weight = 0 })
							I[45] = new("Pose", I[44], "Mag", { CFrame = CFrame.new(-0.0255051, -0.0865936, 0.0450554, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[46] = new("Pose", I[44], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[47] = new("Pose", I[42], "Left Arm", { CFrame = CFrame.new(-1.10034, -0.8441521, -0.3820742, -0.5049536, 0.4256659, -0.7508864, -0.5300569, -0.8395064, -0.1194522, -0.6812207, 0.3376947, 0.6495388), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[48] = new("Keyframe", I[1], "Keyframe", { Time = 1.9 })
			I[49] = new("Pose", I[48], "HumanoidRootPart", { Weight = 0 })
				I[50] = new("Pose", I[49], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[51] = new("Pose", I[50], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[52] = new("Pose", I[51], "Attach", { Weight = 0 })
							I[53] = new("Pose", I[52], "Mag", { CFrame = CFrame.new(-0.0255051, -0.0865936, 0.0450554, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[54] = new("Pose", I[52], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[55] = new("Pose", I[50], "Left Arm", { CFrame = CFrame.new(-1.2050922, -0.6109573, -0.4858838, -0.5049533, 0.3441271, -0.79158, -0.5300583, -0.8474206, -0.0302759, -0.6812199, 0.4042956, 0.6103153), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 2.1666667 })
			I[57] = new("Pose", I[56], "HumanoidRootPart", { Weight = 0 })
				I[58] = new("Pose", I[57], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[59] = new("Pose", I[58], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[60] = new("Pose", I[59], "Attach", { Weight = 0 })
							I[61] = new("Pose", I[60], "Mag", { CFrame = CFrame.new(-0.0255051, -0.0865936, 0.0450554, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[62] = new("Pose", I[60], "Base", { CFrame = CFrame.new(-0.0000496, -0.3498688, -0.0000305, 1.0000001, 0, 0, 0, 1.0000002, 0.0000001, 0, 0.0000001, 0.9999999), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[63] = new("Pose", I[58], "Head", { CFrame = CFrame.new(0.0000384, -0.00002, -0.0000003, 0.9302444, -0.3540853, 0.0962747, 0.3669404, 0.8976553, -0.2440694, -0.0000001, 0.2623713, 0.964967), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[64] = new("Pose", I[58], "Left Arm", { CFrame = CFrame.new(-0.7628546, -0.8166983, -0.653641, -0.5049533, 0.2636138, -0.8219063, -0.5300574, -0.8462255, 0.0542367, -0.6812205, 0.4630445, 0.5670348), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[65] = new("Keyframe", I[1], "Keyframe", { Time = 2.2666667 })
			I[66] = new("Pose", I[65], "HumanoidRootPart", { Weight = 0 })
				I[67] = new("Pose", I[66], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[68] = new("Pose", I[67], "Right Arm", { CFrame = CFrame.new(0.5338701, -0.3753656, -0.5529675, -0.1477236, -0.7471152, 0.6480714, 0.9760807, -0.2158113, -0.0263023, 0.159512, 0.6286845, 0.7611252), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[69] = new("Pose", I[68], "Attach", { Weight = 0 })
							I[70] = new("Pose", I[69], "Mag", { CFrame = CFrame.new(-0.0255051, -0.0865936, 0.0450554, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[71] = new("Pose", I[69], "Base", { CFrame = CFrame.new(-0.0000496, -0.3498688, -0.0000305, 1.0000001, 0, 0, 0, 1.0000002, 0.0000001, 0, 0.0000001, 0.9999999), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[72] = new("Pose", I[67], "Head", { CFrame = CFrame.new(0.0000384, -0.00002, -0.0000003, 0.9302444, -0.3540853, 0.0962747, 0.3669404, 0.8976553, -0.2440694, -0.0000001, 0.2623713, 0.964967), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[73] = new("Pose", I[67], "Left Arm", { CFrame = CFrame.new(-0.7628546, -0.8166983, -0.653641, -0.5049533, 0.2636138, -0.8219063, -0.5300574, -0.8462255, 0.0542367, -0.6812205, 0.4630445, 0.5670348), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[74] = new("Keyframe", I[1], "Keyframe", { Time = 2.8333333 })
			I[75] = new("Pose", I[74], "HumanoidRootPart", { Weight = 0 })
				I[76] = new("Pose", I[75], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7959675, 0.6053392, 0, -0.6053392, 0.7959675, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[77] = new("Pose", I[76], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254), EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[78] = new("Pose", I[77], "Attach", { Weight = 0 })
							I[79] = new("Pose", I[78], "Mag")
							I[80] = new("Pose", I[78], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[81] = new("Pose", I[76], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7949504, -0.6066747, 0, 0.6066747, 0.7949504, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[82] = new("Pose", I[76], "Left Arm", { CFrame = CFrame.new(-1.2952459, -0.2657436, -0.6223054, -0.2307129, 0.9670577, -0.1075682, -0.9685596, -0.2388225, -0.0696858, -0.0930799, 0.0881087, 0.9917525), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[83] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[84] = new("Pose", I[83], "HumanoidRootPart", { Weight = 0 })
				I[85] = new("Pose", I[84], "Torso", { Weight = 0 })
					I[86] = new("Pose", I[85], "Right Arm", { Weight = 0 })
						I[87] = new("Pose", I[86], "Attach", { Weight = 0 })
							I[88] = new("Pose", I[87], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[89] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[90] = new("Pose", I[89], "HumanoidRootPart", { Weight = 0 })
				I[91] = new("Pose", I[90], "Torso", { Weight = 0 })
					I[92] = new("Pose", I[91], "Right Arm", { Weight = 0 })
						I[93] = new("Pose", I[92], "Attach", { Weight = 0 })
							I[94] = new("Pose", I[93], "Mag", { CFrame = CFrame.new(-0.2099915, 0.0002899, -0.4297682, 0.9999863, 0, 0.0000004, 0, 0.9999867, 0, 0.0000004, 0, 0.9999866), EasingDirection = Enum.PoseEasingDirection.Out, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[95] = new("Keyframe", I[1], "Keyframe", { Time = 1.1666666 })
			I[96] = new("Pose", I[95], "HumanoidRootPart", { Weight = 0 })
				I[97] = new("Pose", I[96], "Torso", { Weight = 0 })
					I[98] = new("Pose", I[97], "Right Arm", { Weight = 0 })
						I[99] = new("Pose", I[98], "Attach", { Weight = 0 })
							I[100] = new("Pose", I[99], "Mag", { CFrame = CFrame.new(-1.6882172, -1.1687936, 4.6654739, 0.9999858, -0.0000002, 0.0000004, -0.0000002, 0.9999863, 0, 0.0000004, 0, 0.9999864), EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[101] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[102] = new("Pose", I[101], "HumanoidRootPart", { Weight = 0 })
				I[103] = new("Pose", I[102], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9277785, 0.3731313, 0, -0.3731313, 0.9277785, 0, 0, 0, 1), EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[104] = new("Pose", I[103], "Left Arm", { CFrame = CFrame.new(-0.8469583, -0.4269396, -0.7142997, -0.3785027, 0.7106891, -0.5930066, -0.7276515, -0.6244344, -0.2839102, -0.5720656, 0.3240414, 0.7534841), EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
