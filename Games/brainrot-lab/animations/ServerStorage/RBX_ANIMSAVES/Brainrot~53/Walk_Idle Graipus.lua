-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~53/Walk_Idle Graipus.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk/Idle Graipus", { Priority = Enum.AnimationPriority.Core }, nil, { "1787543698" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Cube.077", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0.4000015, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
					I[5] = new("Pose", I[4], "Bone.L", { CFrame = CFrame.new(0.0855694, 0.1807594, 0, 0.9736109, -0.1656734, 0.1569522, 0.1789169, 0.9810551, -0.0742946, -0.1416702, 0.1004154, 0.9848077) })
					I[6] = new("Pose", I[4], "Bone.R", { CFrame = CFrame.new(-0.0959396, 0.1374435, -0.1220856, 0.9736286, 0.1656566, 0.1568604, -0.1788828, 0.9810656, 0.0742404, -0.1415919, -0.1003422, 0.9848265) })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[8] = new("Pose", I[7], "Cube.077", { Weight = 0 })
				I[9] = new("Pose", I[8], "Bone")
					I[10] = new("Pose", I[9], "Bone.L", { CFrame = CFrame.new(0.0000095, -0.0000229, -0.2642517, 0.987592, 0.0058675, -0.1569321, 0.0058675, 0.9972255, 0.0742096, 0.1569321, -0.0742095, 0.9848174) })
					I[11] = new("Pose", I[9], "Bone.R", { CFrame = CFrame.new(-0.0252304, -0.0119419, 0.3190308, 0.9875886, -0.005875, -0.1569522, -0.005875, 0.9972191, -0.0742946, 0.1569522, 0.0742946, 0.9848077) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[13] = new("Pose", I[12], "Cube.077", { Weight = 0 })
				I[14] = new("Pose", I[13], "Bone", { CFrame = CFrame.new(0, 0.4000015, 0, 1, 0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077) })
					I[15] = new("Pose", I[14], "Bone.L", { CFrame = CFrame.new(0.0855694, 0.1807594, 0, 0.9736109, -0.1656734, 0.1569522, 0.1789169, 0.9810551, -0.0742946, -0.1416702, 0.1004154, 0.9848077) })
					I[16] = new("Pose", I[14], "Bone.R", { CFrame = CFrame.new(-0.0959396, 0.1374435, -0.1220856, 0.9736286, 0.1656566, 0.1568604, -0.1788828, 0.9810656, 0.0742404, -0.1415919, -0.1003422, 0.9848265) })
		I[17] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
