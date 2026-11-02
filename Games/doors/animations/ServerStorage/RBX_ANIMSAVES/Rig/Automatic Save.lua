-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1710409808" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { Weight = 0 })
						I[6] = new("Pose", I[5], "RightUpperArm", { Weight = 0 })
							I[7] = new("Pose", I[6], "RightLowerArm", { Weight = 0 })
								I[8] = new("Pose", I[7], "RightHand")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.2166667 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "LowerTorso", { Weight = 0 })
					I[12] = new("Pose", I[11], "UpperTorso", { Weight = 0 })
						I[13] = new("Pose", I[12], "RightUpperArm", { Weight = 0 })
							I[14] = new("Pose", I[13], "RightLowerArm", { Weight = 0 })
								I[15] = new("Pose", I[14], "RightHand", { CFrame = CFrame.new(0, 0, 0, 0.9102216, -0.4141214, 0, 0.4141214, 0.9102216, 0, 0, 0, 1) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 12.7166662 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "LowerTorso", { Weight = 0 })
					I[19] = new("Pose", I[18], "UpperTorso", { Weight = 0 })
						I[20] = new("Pose", I[19], "RightUpperArm", { Weight = 0 })
							I[21] = new("Pose", I[20], "RightLowerArm", { Weight = 0 })
								I[22] = new("Pose", I[21], "RightHand", { CFrame = CFrame.new(0, 0.0000019, 0, 0.9102216, -0.4141214, 0.0000001, 0.4141214, 0.9102216, 0, -0.0000001, 0.0000001, 1) })
		I[23] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
