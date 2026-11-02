-- Generated from animations/Workspace/Games/Tables/TournamentHoldem/TournamentHoldem/Functional/Dealer/AnimSaves/Idle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Idle", { Priority = Enum.AnimationPriority.Core }, nil, { "1669048070" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.0000019, -0.2456524, -0.0000019, 0.8779197, -0.3516471, -0.3249635, 0, 0.678693, -0.7344221, 0.4788079, 0.6447636, 0.595838) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 0.9999999, -0.0000001, 0.0000001, -0.0000001, 0.8291504, -0.5590258, 0.0000001, 0.5590254, 0.8291504) })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, -0.2456541, -0.000001, 0.8779914, 0.3471516, 0.3295706, 0, 0.6885041, -0.7252324, -0.4786763, 0.6367478, 0.6045007) })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(0.0000019, -0.0000005, 0.0000005, 1.0000001, 0, 0.0000001, 0, 0.7998351, -0.6002201, 0, 0.6002201, 0.7998347) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "LowerTorso", { Weight = 0 })
					I[13] = new("Pose", I[12], "UpperTorso", { CFrame = CFrame.new(0, -0.0289674, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "LowerTorso", { Weight = 0 })
					I[17] = new("Pose", I[16], "UpperTorso")
		I[18] = new("AnimationRigData", I[1], "DealerAnimationRigData")
	return I[1]
end

return build
