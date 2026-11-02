-- Generated from animations/ServerStorage/RBX_ANIMSAVES/AnimSaves/idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "idle", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, -0.0000002, 0, 1, 0, 0, 0, 0.9994589, 0.0328918, 0, -0.0328918, 0.9994589), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "torsoback", { CFrame = CFrame.new(0, 0, -0.0000002, 1, 0, 0, 0, 0.9911696, -0.1326004, 0, 0.1326004, 0.9911696), EasingDirection = Enum.PoseEasingDirection.Out })
						I[6] = new("Pose", I[5], "tail", { CFrame = CFrame.new(0, 0.000001, 0.0000001, 1, 0, 0, 0, 0.9941265, -0.1082245, 0, 0.1082245, 0.9941265), EasingDirection = Enum.PoseEasingDirection.Out })
						I[7] = new("Pose", I[5], "LBLEG1", { CFrame = CFrame.new(0, 0.0000002, 0, 1, 0, 0, 0, 0.9856579, 0.168756, 0, -0.168756, 0.9856579), EasingDirection = Enum.PoseEasingDirection.Out })
							I[8] = new("Pose", I[7], "BLLeg2", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9964813, 0.0838154, 0, -0.0838154, 0.9964813), EasingDirection = Enum.PoseEasingDirection.Out })
								I[9] = new("Pose", I[8], "BLLeg3", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
									I[10] = new("Pose", I[9], "LBHoof", { CFrame = CFrame.new(0, 0.0000001, 0, 1, 0, 0, 0, 0.9979909, -0.0633573, 0, 0.0633573, 0.9979909), EasingDirection = Enum.PoseEasingDirection.Out })
					I[11] = new("Pose", I[4], "neck", { CFrame = CFrame.new(0, 0.0000032, -0.0000038, 1, 0, 0, 0, 0.9998038, 0.0197739, 0, -0.0197739, 0.9998038), EasingDirection = Enum.PoseEasingDirection.Out })
						I[12] = new("Pose", I[11], "FakeHead", { CFrame = CFrame.new(0, 0.0000001, 0, 1, 0, 0, 0, 0.9946565, 0.1032421, 0, -0.1032421, 0.9946565), EasingDirection = Enum.PoseEasingDirection.Out })
							I[13] = new("Pose", I[12], "head2", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[14] = new("Pose", I[4], "RFLeg1", { CFrame = CFrame.new(0, 0.0000002, 0, 1, 0, 0, 0, 0.9990397, 0.0438141, 0, -0.0438141, 0.9990397), EasingDirection = Enum.PoseEasingDirection.Out })
					I[15] = new("Pose", I[4], "LFleg1", { CFrame = CFrame.new(0, -0.0000011, 0, 1, 0, 0, 0, 0.996297, -0.0859774, 0, 0.0859774, 0.996297), EasingDirection = Enum.PoseEasingDirection.Out })
						I[16] = new("Pose", I[15], "RFLeg2", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
							I[17] = new("Pose", I[16], "LFHoof", { CFrame = CFrame.new(0, -0.0000003, -0.0000001, 1, 0, 0, 0, 0.9992874, 0.0377439, 0, -0.0377439, 0.9992874), EasingDirection = Enum.PoseEasingDirection.Out })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.881 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { CFrame = CFrame.new(0, -0.0000005, 0, 1, 0, 0, 0, 0.9994589, 0.0328921, 0, -0.0328921, 0.9994589), EasingDirection = Enum.PoseEasingDirection.Out })
		I[21] = new("Keyframe", I[1], "KF2", { Time = 1 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[23] = new("Pose", I[22], "Torso", { CFrame = CFrame.new(0, -0.0000005, 0, 1, 0, 0, 0, 0.9994589, 0.0328921, 0, -0.0328921, 0.9994589), EasingDirection = Enum.PoseEasingDirection.Out })
					I[24] = new("Pose", I[23], "neck", { CFrame = CFrame.new(0, 0.0000001, 0.0000001, 1, 0, 0, 0, 0.9997478, 0.0224577, 0, -0.0224577, 0.9997478), EasingDirection = Enum.PoseEasingDirection.Out })
						I[25] = new("Pose", I[24], "FakeHead", { CFrame = CFrame.new(0, -0.0000011, -0.0000021, 1, 0, 0, 0, 0.9978684, 0.065253, 0, -0.065253, 0.9978684), EasingDirection = Enum.PoseEasingDirection.Out })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 1.295 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { CFrame = CFrame.new(0, -0.0000005, 0, 1, 0, 0, 0, 0.9994589, 0.0328921, 0, -0.0328921, 0.9994589), EasingDirection = Enum.PoseEasingDirection.Out })
		I[29] = new("Keyframe", I[1], "End", { Time = 2.5 })
			I[30] = new("Pose", I[29], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[31] = new("Pose", I[30], "torsoback", { CFrame = CFrame.new(0, 0.0000002, -0.0000004, 1, 0, 0, 0, 0.9911696, -0.1326005, 0, 0.1326005, 0.9911696), EasingDirection = Enum.PoseEasingDirection.Out })
				I[32] = new("Pose", I[30], "neck", { CFrame = CFrame.new(0, 0.0000003, -0.0000005, 1, 0, 0, 0, 0.9998586, 0.0168196, 0, -0.0168196, 0.9998586), EasingDirection = Enum.PoseEasingDirection.Out })
					I[33] = new("Pose", I[32], "FakeHead", { CFrame = CFrame.new(0, 0.0000001, 0, 1, 0, 0, 0, 0.9946565, 0.1032421, 0, -0.1032421, 0.9946565), EasingDirection = Enum.PoseEasingDirection.Out })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 3.2 })
			I[35] = new("Pose", I[34], "torsoback", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[36] = new("Pose", I[35], "tail", { CFrame = CFrame.new(0, 0.000001, 0.0000001, 1, 0, 0, 0, 0.9941266, -0.1082238, 0, 0.1082238, 0.9941266), EasingDirection = Enum.PoseEasingDirection.Out })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 3.75 })
			I[38] = new("Pose", I[37], "torsoback", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[39] = new("Pose", I[38], "tail", { CFrame = CFrame.new(0.0000001, 0.0000012, 0.0000002, 0.9376299, -0.2521438, 0.2393191, 0.2043309, 0.9566794, 0.2073967, -0.2812454, -0.1455611, 0.948532), EasingDirection = Enum.PoseEasingDirection.Out })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 4 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[42] = new("Pose", I[41], "Torso", { CFrame = CFrame.new(0, -0.0000005, 0, 1, 0, 0, 0, 0.9994589, 0.0328921, 0, -0.0328921, 0.9994589), EasingDirection = Enum.PoseEasingDirection.Out })
					I[43] = new("Pose", I[42], "torsoback", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
						I[44] = new("Pose", I[43], "tail", { CFrame = CFrame.new(-0.0000001, 0.0000012, 0.0000001, 0.8696672, -0.3138911, 0.3809871, 0.2772175, 0.9491521, 0.1492004, -0.4084474, -0.0241383, 0.9124627), EasingDirection = Enum.PoseEasingDirection.Out })
					I[45] = new("Pose", I[42], "neck", { CFrame = CFrame.new(0, 0.0000001, 0.0000001, 1, 0, 0, 0, 0.9997478, 0.0224577, 0, -0.0224577, 0.9997478), EasingDirection = Enum.PoseEasingDirection.Out })
						I[46] = new("Pose", I[45], "FakeHead", { CFrame = CFrame.new(0, -0.0000011, -0.0000021, 1, 0, 0, 0, 0.9978684, 0.065253, 0, -0.065253, 0.9978684), EasingDirection = Enum.PoseEasingDirection.Out })
		I[47] = new("Keyframe", I[1], "Keyframe", { Time = 4.5 })
			I[48] = new("Pose", I[47], "torsoback", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[49] = new("Pose", I[48], "tail", { CFrame = CFrame.new(0, 0.000001, 0.0000001, 1, 0, 0, 0, 0.9941266, -0.1082238, 0, 0.1082238, 0.9941266), EasingDirection = Enum.PoseEasingDirection.Out })
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 5 })
			I[51] = new("Pose", I[50], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[52] = new("Pose", I[51], "Torso", { CFrame = CFrame.new(0, -0.0000002, 0, 1, 0, 0, 0, 0.9994589, 0.0328918, 0, -0.0328918, 0.9994589), EasingDirection = Enum.PoseEasingDirection.Out })
					I[53] = new("Pose", I[52], "torsoback", { CFrame = CFrame.new(0, 0, -0.0000002, 1, 0, 0, 0, 0.9911696, -0.1326004, 0, 0.1326004, 0.9911696), EasingDirection = Enum.PoseEasingDirection.Out })
						I[54] = new("Pose", I[53], "tail", { CFrame = CFrame.new(0, 0.000001, 0.0000001, 1, 0, 0, 0, 0.9941265, -0.1082245, 0, 0.1082245, 0.9941265), EasingDirection = Enum.PoseEasingDirection.Out })
						I[55] = new("Pose", I[53], "LBLEG1", { CFrame = CFrame.new(0, 0.0000002, 0, 1, 0, 0, 0, 0.9856579, 0.168756, 0, -0.168756, 0.9856579), EasingDirection = Enum.PoseEasingDirection.Out })
							I[56] = new("Pose", I[55], "BLLeg2", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9964813, 0.0838154, 0, -0.0838154, 0.9964813), EasingDirection = Enum.PoseEasingDirection.Out })
								I[57] = new("Pose", I[56], "BLLeg3", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
									I[58] = new("Pose", I[57], "LBHoof", { CFrame = CFrame.new(0, 0.0000001, 0, 1, 0, 0, 0, 0.9979909, -0.0633573, 0, 0.0633573, 0.9979909), EasingDirection = Enum.PoseEasingDirection.Out })
					I[59] = new("Pose", I[52], "neck", { CFrame = CFrame.new(0, 0.0000032, -0.0000038, 1, 0, 0, 0, 0.9998038, 0.0197739, 0, -0.0197739, 0.9998038), EasingDirection = Enum.PoseEasingDirection.Out })
						I[60] = new("Pose", I[59], "FakeHead", { CFrame = CFrame.new(0, 0.0000001, 0, 1, 0, 0, 0, 0.9946565, 0.1032421, 0, -0.1032421, 0.9946565), EasingDirection = Enum.PoseEasingDirection.Out })
							I[61] = new("Pose", I[60], "head2", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[62] = new("Pose", I[52], "RFLeg1", { CFrame = CFrame.new(0, 0.0000002, 0, 1, 0, 0, 0, 0.9990397, 0.0438141, 0, -0.0438141, 0.9990397), EasingDirection = Enum.PoseEasingDirection.Out })
					I[63] = new("Pose", I[52], "LFleg1", { CFrame = CFrame.new(0, -0.0000011, 0, 1, 0, 0, 0, 0.996297, -0.0859774, 0, 0.0859774, 0.996297), EasingDirection = Enum.PoseEasingDirection.Out })
						I[64] = new("Pose", I[63], "RFLeg2", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
							I[65] = new("Pose", I[64], "LFHoof", { CFrame = CFrame.new(0, -0.0000003, -0.0000001, 1, 0, 0, 0, 0.9992874, 0.0377439, 0, -0.0377439, 0.9992874), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
