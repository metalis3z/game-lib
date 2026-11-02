-- Generated from animations/StarterGui/ScreenGui/main/BoothModels/haz3mnsbooth/Shoulder Pet Template/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0, 0, 0, 0.7279921, -0.6855855, 0, 0.6855855, 0.7279921, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.5665017, 0.8240606, 0, -0.8240606, 0.5665017, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
		I[7] = new("Keyframe", I[1], "KF2", { Time = 2 })
	return I[1]
end

return build
