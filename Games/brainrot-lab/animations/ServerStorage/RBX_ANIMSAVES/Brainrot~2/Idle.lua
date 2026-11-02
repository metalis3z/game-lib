-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~2/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", nil, nil, { "1786565990" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.976902, -0.2136882, 0, 0.2136882, 0.976902, 0, 0, 0, 1) })
					I[6] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9783239, 0.2070805, 0, -0.2070805, 0.9783239, 0, 0, 0, 1) })
					I[7] = new("Pose", I[4], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9911047, -0.1330847, 0, 0.1330847, 0.9911047) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.4333333 })
			I[9] = new("Pose", I[8], "Mesh", { Weight = 0 })
				I[10] = new("Pose", I[9], "Bone", { Weight = 0 })
					I[11] = new("Pose", I[10], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.9954933, 0.0948321, 0, -0.0948321, 0.9954933, 0, 0, 0, 1) })
					I[12] = new("Pose", I[10], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9994352, -0.0336079, 0, 0.0336079, 0.9994352, 0, 0, 0, 1) })
					I[13] = new("Pose", I[10], "Bone.001", { CFrame = CFrame.new(0, 0.0000033, 0, 1, 0, 0, 0, 0.9957088, 0.0925426, 0, -0.0925426, 0.9957088) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[15] = new("Pose", I[14], "Mesh", { Weight = 0 })
				I[16] = new("Pose", I[15], "Bone", { Weight = 0 })
					I[17] = new("Pose", I[16], "Bone.004", { CFrame = CFrame.new(0, 0, 0, 0.976902, -0.2136882, 0, 0.2136882, 0.976902, 0, 0, 0, 1) })
					I[18] = new("Pose", I[16], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9783239, 0.2070805, 0, -0.2070805, 0.9783239, 0, 0, 0, 1) })
					I[19] = new("Pose", I[16], "Bone.001", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9911047, -0.1330847, 0, 0.1330847, 0.9911047) })
		I[20] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
