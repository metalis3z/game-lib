-- Generated from animations/ServerScriptService/Server/Special/Hotel_JeffShop/SkellyFriend/AnimSaves/skelly_SkellyFriend.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "skelly_SkellyFriend", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1684406555" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Root", { Weight = 0 })
				I[4] = new("Pose", I[3], "UpperTorso", { CFrame = CFrame.new(-0.048, -0.3144496, -0.2247146, 0.8754586, 0.3364309, 0.3469652, -0.1485395, 0.8704791, -0.4692571, -0.4598982, 0.3592769, 0.8120412) })
					I[5] = new("Pose", I[4], "LeftUpperArm", { CFrame = CFrame.new(0.000069, -0.0001046, -0.0000613, 0.9468266, 0.3083952, 0.091716, -0.3145213, 0.9472312, 0.0618828, -0.0677919, -0.0874389, 0.9938605) })
						I[6] = new("Pose", I[5], "LeftLowerArm", { CFrame = CFrame.new(-0.000359, -0.0000707, -0.0000935, -0.1725313, -0.3383492, 0.9250692, 0.6072611, 0.702905, 0.3703496, -0.775543, 0.6256552, 0.0841931) })
							I[7] = new("Pose", I[6], "LeftHand", { CFrame = CFrame.new(0.0907295, -0.0564086, 0.0804298, -0.9231249, -0.373806, -0.0900526, -0.3748488, 0.9270687, -0.0056809, 0.0856085, 0.0285119, -0.9959208) })
					I[8] = new("Pose", I[4], "RightUpperArm", { CFrame = CFrame.new(-0.0000262, -0.0000111, 0.0000009, 0.9447325, 0.1381059, 0.2973317, 0.0951641, 0.7523671, -0.6518332, -0.3137248, 0.6441045, 0.6976425) })
						I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(-0.0000314, 0.0000732, 0.0000125, 0.9998767, -0.0098057, 0.0122679, 0.0132096, 0.947585, -0.3192306, -0.0084946, 0.3193533, 0.9475977) })
							I[10] = new("Pose", I[9], "RightHand", { CFrame = CFrame.new(-0.0000643, 0.0000046, -0.0000023, 0.3553145, -0.0336773, 0.9341359, 0.1888118, 0.981337, -0.0364388, -0.9154768, 0.1893242, 0.3550412) })
					I[11] = new("Pose", I[4], "LowerTorso", { CFrame = CFrame.new(0.0805594, 0.0686843, -0.0176596, 0.9685142, 0.1388141, 0.2066433, 0.005298, 0.8184155, -0.5745972, -0.2488834, 0.5576081, 0.791908) })
						I[12] = new("Pose", I[11], "LeftUpperLeg", { CFrame = CFrame.new(-0.0000335, 0.0000008, 0.0000055, 0.8970026, 0.432971, -0.0890088, -0.4419936, 0.8761494, -0.1923639, -0.005303, 0.2118922, 0.9772788) })
							I[13] = new("Pose", I[12], "LeftLowerLeg", { CFrame = CFrame.new(0.0162354, 0.0196406, 0.02866, 0.9999982, -0.0000008, 0.0000007, -0.0000002, 0.1871831, 0.9823209, -0.0000003, -0.9823254, 0.1871824) })
								I[14] = new("Pose", I[13], "LeftFoot", { CFrame = CFrame.new(-0.013916, 0.132978, -0.1217488, 1, -0.0000004, -0.0000008, 0.0000007, 0.8666894, 0.4988481, 0.0000005, -0.4988481, 0.8666894) })
						I[15] = new("Pose", I[11], "RightUpperLeg", { CFrame = CFrame.new(0.0000343, 0.0000693, 0.0000837, 0.9585317, -0.2795497, -0.0553987, 0.2568556, 0.9316496, -0.2570107, 0.1234594, 0.2321234, 0.9648195) })
							I[16] = new("Pose", I[15], "RightLowerLeg", { CFrame = CFrame.new(0, -0.0000001, 0, 0.9999807, -0.0060609, -0.0013085, 0.0024641, 0.1947946, 0.980841, -0.0056899, -0.9808254, 0.1948058) })
								I[17] = new("Pose", I[16], "RightFoot", { CFrame = CFrame.new(-0.0224255, 0.1310402, -0.1133885, 1, 0.0000051, -0.0000014, -0.0000044, 0.9509997, 0.3091917, 0.000003, -0.3091917, 0.9509997) })
					I[18] = new("Pose", I[4], "Skull", { CFrame = CFrame.new(-0.0000422, 0.0000201, 0.0001225, 0.9917572, -0.1124455, -0.0614298, 0.1238034, 0.9645015, 0.2332585, 0.0330202, -0.238941, 0.9704725) })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.3833333 })
			I[20] = new("Pose", I[19], "Root", { Weight = 0 })
				I[21] = new("Pose", I[20], "UpperTorso", { Weight = 0 })
					I[22] = new("Pose", I[21], "Skull", { CFrame = CFrame.new(-0.0000534, 0.0000305, 0.0001526, 0.6217673, -0.7807893, -0.0614297, 0.7695479, 0.5944635, 0.2332587, -0.1456077, -0.1923054, 0.9704726) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 3.6333334 })
			I[24] = new("Pose", I[23], "Root", { Weight = 0 })
				I[25] = new("Pose", I[24], "UpperTorso", { Weight = 0 })
					I[26] = new("Pose", I[25], "Skull", { CFrame = CFrame.new(-0.0000687, 0.0000305, 0.0001678, 0.6217677, -0.780789, -0.0614297, 0.7695481, 0.5944634, 0.2332586, -0.1456077, -0.1923056, 0.9704726) })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 4.0333333 })
			I[28] = new("Pose", I[27], "Root", { Weight = 0 })
				I[29] = new("Pose", I[28], "UpperTorso", { Weight = 0 })
					I[30] = new("Pose", I[29], "Skull", { CFrame = CFrame.new(-0.0000534, 0.0000305, 0.0001831, 0.9917575, -0.1124449, -0.0614298, 0.1238032, 0.9645015, 0.2332586, 0.0330205, -0.2389409, 0.9704725) })
	return I[1]
end

return build
