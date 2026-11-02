-- Generated from animations/StarterGui/ScreenGui/main/BoothModels/starclonebooth/meatballcows/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
				I[4] = new("Pose", I[3], "LowerTorso", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "UpperTorso", { EasingDirection = Enum.PoseEasingDirection.Out })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0, -0.0000001, 0.0000001, -0.1119234, 0.9918891, 0.0602431, -0.6975029, -0.0352358, -0.7157152, -0.7077874, -0.122125, 0.6957891), EasingDirection = Enum.PoseEasingDirection.Out })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.7567353, -0.6537214, 0, 0.6537214, 0.7567353), EasingDirection = Enum.PoseEasingDirection.Out })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0, 0, 0, 0.994052, -0.10001, 0.0431117, 0.1089064, 0.9128488, -0.3935053, 0, 0.3958599, 0.918311), EasingDirection = Enum.PoseEasingDirection.Out })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, 0, -0.0000002, 0.9995823, -0.0011561, -0.0288784, 0.0126946, -0.8800885, 0.47464, -0.0259642, -0.4748083, -0.8797062), EasingDirection = Enum.PoseEasingDirection.Out })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(0, 0, -0.0000001, -0.9700671, -0.2428371, 0, -0.1690186, 0.6751826, -0.7180258, 0.1743633, -0.6965333, -0.6960164), EasingDirection = Enum.PoseEasingDirection.Out })
								I[11] = new("Pose", I[10], "RightHand", { EasingDirection = Enum.PoseEasingDirection.Out })
						I[12] = new("Pose", I[5], "Head", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[13] = new("Pose", I[4], "LeftUpperLeg", { EasingDirection = Enum.PoseEasingDirection.Out })
						I[14] = new("Pose", I[13], "LeftLowerLeg", { EasingDirection = Enum.PoseEasingDirection.Out })
							I[15] = new("Pose", I[14], "LeftFoot", { EasingDirection = Enum.PoseEasingDirection.Out })
					I[16] = new("Pose", I[4], "RightUpperLeg", { EasingDirection = Enum.PoseEasingDirection.Out })
						I[17] = new("Pose", I[16], "RightLowerLeg", { EasingDirection = Enum.PoseEasingDirection.Out })
							I[18] = new("Pose", I[17], "RightFoot", { EasingDirection = Enum.PoseEasingDirection.Out })
		I[19] = new("Keyframe", I[1], "KF2", { Time = 2 })
	return I[1]
end

return build
