-- Generated from animations/Workspace/Ignored/kinfe animation/AnimSaves/Equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Equip", { Loop = false, Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0, -0.1015509, 0.0759233, 0.9848022, 0.1736795, -0.0000051, -0.1710408, 0.9698353, -0.1736795, -0.0301596, 0.1710408, 0.9848022) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.3011543, -0.8164921, -0.7143896, 0.0941372, 0.0000194, -0.9955592, -0.9941923, -0.0523833, -0.094009, -0.0521525, 0.9986271, -0.004912) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(0, 0, 0.0000001, 0.9698465, 0.1736732, -0.1709838, -0.1382931, 0.9698465, 0.2006809, 0.2006809, -0.1709838, 0.96462) })
					I[8] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, 0, 0.0000001, 0.9401428, 0.329057, -0.0886178, -0.3394411, 0.8811931, -0.329057, -0.0301891, 0.3394411, 0.9401428) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(0.2813565, 0.0485382, -0.0152445, 0.9848015, -0.1710409, -0.0301837, 0.1710409, 0.9852605, -0.0026011, 0.0301837, -0.0026011, 0.999541) })
						I[13] = new("Pose", I[12], "Handle", { CFrame = CFrame.new(-0.2859741, -0.9857446, -0.6747978, 0.0828832, -0.0447387, -0.9955545, -0.8998588, 0.4259197, -0.0940564, 0.4282342, 0.9036542, -0.004957) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Right Arm", { Weight = 0 })
						I[18] = new("Pose", I[17], "Handle", { CFrame = CFrame.new(-0.2528236, -1.3216053, 0.1404612, -0.0533773, -0.0775652, -0.9955574, 0.5198681, 0.8490564, -0.094024, 0.8525773, -0.5225773, -0.0049967) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "Torso", { Weight = 0 })
					I[22] = new("Pose", I[21], "Right Arm", { Weight = 0 })
						I[23] = new("Pose", I[22], "Handle", { CFrame = CFrame.new(-0.2733154, -1.1187744, -0.6066132, 0.0653749, -0.0677998, -0.9955548, -0.7274592, 0.6796737, -0.0940574, 0.6830294, 0.7303745, -0.0048881) })
					I[24] = new("Pose", I[21], "Left Arm", { CFrame = CFrame.new(-0.0921115, -0.3318539, -0.0914421, -0.4218853, 0.8282278, -0.3688517, -0.469334, 0.1485763, 0.8704313, 0.775718, 0.5403368, 0.3260333) })
					I[25] = new("Pose", I[21], "Head", { CFrame = CFrame.new(-0.0004839, 0.0001288, -0.0013257, 0.9999523, 0.0097583, 0.0003267, -0.0097491, 0.9997214, -0.0214948, -0.0005364, 0.0214906, 0.9997689) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.2246349, -0.1173329, -0.0370063, 0.3225181, -0.8102261, 0.4894035, 0.7268138, 0.5432039, 0.4203227, -0.6064023, 0.2201436, 0.7640766) })
						I[30] = new("Pose", I[29], "Handle", { CFrame = CFrame.new(-0.1342773, -0.8026733, -0.712326, 0.0940953, -0.3033276, -0.9482291, -0.9941962, -0.0785247, -0.0735376, -0.0521534, 0.9496453, -0.3089559) })
					I[31] = new("Pose", I[28], "Head", { CFrame = CFrame.new(0.000739, -0.0001551, 0.0019492, 0.9999279, -0.0119906, -0.0006769, 0.0120044, 0.9995769, 0.026495, 0.0003589, -0.0265012, 0.9996487) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.65 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { Weight = 0 })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(-0.1601232, 0.0280286, -0.158286, 0.2558302, -0.8678235, 0.4259499, 0.871092, 0.3980145, 0.2877208, -0.4192251, 0.2974339, 0.8577782) })
						I[36] = new("Pose", I[35], "Handle", { CFrame = CFrame.new(-0.3011543, -0.8164921, -0.7143896, 0.0941372, 0.0000194, -0.9955592, -0.9941923, -0.0523833, -0.094009, -0.0521525, 0.9986271, -0.004912) })
					I[37] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-0.1671507, -0.2617041, -0.0029079, -0.4718919, 0.8166685, -0.3322208, -0.3090649, 0.1996748, 0.9298434, 0.8257099, 0.5414634, 0.1581787) })
					I[38] = new("Pose", I[34], "Head", { CFrame = CFrame.new(0.0000339, -0.0000081, 0.0000909, 0.9999998, -0.0006043, -0.0000004, 0.0006043, 0.9999989, 0.0013812, -0.0000004, -0.0013812, 0.999999) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[40] = new("Pose", I[39], "HumanoidRootPart", { Weight = 0 })
				I[41] = new("Pose", I[40], "Torso", { Weight = 0 })
					I[42] = new("Pose", I[41], "Left Arm", { CFrame = CFrame.new(-0.0528805, -0.3813826, -0.1812064, -0.059384, 0.9285547, -0.3664145, -0.5449448, 0.277386, 0.7912598, 0.8363663, 0.2466639, 0.4895389) })
					I[43] = new("Pose", I[41], "Head", { CFrame = CFrame.new(-0.0012967, 0.000459, -0.0038662, 0.9992774, 0.0380102, 0.0000417, -0.0378723, 0.9957442, -0.0840193, -0.0032351, 0.083957, 0.9964641) })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { Weight = 0 })
				I[46] = new("Pose", I[45], "Torso", { Weight = 0 })
					I[47] = new("Pose", I[46], "Right Arm", { CFrame = CFrame.new(0.1940776, 0.0686017, -0.2866014, -0.029515, -0.9437215, 0.3294219, 0.9884971, 0.0213491, 0.1497263, -0.1483328, 0.3300517, 0.9322356) })
					I[48] = new("Pose", I[46], "Head", { CFrame = CFrame.new(0.0005397, 0.0001674, -0.0017025, 0.9941027, 0.1081094, -0.0084984, -0.1070103, 0.9652569, -0.238386, -0.0175687, 0.2378896, 0.9711333) })
		I[49] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[50] = new("Pose", I[49], "HumanoidRootPart", { Weight = 0 })
				I[51] = new("Pose", I[50], "Torso", { Weight = 0 })
					I[52] = new("Pose", I[51], "Head", { CFrame = CFrame.new(0.0008373, -0.0001728, 0.0022041, 0.9999103, -0.0133692, -0.0008023, 0.0133871, 0.9994721, 0.0296005, 0.0004061, -0.0296086, 0.9995615) })
		I[53] = new("Keyframe", I[1], "Keyframe", { Time = 0.6 })
			I[54] = new("Pose", I[53], "HumanoidRootPart", { Weight = 0 })
				I[55] = new("Pose", I[54], "Torso", { Weight = 0 })
					I[56] = new("Pose", I[55], "Head", { CFrame = CFrame.new(0.0002591, -0.0000592, 0.0006912, 0.9999899, -0.0044878, -0.0001949, 0.0044895, 0.9999406, 0.0099265, 0.0001504, -0.0099273, 0.9999507) })
	return I[1]
end

return build
