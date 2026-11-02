-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~20/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786653401" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.001", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.0063429, 0.1735323, -0.0063429, 0.9999797, -0.0005546, -0.1735323, -0.0005546, 0.984828) })
					I[5] = new("Pose", I[4], "Bone.010")
					I[6] = new("Pose", I[4], "Bone.012")
					I[7] = new("Pose", I[4], "Bone.016")
					I[8] = new("Pose", I[4], "Bone.014")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Cube.001", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { Weight = 0 })
					I[12] = new("Pose", I[11], "Bone.010", { CFrame = CFrame.new(0, -0.0000054, -0.0000436, 1, 0, 0, 0, 0.8558379, 0.5172443, 0, -0.5172443, 0.8558379) })
					I[13] = new("Pose", I[11], "Bone.012", { CFrame = CFrame.new(0, -0.0000109, 0, 1, 0, 0, 0, 0.8558067, -0.517296, 0, 0.517296, 0.8558067) })
					I[14] = new("Pose", I[11], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8558378, 0.5172445, 0, -0.5172445, 0.8558378) })
					I[15] = new("Pose", I[11], "Bone.014", { CFrame = CFrame.new(0, 0.0000054, -0.0000436, 1, 0, 0, 0, 0.8558379, -0.5172443, 0, 0.5172443, 0.8558379) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Cube.001", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.0063429, 0.1735323, -0.0063429, 0.9999797, -0.0005546, -0.1735323, -0.0005546, 0.984828) })
					I[19] = new("Pose", I[18], "Bone.010")
					I[20] = new("Pose", I[18], "Bone.012")
					I[21] = new("Pose", I[18], "Bone.016")
					I[22] = new("Pose", I[18], "Bone.014")
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 1.5 })
			I[24] = new("Pose", I[23], "Cube.001", { Weight = 0 })
				I[25] = new("Pose", I[24], "Bone", { Weight = 0 })
					I[26] = new("Pose", I[25], "Bone.010", { CFrame = CFrame.new(0, -0.0000054, -0.0000436, 1, 0, 0, 0, 0.8558379, 0.5172443, 0, -0.5172443, 0.8558379) })
					I[27] = new("Pose", I[25], "Bone.012", { CFrame = CFrame.new(0, -0.0000109, 0, 1, 0, 0, 0, 0.8558067, -0.517296, 0, 0.517296, 0.8558067) })
					I[28] = new("Pose", I[25], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8558378, 0.5172445, 0, -0.5172445, 0.8558378) })
					I[29] = new("Pose", I[25], "Bone.014", { CFrame = CFrame.new(0, 0.0000054, -0.0000436, 1, 0, 0, 0, 0.8558379, -0.5172443, 0, 0.5172443, 0.8558379) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[31] = new("Pose", I[30], "Cube.001", { Weight = 0 })
				I[32] = new("Pose", I[31], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.0063429, 0.1735323, -0.0063429, 0.9999797, -0.0005546, -0.1735323, -0.0005546, 0.984828) })
					I[33] = new("Pose", I[32], "Bone.010")
					I[34] = new("Pose", I[32], "Bone.012")
					I[35] = new("Pose", I[32], "Bone.016")
					I[36] = new("Pose", I[32], "Bone.014")
		I[37] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
