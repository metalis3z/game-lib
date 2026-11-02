-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1787259690" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(-0.0000163, -0.0000109, 0.0000436, 0.988803, -0.1372666, -0.0585399, 0.1452778, 0.9751309, 0.1673758, 0.034109, -0.1740063, 0.9841537) })
					I[5] = new("Pose", I[4], "Bone.009", { CFrame = CFrame.new(-0.0906645, 0.3306035, 0.007019, 0.9848086, -0.1715949, 0.0266023, 0.1736062, 0.9697374, -0.1716708, 0.0036606, 0.1736813, 0.9847956) })
					I[6] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0.0348418, -0.4270499, -0.0087193, 0.9848093, -0.1736022, -0.0035929, 0.1736034, 0.9848158, 0.0000223, 0.0035345, -0.0006458, 0.9999937) })
					I[7] = new("Pose", I[4], "Bone.003")
						I[8] = new("Pose", I[7], "Bone.004")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.375 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { CFrame = CFrame.new(0, 2.7490888, -5.9840612, 1, 0, 0, 0, 1.0000001, 0, 0, 0, 1.0000001) })
					I[12] = new("Pose", I[11], "Bone.009", { CFrame = CFrame.new(-0.1162175, 0.0174114, 0.0006539, 0.9999716, -0.004546, 0.0060257, 0.000266, 0.8190289, 0.5737529, -0.0075435, -0.5737349, 0.8190066) })
					I[13] = new("Pose", I[11], "Bone.003", { CFrame = CFrame.new(0, -0.0000109, 0, 0.9508229, 0.3088505, -0.0233953, -0.3088505, 0.9396931, -0.1469327, -0.0233956, 0.1469328, 0.9888701) })
						I[14] = new("Pose", I[13], "Bone.004", { CFrame = CFrame.new(0.0000436, -0.0000436, -0.0000109, 0.8660255, 0.5000002, 0.0000002, -0.5000005, 0.866026, 0.0000002, 0.0000001, 0.0000002, 1.0000006) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.75 })
			I[16] = new("Pose", I[15], "Mesh", { Weight = 0 })
				I[17] = new("Pose", I[16], "Bone", { CFrame = CFrame.new(0.0000054, 1.352441, -6.2845721, 0.9966899, 0.016684, 0.0795661, -0.0536752, 0.8701175, 0.489913, -0.0610581, -0.492562, 0.8681327) })
					I[18] = new("Pose", I[17], "Bone.009", { CFrame = CFrame.new(-0.1417542, -0.2957807, -0.0057547, 0.98481, 0.1643343, -0.0560625, -0.1735994, 0.9254321, -0.3368066, -0.0034668, 0.3414225, 0.9399033) })
					I[19] = new("Pose", I[17], "Bone.008", { CFrame = CFrame.new(0.1171357, 0.4270063, 0.0090245, 0.984808, 0.1736115, 0.0035346, -0.1736103, 0.9848146, -0.0006459, -0.0035931, 0.0000223, 0.9999937) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[21] = new("Pose", I[20], "Mesh", { Weight = 0 })
				I[22] = new("Pose", I[21], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, -0.1697616, -0.0365335, 0.1697616, 0.9854802, -0.0031247, 0.0365335, -0.0031247, 0.9993276) })
					I[23] = new("Pose", I[22], "Bone.009", { CFrame = CFrame.new(-0.0906645, 0.3306035, 0.007019, 0.9848068, -0.1736169, -0.0035992, 0.1736156, 0.9848137, -0.0006698, 0.0036608, 0.0000346, 0.9999934) })
					I[24] = new("Pose", I[22], "Bone.008", { CFrame = CFrame.new(0.0348418, -0.4270499, -0.0087193, 0.9848093, -0.1736022, -0.0035929, 0.1736034, 0.9848158, 0.0000223, 0.0035345, -0.0006458, 0.9999937) })
		I[25] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
