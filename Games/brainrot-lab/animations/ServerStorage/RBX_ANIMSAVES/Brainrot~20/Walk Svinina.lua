-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~20/Walk Svinina.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Svinina", { Priority = Enum.AnimationPriority.Core }, nil, { "1786653865" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.001", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, 0.0031836, 0.0870976, -0.0031836, 0.9999949, -0.0001389, -0.0870976, -0.0001389, 0.9961998) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, -0.0000054, -0.0000436, 1, 0, 0, 0, 0.8191522, -0.5735765, 0, 0.5735765, 0.8191522) })
					I[6] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, -0.0000109, 0, 1, 0, 0, 0, 0.8191496, 0.5735801, 0, -0.5735801, 0.8191496) })
					I[7] = new("Pose", I[4], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8191522, -0.5735765, 0, 0.5735765, 0.8191522) })
					I[8] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(-0.0000054, 0.0000054, -0.0000872, 1, -0.0000037, -0.0000027, 0.0000046, 0.8191548, 0.5735729, 0, -0.5735729, 0.8191547) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[10] = new("Pose", I[9], "Cube.001", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961942, -0.0031838, -0.0871021, 0.0031838, 0.9999949, -0.0001389, 0.0871021, -0.0001389, 0.9961994) })
					I[12] = new("Pose", I[11], "Bone.010", { CFrame = CFrame.new(0, -0.0000054, -0.0000872, 1, 0, 0, 0, 0.8191531, 0.5735751, 0, -0.5735751, 0.8191531) })
					I[13] = new("Pose", I[11], "Bone.012", { CFrame = CFrame.new(0, -0.0000109, 0, 1, 0, 0, 0, 0.8191496, -0.5735802, 0, 0.5735802, 0.8191496) })
					I[14] = new("Pose", I[11], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.7071081, 0.7071056, 0, -0.7071056, 0.7071081) })
					I[15] = new("Pose", I[11], "Bone.014", { CFrame = CFrame.new(0.0000027, 0.0000054, -0.0001308, 0.9999999, 0.000003, -0.0000021, -0.0000037, 0.8191523, -0.5735763, 0, 0.5735763, 0.8191524) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.6666667 })
			I[17] = new("Pose", I[16], "Cube.001", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, 0.0031836, 0.0870967, -0.0031836, 0.9999949, -0.0001389, -0.0870967, -0.0001389, 0.9961998) })
					I[19] = new("Pose", I[18], "Bone.010", { CFrame = CFrame.new(0, -0.0000054, -0.0000436, 1, 0, 0, 0, 0.8191522, -0.5735765, 0, 0.5735765, 0.8191522) })
					I[20] = new("Pose", I[18], "Bone.012", { CFrame = CFrame.new(0, -0.0000109, 0, 1, 0, 0, 0, 0.8191496, 0.5735801, 0, -0.5735801, 0.8191496) })
					I[21] = new("Pose", I[18], "Bone.016", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8191522, -0.5735765, 0, 0.5735765, 0.8191522) })
					I[22] = new("Pose", I[18], "Bone.014", { CFrame = CFrame.new(0.0001144, 0.000109, -0.0001744, 0.9999999, -0.0001156, 0.0000106, 0.0000887, 0.8191528, 0.5735754, -0.000075, -0.5735755, 0.8191529) })
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
