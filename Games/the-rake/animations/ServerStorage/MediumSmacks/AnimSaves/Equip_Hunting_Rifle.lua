-- Generated from animations/ServerStorage/MediumSmacks/AnimSaves/Equip_Hunting_Rifle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Equip_Hunting_Rifle", { Loop = false }, nil, { "1617618126" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[5] = new("Pose", I[4], "Right Arm", { EasingStyle = Enum.PoseEasingStyle.Cubic })
						I[6] = new("Pose", I[5], "Attach", { Weight = 0 })
							I[7] = new("Pose", I[6], "Mag", { EasingStyle = Enum.PoseEasingStyle.Cubic })
							I[8] = new("Pose", I[6], "Base", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[9] = new("Pose", I[4], "Head", { EasingStyle = Enum.PoseEasingStyle.Cubic })
					I[10] = new("Pose", I[4], "Left Arm", { EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 0.6666667 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.7959675, 0.6053392, 0, -0.6053392, 0.7959675, 0, 0, 0, 1) })
					I[14] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(0.477625, -0.0044535, -0.4922177, 0.0239596, -0.7612028, 0.6480714, 0.9996129, 0.0090701, -0.0263028, 0.0141437, 0.6484507, 0.7611254) })
						I[15] = new("Pose", I[14], "Attach", { Weight = 0 })
							I[16] = new("Pose", I[15], "Mag")
							I[17] = new("Pose", I[15], "Base", { CFrame = CFrame.new(-0.0000057, -0.1897943, -0.0000992, 1.0000006, 0, 0, 0, 1.0000005, -0.0000001, 0, -0.0000001, 1.0000002) })
					I[18] = new("Pose", I[13], "Head", { CFrame = CFrame.new(0, 0, 0, 0.7949504, -0.6066747, 0, 0.6066747, 0.7949504, 0, 0, 0, 1) })
					I[19] = new("Pose", I[13], "Left Arm", { CFrame = CFrame.new(-1.2952459, -0.2657436, -0.6223054, -0.2307129, 0.9670577, -0.1075682, -0.9685596, -0.2388225, -0.0696858, -0.0930799, 0.0881087, 0.9917525) })
	return I[1]
end

return build
