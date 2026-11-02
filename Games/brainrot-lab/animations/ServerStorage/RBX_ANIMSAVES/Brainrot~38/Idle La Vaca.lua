-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~38/Idle La Vaca.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle La Vaca", { Priority = Enum.AnimationPriority.Core }, nil, { "1787262444" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.7142748, -0.0036621) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, -0.7134574, -0.0344413) })
					I[6] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396927, 0.3420202, 0, -0.3420202, 0.9396927) })
					I[7] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(1.428566, -0.0000109, 0.0001308, 0.7198277, 0.3451516, -0.6022611, -0.2653301, 0.9385465, 0.2207495, 0.6414421, 0.0008965, 0.7671708) })
					I[8] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, -0.7134574, -0.0344413) })
						I[9] = new("Pose", I[8], "Bone.013", { CFrame = CFrame.new(0, 0.0000436, 0.0000054, 1, 0, 0, 0, 0.9396927, -0.3420201, 0, 0.3420201, 0.9396927) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0.0000027, 0) })
					I[13] = new("Pose", I[12], "Bone.010", { CFrame = CFrame.new(0, -0.0000109, -0.0000436) })
					I[14] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(0, 0, 0.0000109, 1, 0, 0, 0, 0.9396927, 0.3420202, 0, -0.3420202, 0.9396927) })
					I[15] = new("Pose", I[12], "Bone.014", { CFrame = CFrame.new(-1.4285551, 0.0000054, 0.0000436, -0.7198649, -0.3451408, 0.6022227, -0.2586802, 0.938509, 0.2286581, -0.6441109, 0.0088198, -0.7648811) })
					I[16] = new("Pose", I[12], "Bone.012", { CFrame = CFrame.new(0, -0.0000109, -0.0000436) })
						I[17] = new("Pose", I[16], "Bone.013", { CFrame = CFrame.new(0, 0.0000872, 0.0000054, 1, 0, 0, 0, 0.9396927, -0.3420201, 0, 0.3420201, 0.9396927) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, -0.7142748, -0.0036621) })
					I[21] = new("Pose", I[20], "Bone.010", { CFrame = CFrame.new(0, -0.7134574, -0.0344413) })
					I[22] = new("Pose", I[20], "Bone.003", { CFrame = CFrame.new(0, 0, 0.0000218, 1, 0, 0, 0, 0.9396927, 0.3420202, 0, -0.3420202, 0.9396927) })
					I[23] = new("Pose", I[20], "Bone.014", { CFrame = CFrame.new(1.428566, -0.0000109, 0.0001308, 0.7198277, 0.3451516, -0.6022611, -0.2653301, 0.9385465, 0.2207495, 0.6414421, 0.0008965, 0.7671708) })
					I[24] = new("Pose", I[20], "Bone.012", { CFrame = CFrame.new(0, -0.7134574, -0.0344413) })
						I[25] = new("Pose", I[24], "Bone.013", { CFrame = CFrame.new(0, 0.0001308, 0.0000218, 1, 0, 0, 0, 0.9396927, -0.3420201, 0, 0.3420201, 0.9396927) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[27] = new("Pose", I[26], "Mesh", { Weight = 0 })
				I[28] = new("Pose", I[27], "Bone", { Weight = 0 })
					I[29] = new("Pose", I[28], "Bone.003", { CFrame = CFrame.new(0, 0, 0.0000054, 1, 0, 0, 0, 1.0000001, -0.0000103, 0, 0.0000103, 1.0000001) })
					I[30] = new("Pose", I[28], "Bone.014", { CFrame = CFrame.new(0.0000163, 0.0000054, 0.0000436, -0.7659913, 0.0033295, -0.6428423, -0.0033295, 0.9999527, 0.0091465, 0.6428423, 0.0091465, -0.7659439) })
					I[31] = new("Pose", I[28], "Bone.012", { Weight = 0 })
						I[32] = new("Pose", I[31], "Bone.013", { CFrame = CFrame.new(0, 0.0000436, 0.0000054, 1, 0, 0, 0, 1.0000001, 0.0000103, 0, -0.0000103, 1.0000001) })
		I[33] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[34] = new("Pose", I[33], "Mesh", { Weight = 0 })
				I[35] = new("Pose", I[34], "Bone", { Weight = 0 })
					I[36] = new("Pose", I[35], "Bone.003", { CFrame = CFrame.new(0, 0, 0.0000163, 1, 0, 0, 0, 1.0000001, -0.0000103, 0, 0.0000103, 1.0000001) })
					I[37] = new("Pose", I[35], "Bone.014", { CFrame = CFrame.new(0.0000163, 0.0000163, 0.0000436, 0.7659252, -0.0033299, 0.642921, 0.0033299, 0.9999937, 0.0012123, -0.642921, 0.0012123, 0.7659315) })
					I[38] = new("Pose", I[35], "Bone.012", { Weight = 0 })
						I[39] = new("Pose", I[38], "Bone.013", { CFrame = CFrame.new(0, 0.0000872, 0.0000163, 1, 0, 0, 0, 1.0000001, 0.0000103, 0, -0.0000103, 1.0000001) })
		I[40] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
