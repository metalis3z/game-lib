-- Generated from animations/ReplicatedStorage/Parts/Level_0/Part_Spawn/Entity/AnimSaves/Attack.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Attack", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1656617774" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "BackroomsFoundFootageMonster", { Weight = 0 })
						I[6] = new("Pose", I[5], "pelvis", { Weight = 0 })
							I[7] = new("Pose", I[6], "spine", { Weight = 0 })
								I[8] = new("Pose", I[7], "arm_r", { Weight = 0 })
									I[9] = new("Pose", I[8], "lowerarm_r", { CFrame = CFrame.new(-0.0000153, -0.0000763, 0.0000076, 0.9473971, 0.2938521, -0.1268547, -0.2669632, 0.9441333, 0.1932538, 0.1765553, -0.1492224, 0.9729156) })
										I[10] = new("Pose", I[9], "forearm_r")
											I[11] = new("Pose", I[10], "hand_r", { CFrame = CFrame.new(0.0000038, -0.0000019, -0.0000019, 0.9938097, 0.1109606, 0.0060388, -0.111078, 0.9903402, 0.0830507, 0.003234, -0.0832075, 0.9965329) })
												I[12] = new("Pose", I[11], "Bone.029")
												I[13] = new("Pose", I[11], "Bone.027", { CFrame = CFrame.new(0, -0.000001, -0.0000067, 0.9962159, -0.0615323, 0.0614345, 0.0726593, 0.9772112, -0.1994701, -0.0477613, 0.2031782, 0.9779822) })
													I[14] = new("Pose", I[13], "Bone.028")
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("Pose", I[16], "Torso", { Weight = 0 })
					I[18] = new("Pose", I[17], "BackroomsFoundFootageMonster", { Weight = 0 })
						I[19] = new("Pose", I[18], "pelvis", { Weight = 0 })
							I[20] = new("Pose", I[19], "spine", { Weight = 0 })
								I[21] = new("Pose", I[20], "arm_r", { Weight = 0 })
									I[22] = new("Pose", I[21], "lowerarm_r", { CFrame = CFrame.new(-0.0000305, -0.0001831, 0.0001221, 0.9835683, -0.1120374, -0.1415826, 0.0941078, 0.9873609, -0.1275527, 0.154083, 0.1121328, 0.9816777), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
										I[23] = new("Pose", I[22], "forearm_r", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
											I[24] = new("Pose", I[23], "hand_r", { CFrame = CFrame.new(0.0000038, -0.0000019, -0.0000019, 0.9938097, 0.1109606, 0.0060388, -0.111078, 0.9903402, 0.0830507, 0.003234, -0.0832075, 0.9965329), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
												I[25] = new("Pose", I[24], "Bone.029", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
												I[26] = new("Pose", I[24], "Bone.027", { CFrame = CFrame.new(0, -0.000001, -0.0000067, 0.9962159, -0.0615323, 0.0614345, 0.0726593, 0.9772112, -0.1994701, -0.0477613, 0.2031782, 0.9779822), EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
													I[27] = new("Pose", I[26], "Bone.028", { EasingDirection = Enum.PoseEasingDirection.InOut, EasingStyle = Enum.PoseEasingStyle.Cubic })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "BackroomsFoundFootageMonster", { Weight = 0 })
						I[32] = new("Pose", I[31], "pelvis", { Weight = 0 })
							I[33] = new("Pose", I[32], "spine", { Weight = 0 })
								I[34] = new("Pose", I[33], "arm_r", { Weight = 0 })
									I[35] = new("Pose", I[34], "lowerarm_r", { CFrame = CFrame.new(0.0000305, -0.0002441, 0.0004272, 0.7100974, -0.3979763, 0.5808423, -0.4500648, 0.3778572, 0.8091151, -0.5414836, -0.8359668, 0.0892001) })
										I[36] = new("Pose", I[35], "forearm_r", { CFrame = CFrame.new(0, 0.0000305, 0, 0.9999089, -0.0135978, -0.000818, 0.0135254, 0.9837528, 0.1790316, -0.0016299, -0.1790265, 0.9838455) })
											I[37] = new("Pose", I[36], "hand_r", { CFrame = CFrame.new(-0.0001221, 0.0000916, 0.0000267, -0.9707371, 0.0978453, -0.2193319, 0.2301041, 0.6404796, -0.7327029, 0.0687855, -0.7617279, -0.6442475) })
												I[38] = new("Pose", I[37], "Bone.029", { CFrame = CFrame.new(0, -0.0000153, 0.0000305, 0.9963957, -0.0177226, 0.0830253, 0.0483219, 0.9224758, -0.3830402, -0.0697996, 0.3856692, 0.9200015) })
												I[39] = new("Pose", I[37], "Bone.027", { CFrame = CFrame.new(0.0000916, -0.000061, 0.0000305, 0.8241929, -0.5455041, 0.1521245, 0.5663195, 0.7936292, -0.22238, 0.0005794, 0.2694327, 0.9630268) })
													I[40] = new("Pose", I[39], "Bone.028", { CFrame = CFrame.new(0, -0.0000153, 0, 0.9959731, 0.0832142, 0.0335902, -0.0864667, 0.9900304, 0.1112534, -0.0239957, -0.1137094, 0.9932321) })
	return I[1]
end

return build
