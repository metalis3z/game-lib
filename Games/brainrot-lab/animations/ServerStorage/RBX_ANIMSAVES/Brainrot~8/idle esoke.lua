-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~8/idle esoke.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "idle esoke", { Priority = Enum.AnimationPriority.Core }, nil, { "1786598249" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9993412, 0.0339588, 0.0128109, -0.0358628, 0.9781904, 0.204591, -0.0055838, -0.2049157, 0.9787638) })
					I[6] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.7660444, 0.6427877, 0, -0.6427877, 0.7660444, 0, 0, 0, 1) })
						I[7] = new("Pose", I[6], "Bone.004", { CFrame = CFrame.new(-1.0726662, -0.2370801, -1.7543859, 0.6532536, 0.5602595, -0.5092831, 0.3866205, 0.3315025, 0.8605991, 0.6509875, -0.7590889, -0.0000526) })
					I[8] = new("Pose", I[4], "Bone.006", { CFrame = CFrame.new(-0.0317758, 0.1725314, 0, 0.9702979, -0.2419131, 0, 0.2419131, 0.9702979, 0, 0, 0, 1) })
						I[9] = new("Pose", I[8], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9975641, 0.000006, 0.0697565, -0.000006, 1, -0.0000001, -0.0697565, -0.0000003, 0.9975641) })
					I[10] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.7660444, -0.6427877, 0, 0.6427877, 0.7660444, 0, 0, 0, 1) })
						I[11] = new("Pose", I[10], "Bone.002", { CFrame = CFrame.new(0.6658554, -0.5710401, -1.7543859, 0.6347986, -0.4279095, 0.6433697, -0.3951651, 0.5357283, 0.7462171, -0.6639846, -0.7279348, 0.1709846) })
					I[12] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0.0582913, -0.345993, 0, 0.9781477, -0.2079117, 0, 0.2079117, 0.9781477, 0, 0, 0, 1) })
						I[13] = new("Pose", I[12], "Bone.009", { CFrame = CFrame.new(0, 0, 0.0000067, 1.0000001, 0, 0.0000073, 0, 1, 0, -0.0000073, 0, 1.0000001) })
					I[14] = new("Pose", I[4], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9396927, -0.3420202, 0, 0.3420202, 0.9396927, 0, 0, 0, 1) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.7 })
			I[16] = new("Pose", I[15], "Mesh", { Weight = 0 })
				I[17] = new("Pose", I[16], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848017, -0.1736824, 0, 0.1736824, 0.9848017, 0, 0, 0, 1) })
					I[18] = new("Pose", I[17], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9934775, 0.1096392, 0.0313357, -0.0989906, 0.9656512, -0.2402473, -0.0565999, 0.2355783, 0.9702059) })
					I[19] = new("Pose", I[17], "Bone.003", { Weight = 0 })
						I[20] = new("Pose", I[19], "Bone.004", { CFrame = CFrame.new(-1.0726662, -0.2370868, -1.7543859, 0.7329019, 0.3982688, -0.5515767, 0.2465331, 0.6001686, 0.7609332, 0.634095, -0.6936713, 0.3416783) })
					I[21] = new("Pose", I[17], "Bone.006", { CFrame = CFrame.new(-0.0583113, -0.3459997, 0) })
						I[22] = new("Pose", I[21], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.0000149, 0.1736482, -0.000015, 1, -0.0000011, -0.1736482, -0.0000015, 0.9848077) })
					I[23] = new("Pose", I[17], "Bone.008", { CFrame = CFrame.new(0.1536252, 0.1716212, 0, 0.9999999, 0, 0, 0, 0.9999999, 0, 0, 0, 1) })
						I[24] = new("Pose", I[23], "Bone.009", { CFrame = CFrame.new(0.1722302, 0, -0.0334623, 0.984809, 0.0000043, 0.173641, -0.0000043, 1, -0.0000004, -0.173641, -0.0000004, 0.984809) })
					I[25] = new("Pose", I[17], "Bone.001", { Weight = 0 })
						I[26] = new("Pose", I[25], "Bone.002", { CFrame = CFrame.new(0.9370704, -0.3484224, -1.7543859, 0.4872689, -0.5947407, 0.639416, -0.5671757, 0.3412127, 0.7495905, -0.6639888, -0.7279133, -0.1710601) })
					I[27] = new("Pose", I[17], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9396891, 0.3420298, 0, -0.3420298, 0.9396891, 0, 0, 0, 1) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 1.4 })
			I[29] = new("Pose", I[28], "Mesh", { Weight = 0 })
				I[30] = new("Pose", I[29], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[31] = new("Pose", I[30], "Bone.010", { CFrame = CFrame.new(0, 0, 0, 0.9993412, 0.0339588, 0.0128109, -0.0358628, 0.9781904, 0.204591, -0.0055838, -0.2049157, 0.9787638) })
					I[32] = new("Pose", I[30], "Bone.003", { CFrame = CFrame.new(0, 0, 0, 0.7660444, 0.6427877, 0, -0.6427877, 0.7660444, 0, 0, 0, 1) })
						I[33] = new("Pose", I[32], "Bone.004", { CFrame = CFrame.new(-1.0726662, -0.2370801, -1.7543859, 0.6532536, 0.5602595, -0.5092831, 0.3866205, 0.3315025, 0.8605991, 0.6509875, -0.7590889, -0.0000526) })
					I[34] = new("Pose", I[30], "Bone.006", { CFrame = CFrame.new(-0.0317758, 0.1725314, 0, 0.9702979, -0.2419131, 0, 0.2419131, 0.9702979, 0, 0, 0, 1) })
						I[35] = new("Pose", I[34], "Bone.007", { CFrame = CFrame.new(0, 0, 0, 0.9975641, 0.000006, 0.0697565, -0.000006, 1, -0.0000001, -0.0697565, -0.0000003, 0.9975641) })
					I[36] = new("Pose", I[30], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.7660444, -0.6427877, 0, 0.6427877, 0.7660444, 0, 0, 0, 1) })
						I[37] = new("Pose", I[36], "Bone.002", { CFrame = CFrame.new(0.6658554, -0.5710401, -1.7543859, 0.6347986, -0.4279095, 0.6433697, -0.3951651, 0.5357283, 0.7462171, -0.6639846, -0.7279348, 0.1709846) })
					I[38] = new("Pose", I[30], "Bone.008", { CFrame = CFrame.new(0.0582913, -0.345993, 0, 0.9781477, -0.2079117, 0, 0.2079117, 0.9781477, 0, 0, 0, 1) })
						I[39] = new("Pose", I[38], "Bone.009", { CFrame = CFrame.new(0, 0, 0.0000067, 1.0000001, 0, 0.0000073, 0, 1, 0, -0.0000073, 0, 1.0000001) })
					I[40] = new("Pose", I[30], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9396927, -0.3420202, 0, 0.3420202, 0.9396927, 0, 0, 0, 1) })
		I[41] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
