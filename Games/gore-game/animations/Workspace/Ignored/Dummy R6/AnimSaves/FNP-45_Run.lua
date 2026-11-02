-- Generated from animations/Workspace/Ignored/Dummy R6/AnimSaves/FNP-45_Run.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "FNP-45_Run")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.5226387, -0.7947645, -0.2345695, -0.8459309, -0.5118752, 0.1496152, 0.5261156, -0.7551591, 0.3910718, -0.0871967, 0.4095346, 0.9081179) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[7] = new("Pose", I[6], "Magazine")
							I[8] = new("Pose", I[6], "Slider")
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3263936, -0.5996572, -0.7243209, -0.3445178, 0.4791104, -0.807317, -0.8104665, -0.5857824, -0.0017766, -0.4737632, 0.6536913, 0.5901153) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.5226387, -0.7947645, -0.2345695, -0.8459309, -0.5118752, 0.1496152, 0.5261156, -0.7551591, 0.3910718, -0.0871967, 0.4095346, 0.9081179) })
						I[14] = new("Pose", I[13], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[15] = new("Pose", I[14], "Magazine")
							I[16] = new("Pose", I[14], "Slider")
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.3263936, -0.5996572, -0.7243209, -0.3445178, 0.4791104, -0.807317, -0.8104665, -0.5857824, -0.0017766, -0.4737632, 0.6536913, 0.5901153) })
	return I[1]
end

return build
