-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~12/Walk TimCheese.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk TimCheese", { Priority = Enum.AnimationPriority.Core }, nil, { "1786751695" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.001", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(-0.0000038, -0.1000004, 0, 0.9860414, 0, -0.1665, 0, 1, 0, 0.1665, 0, 0.9860414) })
					I[5] = new("Pose", I[4], "Bone.L", { CFrame = CFrame.new(-0.0000002, -0.0000038, 0, 0.9998701, -0.002797, 0.0158796, -0.002797, 0.9398226, 0.3416516, -0.0158796, -0.3416516, 0.9396928) })
					I[6] = new("Pose", I[4], "Bone.R", { CFrame = CFrame.new(-0.0000002, 0.0000038, 0, 0.9998701, 0.002797, 0.0158796, 0.002797, 0.9398226, -0.3416513, -0.0158796, 0.3416513, 0.9396929) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9850585, 0, 0.1722197, 0, 1, 0, -0.1722197, 0, 0.9850585) })
					I[8] = new("Pose", I[4], "Bone.1.L", { CFrame = CFrame.new(0, -0.1000023, 0, 1, 0, 0, 0, 0.939696, -0.3420108, 0, 0.3420108, 0.939696) })
					I[9] = new("Pose", I[4], "Bone.1.R", { CFrame = CFrame.new(0, -0.1000023, 0, 1, 0, 0, 0, 0.939696, 0.3420108, 0, -0.3420108, 0.939696) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Cube.001", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0.0499992, 0, 0.9971866, 0, 0.0749594, 0, 1, 0, -0.0749594, 0, 0.9971866) })
					I[13] = new("Pose", I[12], "Bone.L", { CFrame = CFrame.new(0.0000002, 0.0000038, 0, 0.9998701, -0.0027971, -0.01588, -0.0027971, 0.9398191, -0.341661, 0.01588, 0.3416609, 0.9396893) })
					I[14] = new("Pose", I[12], "Bone.R", { CFrame = CFrame.new(-0.0000002, 0.0000038, 0, 0.9998701, 0.0027971, -0.01588, 0.0027971, 0.9398191, 0.3416612, 0.01588, -0.3416612, 0.9396893) })
					I[15] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0.0000038, 0, 0, 0.9807094, 0, -0.195471, 0, 1, 0, 0.195471, 0, 0.9807094) })
					I[16] = new("Pose", I[12], "Bone.1.L", { CFrame = CFrame.new(0, -0.0000172, 0, 1, 0, 0, 0, 0.9396892, 0.3420295, 0, -0.3420295, 0.9396892) })
					I[17] = new("Pose", I[12], "Bone.1.R", { CFrame = CFrame.new(0, -0.0000172, 0, 1, 0, 0, 0, 0.9396812, -0.3420513, 0, 0.3420513, 0.9396812) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Cube.001", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(-0.0000038, -0.1000004, 0, 0.9860414, 0, -0.1665, 0, 1, 0, 0.1665, 0, 0.9860414) })
					I[21] = new("Pose", I[20], "Bone.L", { CFrame = CFrame.new(-0.0000002, -0.0000038, 0, 0.9998701, -0.002797, 0.0158796, -0.002797, 0.9398226, 0.3416516, -0.0158796, -0.3416516, 0.9396928) })
					I[22] = new("Pose", I[20], "Bone.R", { CFrame = CFrame.new(-0.0000002, 0.0000038, 0, 0.9998701, 0.002797, 0.0158796, 0.002797, 0.9398226, -0.3416513, -0.0158796, 0.3416513, 0.9396929) })
					I[23] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9850585, 0, 0.1722197, 0, 1, 0, -0.1722197, 0, 0.9850585) })
					I[24] = new("Pose", I[20], "Bone.1.L", { CFrame = CFrame.new(0, -0.1000023, 0, 1, 0, 0, 0, 0.939696, -0.3420108, 0, 0.3420108, 0.939696) })
					I[25] = new("Pose", I[20], "Bone.1.R", { CFrame = CFrame.new(0, -0.1000023, 0, 1, 0, 0, 0, 0.939696, 0.3420108, 0, -0.3420108, 0.939696) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[27] = new("Pose", I[26], "Cube.001", { Weight = 0 })
				I[28] = new("Pose", I[27], "Bone", { Weight = 0 })
					I[29] = new("Pose", I[28], "Bone.1.L", { CFrame = CFrame.new(0, -0.1000099, 0, 1, 0, 0, 0, 0.9997294, -0.0232627, 0, 0.0232627, 0.9997294) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[31] = new("Pose", I[30], "Cube.001", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { Weight = 0 })
					I[33] = new("Pose", I[32], "Bone.1.R", { CFrame = CFrame.new(0, -0.0999813, 0.0023499, 1, 0, 0, 0, 0.9997237, 0.0235039, 0, -0.0235039, 0.9997237) })
		I[34] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
