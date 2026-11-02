-- Generated from animations/Workspace/Rake Player Animations/player climb/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0.9, 0), EasingDirection = Enum.PoseEasingDirection.Out })
					I[5] = new("Pose", I[4], "Left Leg", { CFrame = CFrame.new(0.2026325, 0.0015324, -0.034729, 0.8660254, -0.4999999, 0, 0.4999999, 0.8660254, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[6] = new("Pose", I[4], "Right Leg", { CFrame = CFrame.new(0.4000003, 0.8000009, 0, 0.9396925, -0.3420205, 0, 0.3420205, 0.9396925, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.8826029, -0.4550038, -0.0606559, -0.3840062, 0.597707, 0.7037652, 0.2531143, -0.6648602, 0.7027758, 0.8879595, 0.4480032, 0.1040223), EasingDirection = Enum.PoseEasingDirection.Out })
					I[8] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.1241522, -0.4441535, 0.0803691, -0.1518277, -0.6275354, 0.763641, 0.1129805, 0.7565153, 0.6441427, -0.9819284, 0.1840753, -0.0439607), EasingDirection = Enum.PoseEasingDirection.Out })
					I[9] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0.000002, -0.00001, 1, 0, 0, 0, 0.8660261, 0.4999987, 0, -0.4999987, 0.8660261), EasingDirection = Enum.PoseEasingDirection.Out })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[11] = new("Pose", I[10], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[12] = new("Pose", I[11], "Left Leg", { CFrame = CFrame.new(-0.2348575, 0.8985007, 0, 0.996195, 0.0871521, 0, -0.0871521, 0.996195, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
				I[13] = new("Pose", I[11], "Right Leg", { CFrame = CFrame.new(0.2852827, 0.250816, -0.0173647, 0.8149353, -0.5732027, 0.0855513, 0.5732027, 0.8189681, 0.0270192, -0.0855512, 0.0270193, 0.9959673), EasingDirection = Enum.PoseEasingDirection.Out })
				I[14] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.234597, -0.1195402, 0.1213798, -0.1008998, 0.9737335, -0.204113, -0.0765017, 0.196959, 0.9774225, 0.991951, 0.1142367, 0.0546192), EasingDirection = Enum.PoseEasingDirection.Out })
				I[15] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(-0.4406022, -0.0762306, 0.1923464, 0.038112, -0.956988, 0.2876132, 0.2856113, 0.2862476, 0.9145975, -0.9575874, 0.0472884, 0.2842361), EasingDirection = Enum.PoseEasingDirection.Out })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { CFrame = CFrame.new(0, 0.9, 0), EasingDirection = Enum.PoseEasingDirection.Out })
					I[19] = new("Pose", I[18], "Left Leg", { CFrame = CFrame.new(-0.3999932, 0.8000329, 0, 0.9396937, 0.3420172, 0, -0.3420172, 0.9396937, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[20] = new("Pose", I[18], "Right Leg", { CFrame = CFrame.new(-0.2026348, 0.0015609, -0.0347329, 0.866027, 0.4999972, -0.0000002, -0.4999972, 0.866027, 0.0000001, 0.0000002, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[21] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(0.1267118, -0.2673363, 0.1238632, -0.1042993, 0.6685802, -0.7362897, -0.0867099, 0.7313954, 0.6764188, 0.9907589, 0.1343935, -0.0183115), EasingDirection = Enum.PoseEasingDirection.Out })
					I[22] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(0.4332042, -0.0200335, -0.0503389, -0.3954332, -0.7163469, -0.5748734, -0.2415375, -0.5227562, 0.8175483, -0.886167, 0.4621392, 0.0336906), EasingDirection = Enum.PoseEasingDirection.Out })
					I[23] = new("Pose", I[18], "Head", { CFrame = CFrame.new(0, 0.000002, -0.0000102, 1, 0, 0, 0, 0.9396931, 0.3420187, 0, -0.3420187, 0.9396931), EasingDirection = Enum.PoseEasingDirection.Out })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[25] = new("Pose", I[24], "Torso", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[26] = new("Pose", I[25], "Left Leg", { CFrame = CFrame.new(-0.3526379, 0.3241006, -0.0115776, 0.8354889, 0.5495071, 0, -0.5495071, 0.8354889, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
				I[27] = new("Pose", I[25], "Right Leg", { CFrame = CFrame.new(0.2340999, 0.6810708, 0, 0.9961946, 0.0871568, 0, -0.0871568, 0.9961946, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
				I[28] = new("Pose", I[25], "Left Arm", { CFrame = CFrame.new(0.5020353, 0.0991848, 0.1020718, -0.1317883, 0.9791802, -0.1543957, 0.0922863, 0.1671973, 0.9815949, 0.9869729, 0.1151142, -0.1123995), EasingDirection = Enum.PoseEasingDirection.Out })
				I[29] = new("Pose", I[25], "Right Arm", { CFrame = CFrame.new(0.2371614, -0.104486, 0.0053075, -0.2418615, -0.9381589, -0.2477112, 0.0604325, -0.2693594, 0.9611417, -0.968427, 0.2174933, 0.121843), EasingDirection = Enum.PoseEasingDirection.Out })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { EasingDirection = Enum.PoseEasingDirection.Out, Weight = 0 })
				I[32] = new("Pose", I[31], "Torso", { CFrame = CFrame.new(0, 0.9, 0), EasingDirection = Enum.PoseEasingDirection.Out })
					I[33] = new("Pose", I[32], "Left Leg", { CFrame = CFrame.new(0.2026325, 0.0015324, -0.034729, 0.8660254, -0.4999999, 0, 0.4999999, 0.8660254, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[34] = new("Pose", I[32], "Right Leg", { CFrame = CFrame.new(0.4000003, 0.8000009, 0, 0.9396925, -0.3420205, 0, 0.3420205, 0.9396925, 0, 0, 0, 1), EasingDirection = Enum.PoseEasingDirection.Out })
					I[35] = new("Pose", I[32], "Left Arm", { CFrame = CFrame.new(-0.8826029, -0.4550038, -0.0606559, -0.3840062, 0.597707, 0.7037652, 0.2531143, -0.6648602, 0.7027758, 0.8879595, 0.4480032, 0.1040223), EasingDirection = Enum.PoseEasingDirection.Out })
					I[36] = new("Pose", I[32], "Right Arm", { CFrame = CFrame.new(0.1241522, -0.4441535, 0.0803691, -0.1518277, -0.6275354, 0.763641, 0.1129805, 0.7565153, 0.6441427, -0.9819284, 0.1840753, -0.0439607), EasingDirection = Enum.PoseEasingDirection.Out })
					I[37] = new("Pose", I[32], "Head", { CFrame = CFrame.new(0, 0.000002, -0.00001, 1, 0, 0, 0, 0.8660261, 0.4999987, 0, -0.4999987, 0.8660261), EasingDirection = Enum.PoseEasingDirection.Out })
	return I[1]
end

return build
