-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~54/Idle Carameline.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Carameline", { Priority = Enum.AnimationPriority.Core }, nil, { "1787545242" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.016", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone.L", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.001.L", { CFrame = CFrame.new(0, -0.005722, -25.6504993) })
						I[6] = new("Pose", I[5], "Bone.009.L", { Weight = 0 })
							I[7] = new("Pose", I[6], "Bone.010.L", { CFrame = CFrame.new(0, -33.3423615, -0.0019073, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1) })
						I[8] = new("Pose", I[5], "Bone.004.L", { Weight = 0 })
							I[9] = new("Pose", I[8], "Bone.005.L", { Weight = 0 })
								I[10] = new("Pose", I[9], "Bone.006.L", { CFrame = CFrame.new(0, 0, 0.0019073, 0.9396926, 0.3420201, -0.000015, -0.3420201, 0.9396926, 0.0000026, 0.000015, 0.0000026, 1) })
									I[11] = new("Pose", I[10], "Bone.007.R", { Weight = 0 })
										I[12] = new("Pose", I[11], "Bone.008.R", { CFrame = CFrame.new(0, 0, 0, 0.9505194, -0.3079898, 0.0406859, 0.3106164, 0.9398549, -0.1420922, 0.0055243, 0.147699, 0.9890171) })
									I[13] = new("Pose", I[10], "Bone.007.L", { Weight = 0 })
										I[14] = new("Pose", I[13], "Bone.008.L", { CFrame = CFrame.new(0, 0, 0, 1.0000001, -0.0000093, 0.0000005, 0.0000092, 0.9999999, 0.0000043, -0.0000006, -0.0000044, 1.0000001) })
						I[15] = new("Pose", I[5], "Bone.009.R", { Weight = 0 })
							I[16] = new("Pose", I[15], "Bone.010.R", { CFrame = CFrame.new(-0.0038147, -33.3423615, -0.0033379, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1) })
								I[17] = new("Pose", I[16], "Bone.011.R", { Weight = 0 })
									I[18] = new("Pose", I[17], "Bone.012.R", { Weight = 0 })
										I[19] = new("Pose", I[18], "Bone.013.R", { CFrame = CFrame.new(0, -0.0038147, -0.0009537, 0.9849221, -0.1729957, 0.0013096, 0.1729957, 0.984808, -0.0150403, 0.0013123, 0.0150401, 0.9998863) })
					I[20] = new("Pose", I[4], "Bone.002.L", { Weight = 0 })
						I[21] = new("Pose", I[20], "Bone.003.L", { CFrame = CFrame.new(0, 0, -0.0019073, 0.9396926, -0.3266026, 0.1015307, 0.3266026, 0.9450071, 0.0170956, -0.1015307, 0.0170956, 0.9946855) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[23] = new("Pose", I[22], "Cube.016", { Weight = 0 })
				I[24] = new("Pose", I[23], "Bone.L", { Weight = 0 })
					I[25] = new("Pose", I[24], "Bone.001.L", { CFrame = CFrame.new(0, -0.0038147, 0) })
						I[26] = new("Pose", I[25], "Bone.009.L", { Weight = 0 })
							I[27] = new("Pose", I[26], "Bone.010.L", { CFrame = CFrame.new(0, -6.9336886, 0, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1) })
						I[28] = new("Pose", I[25], "Bone.004.L", { Weight = 0 })
							I[29] = new("Pose", I[28], "Bone.005.L", { Weight = 0 })
								I[30] = new("Pose", I[29], "Bone.006.L", { CFrame = CFrame.new(0, 0, 0.0019073, 0.9848061, -0.173658, 0.0000076, 0.173658, 0.9848061, 0.0000007, -0.0000076, 0.0000007, 1) })
									I[31] = new("Pose", I[30], "Bone.007.R", { Weight = 0 })
										I[32] = new("Pose", I[31], "Bone.008.R", { CFrame = CFrame.new(0, 0.0004768, 0, 0.987532, 0.1573888, -0.0031051, -0.156727, 0.9848446, 0.0742814, 0.0147492, -0.0728687, 0.9972326) })
									I[33] = new("Pose", I[30], "Bone.007.L", { Weight = 0 })
										I[34] = new("Pose", I[33], "Bone.008.L", { CFrame = CFrame.new(0, 0, 0, 1.0000002, -0.0000092, 0.0000006, 0.0000094, 1, 0.0000044, -0.0000005, -0.0000043, 1.0000001) })
						I[35] = new("Pose", I[25], "Bone.009.R", { Weight = 0 })
							I[36] = new("Pose", I[35], "Bone.010.R", { CFrame = CFrame.new(0, -6.9336886, 0, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1) })
								I[37] = new("Pose", I[36], "Bone.011.R", { Weight = 0 })
									I[38] = new("Pose", I[37], "Bone.012.R", { Weight = 0 })
										I[39] = new("Pose", I[38], "Bone.013.R", { CFrame = CFrame.new(0.0007153, -0.005722, -0.0014305, 0.9849221, -0.1729957, 0.0013096, 0.1729957, 0.984808, -0.0150403, 0.0013123, 0.0150401, 0.9998863) })
					I[40] = new("Pose", I[24], "Bone.002.L", { Weight = 0 })
						I[41] = new("Pose", I[40], "Bone.003.L", { CFrame = CFrame.new(0, -0.0019073, -0.005722, 0.9396926, -0.3266026, 0.1015307, 0.3266026, 0.9450071, 0.0170956, -0.1015307, 0.0170956, 0.9946855) })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[43] = new("Pose", I[42], "Cube.016", { Weight = 0 })
				I[44] = new("Pose", I[43], "Bone.L", { Weight = 0 })
					I[45] = new("Pose", I[44], "Bone.001.L", { CFrame = CFrame.new(0, -0.005722, -25.6504993) })
						I[46] = new("Pose", I[45], "Bone.009.L", { Weight = 0 })
							I[47] = new("Pose", I[46], "Bone.010.L", { CFrame = CFrame.new(0, -33.3423615, -0.0019073, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1) })
						I[48] = new("Pose", I[45], "Bone.004.L", { Weight = 0 })
							I[49] = new("Pose", I[48], "Bone.005.L", { Weight = 0 })
								I[50] = new("Pose", I[49], "Bone.006.L", { CFrame = CFrame.new(0, 0, 0.0019073, 0.9396926, 0.3420201, -0.000015, -0.3420201, 0.9396926, 0.0000026, 0.000015, 0.0000026, 1) })
									I[51] = new("Pose", I[50], "Bone.007.R", { Weight = 0 })
										I[52] = new("Pose", I[51], "Bone.008.R", { CFrame = CFrame.new(0, 0, 0, 0.9505194, -0.3079898, 0.0406859, 0.3106164, 0.9398549, -0.1420922, 0.0055243, 0.147699, 0.9890171) })
									I[53] = new("Pose", I[50], "Bone.007.L", { Weight = 0 })
										I[54] = new("Pose", I[53], "Bone.008.L", { CFrame = CFrame.new(0, 0, 0, 1.0000001, -0.0000093, 0.0000005, 0.0000092, 0.9999999, 0.0000043, -0.0000006, -0.0000044, 1.0000001) })
						I[55] = new("Pose", I[45], "Bone.009.R", { Weight = 0 })
							I[56] = new("Pose", I[55], "Bone.010.R", { CFrame = CFrame.new(-0.0038147, -33.3423615, -0.0033379, 1.0000001, 0, 0, 0, 1.0000002, 0, 0, 0, 1) })
								I[57] = new("Pose", I[56], "Bone.011.R", { Weight = 0 })
									I[58] = new("Pose", I[57], "Bone.012.R", { Weight = 0 })
										I[59] = new("Pose", I[58], "Bone.013.R", { CFrame = CFrame.new(0, -0.0038147, -0.0009537, 0.9849221, -0.1729957, 0.0013096, 0.1729957, 0.984808, -0.0150403, 0.0013123, 0.0150401, 0.9998863) })
					I[60] = new("Pose", I[44], "Bone.002.L", { Weight = 0 })
						I[61] = new("Pose", I[60], "Bone.003.L", { CFrame = CFrame.new(0, 0, -0.0019073, 0.9396926, -0.3266026, 0.1015307, 0.3266026, 0.9450071, 0.0170956, -0.1015307, 0.0170956, 0.9946855) })
		I[62] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[63] = new("Pose", I[62], "Cube.016", { Weight = 0 })
				I[64] = new("Pose", I[63], "Bone.L", { Weight = 0 })
					I[65] = new("Pose", I[64], "Bone.002.L", { Weight = 0 })
						I[66] = new("Pose", I[65], "Bone.003.L", { CFrame = CFrame.new(0, -0.0009537, -0.0038147, 0.9396892, 0.3266115, -0.1015334, -0.3266115, 0.945004, 0.0170965, 0.1015334, 0.0170965, 0.9946852) })
					I[67] = new("Pose", I[64], "Bone.001.L", { Weight = 0 })
						I[68] = new("Pose", I[67], "Bone.009.R", { Weight = 0 })
							I[69] = new("Pose", I[68], "Bone.010.R", { Weight = 0 })
								I[70] = new("Pose", I[69], "Bone.011.R", { Weight = 0 })
									I[71] = new("Pose", I[70], "Bone.012.R", { Weight = 0 })
										I[72] = new("Pose", I[71], "Bone.013.R", { CFrame = CFrame.new(0.0004768, -0.005722, -0.0009537, 1.0000004, 0.0000099, 0, -0.00001, 1.0000001, 0.0000009, 0, -0.0000009, 1.0000004) })
		I[73] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[74] = new("Pose", I[73], "Cube.016", { Weight = 0 })
				I[75] = new("Pose", I[74], "Bone.L", { Weight = 0 })
					I[76] = new("Pose", I[75], "Bone.002.L", { Weight = 0 })
						I[77] = new("Pose", I[76], "Bone.003.L", { CFrame = CFrame.new(0, -0.0023842, -0.0076294, 0.9396892, 0.3266115, -0.1015334, -0.3266115, 0.945004, 0.0170965, 0.1015334, 0.0170965, 0.9946852) })
					I[78] = new("Pose", I[75], "Bone.001.L", { Weight = 0 })
						I[79] = new("Pose", I[78], "Bone.009.R", { Weight = 0 })
							I[80] = new("Pose", I[79], "Bone.010.R", { Weight = 0 })
								I[81] = new("Pose", I[80], "Bone.011.R", { Weight = 0 })
									I[82] = new("Pose", I[81], "Bone.012.R", { Weight = 0 })
										I[83] = new("Pose", I[82], "Bone.013.R", { CFrame = CFrame.new(0.0009537, -0.0076294, -0.0014305, 1.0000004, 0.0000099, 0, -0.00001, 1.0000001, 0.0000009, 0, -0.0000009, 1.0000004) })
		I[84] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
