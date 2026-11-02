-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Petra/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1763163506" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "RootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "root", { Weight = 0 })
					I[5] = new("Pose", I[4], "spine0", { Weight = 0 })
						I[6] = new("Pose", I[5], "spine1", { Weight = 0 })
							I[7] = new("Pose", I[6], "spine2", { Weight = 0 })
								I[8] = new("Pose", I[7], "spine3", { Weight = 0 })
									I[9] = new("Pose", I[8], "spine4", { Weight = 0 })
										I[10] = new("Pose", I[9], "shoulder_R", { Weight = 0 })
											I[11] = new("Pose", I[10], "arm_R", { CFrame = CFrame.new(0, 0, -0.0000159, 1, 0.0000002, 0.0000004, 0.0000003, 0.4691759, -0.8831047, -0.0000004, 0.8831047, 0.4691759) })
												I[12] = new("Pose", I[11], "elbowFront_R", { CFrame = CFrame.new(0, 0, -0.0000318, 1, 0.0000002, -0.0000004, 0.0000002, 0.6222194, 0.7828429, 0.0000004, -0.7828429, 0.6222194) })
	return I[1]
end

return build
