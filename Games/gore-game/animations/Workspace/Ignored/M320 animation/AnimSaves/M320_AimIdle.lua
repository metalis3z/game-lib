-- Generated from animations/Workspace/Ignored/M320 animation/AnimSaves/M320_AimIdle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "M320_AimIdle", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.0912621, -1.0523772, -0.163428, -0.4186269, -0.8285686, 0.3717872, 0.8476765, -0.2096014, 0.4873518, -0.3258773, 0.5191738, 0.7901028) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.0488853, -0.6268052, -0.9157699, 0.8407917, 0.371812, -0.3934782, 0.474432, -0.1560079, 0.8663579, 0.2607366, -0.9151052, -0.3075696) })
							I[7] = new("Pose", I[6], "Tube", { CFrame = CFrame.new(0, 0.0000003, -0.0000001) })
								I[8] = new("Pose", I[7], "Grenade", { CFrame = CFrame.new(-0.0000001, -0.0000001, 0.0000001) })
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.719687, -0.8563473, -0.8397999, -0.2280492, 0.7970187, -0.5592449, -0.9702246, -0.2341574, 0.0619246, -0.0815963, 0.5567149, 0.8266865) })
	return I[1]
end

return build
