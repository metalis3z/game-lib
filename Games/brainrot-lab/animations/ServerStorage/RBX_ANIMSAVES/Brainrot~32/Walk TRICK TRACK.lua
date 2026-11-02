-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~32/Walk TRICK TRACK.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk TRICK TRACK", { Priority = Enum.AnimationPriority.Core }, nil, { "1786751643" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.064", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947, 0, 0, 0, 1) })
					I[5] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0.0057166, -0.0711877, -0.0013079, 0.9962502, -0.0815936, -0.0287752, 0.0865145, 0.9361093, 0.3409026, -0.0008787, -0.3421138, 0.939658) })
						I[6] = new("Pose", I[5], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.9999979, -0.0020726, 0.0002745, 0.0020731, 0.9659272, -0.258805, 0.0002713, 0.258805, 0.9659297) })
					I[7] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(0, 0.0000054, 0, 0.9999967, 0.0002715, 0.0025381, 0.0006129, 0.939696, -0.3420107, -0.002478, 0.3420112, 0.9396929) })
						I[8] = new("Pose", I[7], "Bone.005", { CFrame = CFrame.new(0.0000054, 0, 0, 0.9999998, 0.0006957, 0.0000342, -0.000696, 0.996195, 0.087153, 0.0000265, -0.087153, 0.9961955) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Cube.064", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961942, 0.0871603, 0, -0.0871603, 0.9961942, 0, 0, 0, 1) })
					I[12] = new("Pose", I[11], "Bone.002", { CFrame = CFrame.new(0, 0.0000054, 0, 0.9999965, -0.0006319, -0.0025274, -0.0002706, 0.9396877, -0.3420331, 0.0025911, 0.3420326, 0.9396844) })
						I[13] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(0, -0.0000436, 0.0000545, 0.999966, 0.0079466, -0.0022538, -0.0077211, 0.9961981, 0.0867744, 0.0029348, -0.086754, 0.9962257) })
					I[14] = new("Pose", I[11], "Bone.004", { CFrame = CFrame.new(0, 0.0000272, 0, 0.9999967, 0.0006129, -0.002478, 0.0002716, 0.9396924, 0.342021, 0.0025382, -0.3420206, 0.9396891) })
						I[15] = new("Pose", I[14], "Bone.005", { CFrame = CFrame.new(0.0000163, 0, 0, 0.9999992, -0.0013871, 0.0001136, 0.0013858, 0.9848081, -0.1736427, 0.000129, 0.1736428, 0.9848092) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Cube.064", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, -0.0871557, 0, 0.0871557, 0.9961947, 0, 0, 0, 1) })
					I[19] = new("Pose", I[18], "Bone.002", { CFrame = CFrame.new(0.0057166, -0.0711877, -0.0013079, 0.9962502, -0.0815936, -0.0287752, 0.0865145, 0.9361093, 0.3409026, -0.0008787, -0.3421138, 0.939658) })
						I[20] = new("Pose", I[19], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.9999979, -0.0020726, 0.0002745, 0.0020731, 0.9659272, -0.258805, 0.0002713, 0.258805, 0.9659297) })
					I[21] = new("Pose", I[18], "Bone.004", { CFrame = CFrame.new(0, 0.0000054, 0, 0.9999967, 0.0002715, 0.0025381, 0.0006129, 0.939696, -0.3420107, -0.002478, 0.3420112, 0.9396929) })
						I[22] = new("Pose", I[21], "Bone.005", { CFrame = CFrame.new(0.0000054, 0, 0, 0.9999998, 0.0006957, 0.0000342, -0.000696, 0.996195, 0.087153, 0.0000265, -0.087153, 0.9961955) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[24] = new("Pose", I[23], "Cube.064", { Weight = 0 })
				I[25] = new("Pose", I[24], "Bone", { Weight = 0 })
					I[26] = new("Pose", I[25], "Bone.002", { CFrame = CFrame.new(-0.0010463, -0.1428223, -0.0026158, 1, 0.0000122, 0.0001482, -0.0000156, 0.9997295, 0.0232558, -0.0001479, -0.0232558, 0.9997294) })
					I[27] = new("Pose", I[25], "Bone.004", { Weight = 0 })
						I[28] = new("Pose", I[27], "Bone.005", { CFrame = CFrame.new(0.0000054, 0, 0, 1.0000002, 0, 0, 0, 1.0000004, 0, 0, 0, 1.0000005) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[30] = new("Pose", I[29], "Cube.064", { Weight = 0 })
				I[31] = new("Pose", I[30], "Bone", { Weight = 0 })
					I[32] = new("Pose", I[31], "Bone.004", { CFrame = CFrame.new(-0.0103596, -0.2851868, -0.0052752, 0.9961962, 0.0871384, -0.0002777, -0.0871209, 0.9959203, -0.02352, -0.001773, 0.0234547, 0.9997235) })
						I[33] = new("Pose", I[32], "Bone.005", { CFrame = CFrame.new(0.0000163, 0, 0.0000054, 1.0000001, -0.0006959, 0.0000268, 0.0006956, 0.996196, -0.087143, 0.000034, 0.0871431, 0.9961964) })
		I[34] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
