-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig~3/Untitled Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Untitled Animation Clip", { Loop = false, Priority = Enum.AnimationPriority.Idle }, nil, { "1713639446" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { Weight = 0 })
						I[6] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, 0, -0.0000305, 1.000001, 0, 0, 0, 0, -1.0000005, 0, 1.0000005, 0) })
		I[7] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
