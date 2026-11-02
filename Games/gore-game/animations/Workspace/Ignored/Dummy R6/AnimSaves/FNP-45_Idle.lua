-- Generated from animations/Workspace/Ignored/Dummy R6/AnimSaves/FNP-45_Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "FNP-45_Idle", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.167503, -0.4110038, -0.278338, -0.2160022, -0.8807123, 0.4215316, 0.9685844, -0.1387866, 0.2063557, -0.1232371, 0.4528622, 0.8830223), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[7] = new("Pose", I[6], "Magazine", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[8] = new("Pose", I[6], "Slider", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3302573, -0.5996149, -0.7238461, 0.1019129, 0.6147514, -0.7821089, -0.8293875, -0.3816135, -0.4080285, -0.5492996, 0.6902547, 0.4709759), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.1782332, -0.4594444, -0.2721699, -0.2160022, -0.8807123, 0.4215316, 0.9685844, -0.1387866, 0.2063557, -0.1232371, 0.4528622, 0.8830223), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[14] = new("Pose", I[13], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[15] = new("Pose", I[14], "Magazine", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[16] = new("Pose", I[14], "Slider", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.3619878, -0.6615019, -0.7279109, 0.0914161, 0.6027021, -0.7927126, -0.8224918, -0.4030668, -0.4013033, -0.5613824, 0.6886852, 0.4588708), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 4 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { Weight = 0 })
					I[21] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.167503, -0.4110038, -0.278338, -0.2160022, -0.8807123, 0.4215316, 0.9685844, -0.1387866, 0.2063557, -0.1232371, 0.4528622, 0.8830223), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[22] = new("Pose", I[21], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[23] = new("Pose", I[22], "Magazine", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[24] = new("Pose", I[22], "Slider", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[25] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.3302573, -0.5996149, -0.7238461, 0.1019129, 0.6147514, -0.7821089, -0.8293875, -0.3816135, -0.4080285, -0.5492996, 0.6902547, 0.4709759), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
	return I[1]
end

return build
