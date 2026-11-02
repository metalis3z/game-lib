-- Generated from animations/Workspace/Ignored/w/AnimSaves/CriminalityCrouch.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "CriminalityCrouch", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.0233131, 1.0195371, 1, 0, 0, 0, 0.9933599, -0.1150485, 0, 0.1150485, 0.9933599), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(-1.3808182, 2.272917, 0.0110149, 0.3562247, -0.9344004, 0, 0.9344004, 0.3562247, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.9836168, 2.9648454, 0), EasingDirection = Enum.PoseEasingDirection.Out })
		I[7] = new("Keyframe", I[1], "KF1", { Time = 1 })
	return I[1]
end

return build
