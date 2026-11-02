-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~10/Walk Quesadilha.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Quesadilha", { Priority = Enum.AnimationPriority.Core }, nil, { "1786645748" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.051", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9993935, 0.0051781, -0.0344343, -0.0063767, 0.9993743, -0.0347897, 0.0342326, 0.0349882, 0.9988012) })
					I[5] = new("Pose", I[4], "Bone.L", { CFrame = CFrame.new(-0.0000044, 0, 0, 0.4935346, 0.8110512, 0.3140383, -0.8688209, 0.4762314, 0.1354774, -0.0396758, -0.3397058, 0.9396948) })
					I[6] = new("Pose", I[4], "Bone.R", { CFrame = CFrame.new(-0.0000088, 0.0000044, 0, 0.4750063, -0.6526658, 0.5902514, 0.8768088, 0.4079481, -0.2545288, -0.0746697, 0.6384403, 0.7660411) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1735245, 0.0065536, -0.1735245, 0.9848294, -0.000573, -0.0065536, -0.000573, 0.9999784) })
					I[8] = new("Pose", I[4], "Bone.1.L", { CFrame = CFrame.new(0, 0.0000044, 0, 0.9994172, -0.0058996, -0.0336238, -0.0059006, 0.9402756, -0.3403634, 0.0336236, 0.3403634, 0.9396926) })
					I[9] = new("Pose", I[4], "Bone.1.R", { CFrame = CFrame.new(0, -0.0000044, 0, 0.9994172, 0.0059006, -0.0336236, 0.0058995, 0.9402756, 0.3403634, 0.0336238, -0.3403634, 0.9396926) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Cube.051", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9993935, -0.0051781, 0.0344343, 0.0027635, 0.9975569, 0.0698041, -0.0347117, -0.0696666, 0.9969662) })
					I[13] = new("Pose", I[12], "Bone.L", { CFrame = CFrame.new(-0.0000132, 0, 0, 0.4934889, 0.8110704, -0.3140603, -0.8688448, 0.4762049, -0.135418, 0.0397235, 0.3396969, 0.939696) })
					I[14] = new("Pose", I[12], "Bone.R", { CFrame = CFrame.new(-0.0000219, 0.000011, 0, 0.4935039, -0.8110819, -0.3140072, 0.8688399, 0.4761955, 0.1354819, 0.0396418, -0.3396828, 0.9397045) })
					I[15] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848065, -0.1735316, -0.0065539, 0.1735316, 0.9848281, -0.000573, 0.0065539, -0.000573, 0.9999784) })
					I[16] = new("Pose", I[12], "Bone.1.L", { CFrame = CFrame.new(0, 0.0000044, 0, 0.9994172, -0.0059009, 0.0336246, -0.0058999, 0.9402721, 0.3403729, -0.0336248, -0.340373, 0.9396891) })
					I[17] = new("Pose", I[12], "Bone.1.R", { CFrame = CFrame.new(0, 0.0000044, 0, 0.9994156, 0.0058953, 0.0336699, 0.0059232, 0.9402457, -0.3404456, -0.033665, 0.340446, 0.9396613) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Cube.051", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9993935, 0.0051781, -0.0344343, -0.0063767, 0.9993743, -0.0347897, 0.0342326, 0.0349882, 0.9988012) })
					I[21] = new("Pose", I[20], "Bone.L", { CFrame = CFrame.new(-0.0000044, 0, 0, 0.4935346, 0.8110512, 0.3140383, -0.8688209, 0.4762314, 0.1354774, -0.0396758, -0.3397058, 0.9396948) })
					I[22] = new("Pose", I[20], "Bone.R", { CFrame = CFrame.new(-0.0000088, 0.0000044, 0, 0.4750063, -0.6526658, 0.5902514, 0.8768088, 0.4079481, -0.2545288, -0.0746697, 0.6384403, 0.7660411) })
					I[23] = new("Pose", I[20], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1735245, 0.0065536, -0.1735245, 0.9848294, -0.000573, -0.0065536, -0.000573, 0.9999784) })
					I[24] = new("Pose", I[20], "Bone.1.L", { CFrame = CFrame.new(0, 0.0000044, 0, 0.9994172, -0.0058996, -0.0336238, -0.0059006, 0.9402756, -0.3403634, 0.0336236, 0.3403634, 0.9396926) })
					I[25] = new("Pose", I[20], "Bone.1.R", { CFrame = CFrame.new(0, -0.0000044, 0, 0.9994172, 0.0059006, -0.0336236, 0.0058995, 0.9402756, 0.3403634, 0.0336238, -0.3403634, 0.9396926) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
