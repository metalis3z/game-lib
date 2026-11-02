-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~30/Walk bananito Delfinito.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk bananito Delfinito", { Priority = Enum.AnimationPriority.Core }, nil, { "1786747284" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.0190735, 0, 0.9998836, 0.002651, 0.0150232, -0.0026466, 0.9999963, -0.0003169, -0.015024, 0.0002771, 0.9998869) })
					I[5] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(-0.0025431, 0.0050863, 0, 0.9999319, -0.010429, -0.0052324, 0.0080091, 0.9395959, -0.3421923, 0.008485, 0.3421271, 0.9396154) })
						I[6] = new("Pose", I[5], "Bone.002", { CFrame = CFrame.new(0.0012716, 0.0101725, 0, 0.9999008, -0.0077682, -0.0117541, 0.0113165, 0.9397866, 0.3415744, 0.0083929, -0.3416737, 0.939781) })
							I[7] = new("Pose", I[6], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9397011, 0.3411937, -0.023412, -0.3412902, 0.939958, -0.0001357, 0.0219599, 0.008118, 0.999726) })
					I[8] = new("Pose", I[4], "Bone.003", { Weight = 0 })
						I[9] = new("Pose", I[8], "Bone.004")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5666667 })
			I[11] = new("Pose", I[10], "Mesh", { Weight = 0 })
				I[12] = new("Pose", I[11], "Bone", { Weight = 0 })
					I[13] = new("Pose", I[12], "Bone.001", { CFrame = CFrame.new(-0.0025431, 0.0050863, 0, 0.9999348, -0.0068097, -0.0091606, 0.0078431, 0.9929857, 0.1179743, 0.008293, -0.1180387, 0.9929743) })
						I[14] = new("Pose", I[13], "Bone.002", { CFrame = CFrame.new(0.0012716, 0.0203451, 0.0025431, 0.9999008, -0.0077658, -0.0117526, 0.0113137, 0.9397864, 0.341575, 0.0083923, -0.341674, 0.9397809) })
							I[15] = new("Pose", I[14], "Bone.005", { CFrame = CFrame.new(0.0025431, 0, 0, 0.9970568, 0.0028183, -0.0766144, -0.0043147, 0.9998029, -0.0193732, 0.0765447, 0.0196468, 0.9968728) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1.1666666 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, -0.0190735, 0, 0.9998836, 0.002651, 0.0150232, -0.0026466, 0.9999963, -0.0003169, -0.015024, 0.0002771, 0.9998869) })
					I[19] = new("Pose", I[18], "Bone.001", { CFrame = CFrame.new(-0.0025431, 0.0050863, 0, 0.9999319, -0.010429, -0.0052324, 0.0080091, 0.9395959, -0.3421923, 0.008485, 0.3421271, 0.9396154) })
						I[20] = new("Pose", I[19], "Bone.002", { CFrame = CFrame.new(0.0012716, 0.0101725, 0, 0.9999008, -0.0077682, -0.0117541, 0.0113165, 0.9397866, 0.3415744, 0.0083929, -0.3416737, 0.939781) })
							I[21] = new("Pose", I[20], "Bone.005", { CFrame = CFrame.new(0, 0, 0, 0.9397011, 0.3411937, -0.023412, -0.3412902, 0.939958, -0.0001357, 0.0219599, 0.008118, 0.999726) })
					I[22] = new("Pose", I[18], "Bone.003", { Weight = 0 })
						I[23] = new("Pose", I[22], "Bone.004")
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[25] = new("Pose", I[24], "Mesh", { Weight = 0 })
				I[26] = new("Pose", I[25], "Bone", { CFrame = CFrame.new(6.2688193, 142.6188202, -396.6674805, 0.9998654, 0.0122074, 0.010954, -0.011266, 0.9965497, -0.08223, -0.01192, 0.0820956, 0.9965531) })
					I[27] = new("Pose", I[26], "Bone.003", { Weight = 0 })
						I[28] = new("Pose", I[27], "Bone.004", { CFrame = CFrame.new(0.0025431, 0, 0, 0.9398264, -0.3406475, 0.0261868, 0.3410352, 0.939974, -0.0120033, -0.020526, 0.0202116, 0.9995851) })
		I[29] = new("Keyframe", I[1], "Keyframe", { Time = 0.8 })
			I[30] = new("Pose", I[29], "Mesh", { Weight = 0 })
				I[31] = new("Pose", I[30], "Bone", { CFrame = CFrame.new(0.3598531, 8.3026886, -850.0061035, 0.9997283, 0.0226794, 0.0053722, -0.0213889, 0.98432, -0.1750901, -0.0092589, 0.1749275, 0.9845377) })
		I[32] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
