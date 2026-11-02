-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~23/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786668808" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.997564, -0.0697565, 0, 0.0697565, 0.997564) })
					I[5] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9902691, -0.1391652, 0, 0.1391652, 0.9902691) })
						I[6] = new("Pose", I[5], "Bone.003", { CFrame = CFrame.new(0, 0.0000436, -0.0000054, 1, 0, 0, 0, 0.8660257, 0.5000002, 0, -0.5000002, 0.8660257) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848076, 0, 0, 0, 0.9999999) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[9] = new("Pose", I[8], "Mesh", { Weight = 0 })
				I[10] = new("Pose", I[9], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0.000004, 0, -0.000004, 1) })
					I[11] = new("Pose", I[10], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0.0000079, 0, -0.0000079, 1) })
						I[12] = new("Pose", I[11], "Bone.003", { CFrame = CFrame.new(0, 0.0000872, -0.0000109, 1, 0, 0, 0, 0.9998478, -0.017457, 0, 0.017457, 0.9998478) })
					I[13] = new("Pose", I[10], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9945183, 0.104563, 0, -0.104563, 0.9945182, 0, 0, 0, 0.9999999) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.997564, -0.0697565, 0, 0.0697565, 0.997564) })
					I[17] = new("Pose", I[16], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9902691, -0.1391652, 0, 0.1391652, 0.9902691) })
						I[18] = new("Pose", I[17], "Bone.003", { CFrame = CFrame.new(0, 0.0000436, -0.0000054, 1, 0, 0, 0, 0.8660257, 0.5000002, 0, -0.5000002, 0.8660257) })
					I[19] = new("Pose", I[16], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 0.9848077, -0.1736482, 0, 0.1736482, 0.9848076, 0, 0, 0, 0.9999999) })
		I[20] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
