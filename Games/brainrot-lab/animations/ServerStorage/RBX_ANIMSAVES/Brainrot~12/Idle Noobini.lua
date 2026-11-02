-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~12/Idle Noobini.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle Noobini", { Priority = Enum.AnimationPriority.Core }, nil, { "1786751727" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.001", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, -0.1477242, 0.0260315, 1, 0, 0, 0, 0.9848138, 0.173614, 0, -0.173614, 0.9848138) })
					I[5] = new("Pose", I[4], "Bone.L", { CFrame = CFrame.new(0, 0, 0, 0.9396927, -0.3420201, 0, 0.3420201, 0.9396927, 0, 0, 0, 1.0000002) })
					I[6] = new("Pose", I[4], "Bone.R", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3420201, 0, -0.3420201, 0.9396927, 0, 0, 0, 1.0000002) })
					I[7] = new("Pose", I[4], "Bone.1.L", { CFrame = CFrame.new(0, -0.2461929, -0.0434875, 1, 0, 0, 0, 0.9848439, -0.1734433, 0, 0.1734433, 0.9848439) })
					I[8] = new("Pose", I[4], "Bone.1.R", { CFrame = CFrame.new(0, -0.2461929, -0.0434875, 1, 0, 0, 0, 0.9848439, -0.1734433, 0, 0.1734433, 0.9848439) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[10] = new("Pose", I[9], "Cube.001", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { CFrame = CFrame.new(0, 0.1499996, 0) })
					I[12] = new("Pose", I[11], "Bone.L", { CFrame = CFrame.new(0, 0, 0, 1, 0.0000331, 0, -0.0000331, 1, 0, 0, 0, 1.0000002) })
					I[13] = new("Pose", I[11], "Bone.R", { CFrame = CFrame.new(0, 0, 0, 1.0000001, -0.0000103, 0, 0.0000103, 1.0000001, 0, 0, 0, 1.0000002) })
					I[14] = new("Pose", I[11], "Bone.1.L", { CFrame = CFrame.new(0, -0.0000114, 0) })
					I[15] = new("Pose", I[11], "Bone.1.R", { CFrame = CFrame.new(0, -0.0000114, 0) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[17] = new("Pose", I[16], "Cube.001", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { CFrame = CFrame.new(0, -0.1477242, 0.0260315, 1, 0, 0, 0, 0.9848138, 0.173614, 0, -0.173614, 0.9848138) })
					I[19] = new("Pose", I[18], "Bone.L", { CFrame = CFrame.new(0, 0, 0, 0.9396927, -0.3420201, 0, 0.3420201, 0.9396927, 0, 0, 0, 1.0000002) })
					I[20] = new("Pose", I[18], "Bone.R", { CFrame = CFrame.new(0, 0, 0, 0.9396927, 0.3420201, 0, -0.3420201, 0.9396927, 0, 0, 0, 1.0000002) })
					I[21] = new("Pose", I[18], "Bone.1.L", { CFrame = CFrame.new(0, -0.2461929, -0.0434875, 1, 0, 0, 0, 0.9848439, -0.1734433, 0, 0.1734433, 0.9848439) })
					I[22] = new("Pose", I[18], "Bone.1.R", { CFrame = CFrame.new(0, -0.2461929, -0.0434875, 1, 0, 0, 0, 0.9848439, -0.1734433, 0, 0.1734433, 0.9848439) })
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
