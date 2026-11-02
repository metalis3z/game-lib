-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~19/Walk Cocofanto.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Cocofanto", { Priority = Enum.AnimationPriority.Core }, nil, { "1786652894" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, 0.005517, 0.0869809, -0.005517, 0.9999847, -0.0002404, -0.0869809, -0.0002404, 0.99621) })
					I[5] = new("Pose", I[4], "Bone.010", { CFrame = CFrame.new(0, 0.0000268, -0.0000535, 1, 0, 0, 0, 0.9396928, -0.3420202, 0, 0.3420202, 0.9396928) })
					I[6] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0, 0.0000134, -0.0000535, 1, 0, 0, 0, 0.9396928, 0.3420202, 0, -0.3420202, 0.9396928) })
					I[7] = new("Pose", I[4], "Bone.012", { CFrame = CFrame.new(0, 0.0000134, 0, 1, 0, 0, 0, 0.9396928, -0.3420202, 0, 0.3420202, 0.9396928) })
					I[8] = new("Pose", I[4], "Bone.003", { CFrame = CFrame.new(-0.0003815, -0.0000803, 0.0001071, 0.9847148, -0.1472454, -0.0930345, 0.1547102, 0.9848073, 0.078864, 0.0800087, -0.0920519, 0.9925346) })
					I[9] = new("Pose", I[4], "Bone.014", { CFrame = CFrame.new(0, 0.0000134, -0.0000535, 1, 0, 0, 0, 0.9396927, 0.3420205, 0, -0.3420205, 0.9396927) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961942, -0.0055173, -0.0869855, 0.0055173, 0.9999847, -0.0002404, 0.0869855, -0.0002404, 0.9962096) })
					I[13] = new("Pose", I[12], "Bone.010", { CFrame = CFrame.new(0, 0.0000268, -0.0001071, 1, 0, 0, 0, 0.9396815, 0.3420514, 0, -0.3420514, 0.9396815) })
					I[14] = new("Pose", I[12], "Bone.008", { CFrame = CFrame.new(0, 0.0000268, -0.0001071, 1, 0, 0, 0, 0.9396892, -0.3420298, 0, 0.3420298, 0.9396892) })
					I[15] = new("Pose", I[12], "Bone.012", { CFrame = CFrame.new(0, 0.0000134, 0, 1, 0, 0, 0, 0.9396892, 0.34203, 0, -0.34203, 0.9396892) })
					I[16] = new("Pose", I[12], "Bone.003", { CFrame = CFrame.new(-0.0003781, -0.0001071, 0.0000535, 0.939369, 0.3167548, 0.1313472, -0.3171057, 0.948204, -0.0187955, -0.1304975, -0.023995, 0.9911581) })
					I[17] = new("Pose", I[12], "Bone.014", { CFrame = CFrame.new(0, 0.0000268, -0.0001071, 1, 0, 0, 0, 0.9396892, -0.3420298, 0, 0.3420298, 0.9396892) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "Mesh", { Weight = 0 })
				I[20] = new("Pose", I[19], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9961947, 0.005517, 0.0869809, -0.005517, 0.9999847, -0.0002404, -0.0869809, -0.0002404, 0.99621) })
					I[21] = new("Pose", I[20], "Bone.010", { CFrame = CFrame.new(0, 0.0000268, -0.0000535, 1, 0, 0, 0, 0.9396928, -0.3420202, 0, 0.3420202, 0.9396928) })
					I[22] = new("Pose", I[20], "Bone.008", { CFrame = CFrame.new(0, 0.0000134, -0.0000535, 1, 0, 0, 0, 0.9396928, 0.3420202, 0, -0.3420202, 0.9396928) })
					I[23] = new("Pose", I[20], "Bone.012", { CFrame = CFrame.new(0, 0.0000134, 0, 1, 0, 0, 0, 0.9396928, -0.3420202, 0, 0.3420202, 0.9396928) })
					I[24] = new("Pose", I[20], "Bone.003", { CFrame = CFrame.new(-0.0003815, -0.0000803, 0.0001071, 0.9847148, -0.1472454, -0.0930345, 0.1547102, 0.9848073, 0.078864, 0.0800087, -0.0920519, 0.9925346) })
					I[25] = new("Pose", I[20], "Bone.014", { CFrame = CFrame.new(0, 0.0000134, -0.0000535, 1, 0, 0, 0, 0.9396927, 0.3420205, 0, -0.3420205, 0.9396927) })
		I[26] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
