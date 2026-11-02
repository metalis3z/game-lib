-- Generated from animations/Workspace/Ignored/Deagle animation/AnimSaves/SHOOTDeagle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "SHOOTDeagle", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.4796317, -0.4015273, -0.437336, -0.1858636, -0.9810687, 0.0543975, 0.9672307, -0.1729344, 0.1858989, -0.1729724, 0.0871667, 0.9810619) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.2945691, -1.0808706, -0.3341116, 0.9874681, 0.1555552, -0.0266344, 0.0488604, -0.1408591, 0.9888232, 0.1500649, -0.9777327, -0.1466944) })
							I[7] = new("Pose", I[6], "Mag")
							I[8] = new("Pose", I[6], "Slide")
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.4561408, -0.5233854, -0.9345949, -0.2469556, 0.6487355, -0.7198299, -0.9571278, -0.0472459, 0.285787, 0.1513912, 0.7595459, 0.6325905) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.1360939, -0.3269956, -0.4373402, -0.1541133, -0.9871419, 0.0424288, 0.9837468, -0.1492951, 0.0997664, -0.0921491, 0.0571145, 0.9941059) })
						I[14] = new("Pose", I[13], "Handle", { CFrame = CFrame.new(-0.2939453, -1.0791016, -0.3343353, 0.9874699, 0.1511205, -0.0454519, 0.0488555, -0.0188849, 0.9986273, 0.1500547, -0.9883349, -0.0260314) })
							I[15] = new("Pose", I[14], "Slide", { CFrame = CFrame.new(0, 0, 0.4879385) })
					I[16] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.112629, -0.4488483, -0.9346023, -0.2211846, 0.6362902, -0.7390617, -0.9479012, 0.0378863, 0.3163035, 0.2292612, 0.7705189, 0.5947604) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("Pose", I[18], "Torso", { Weight = 0 })
					I[20] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(0.2796287, -0.2677522, -0.4373354, -0.0111248, -0.9983491, 0.0563495, 0.9956881, -0.0058699, 0.0925786, -0.092095, 0.0571364, 0.9941096) })
						I[21] = new("Pose", I[20], "Handle", { CFrame = CFrame.new(-0.2944031, -1.0818481, -0.3341141, 0.9874762, 0.1519664, -0.0423897, 0.0488605, -0.0391008, 0.99804, 0.1500111, -0.9876119, -0.0460362) })
							I[22] = new("Pose", I[21], "Slide", { CFrame = CFrame.new(0, 0, 0.4693675) })
					I[23] = new("Pose", I[19], "Left Arm", { CFrame = CFrame.new(-0.2561613, -0.3896073, -0.9345995, -0.0827494, 0.6241954, -0.7768737, -0.9698455, 0.1288811, 0.2068562, 0.2292431, 0.7705646, 0.5947082) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { Weight = 0 })
					I[27] = new("Pose", I[26], "Right Arm", { CFrame = CFrame.new(0.4796312, -0.4015171, -0.4373361, -0.1009611, -0.9923987, 0.0703675, 0.9797406, -0.0868787, 0.180445, -0.1729599, 0.0871598, 0.9810647) })
						I[28] = new("Pose", I[27], "Handle", { CFrame = CFrame.new(-0.2938538, -1.0802612, -0.334549, 0.9874728, 0.1552093, -0.0284193, 0.0488066, -0.1291689, 0.990421, 0.1500516, -0.9794008, -0.135126) })
							I[29] = new("Pose", I[28], "Mag")
							I[30] = new("Pose", I[28], "Slide", { CFrame = CFrame.new(0, 0, 0.0461265) })
					I[31] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.4561446, -0.5233739, -0.9345958, -0.1626667, 0.650368, -0.7419981, -0.9750001, 0.0094205, 0.2220045, 0.1513746, 0.7595609, 0.6325765) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { Weight = 0 })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.4796317, -0.4015273, -0.437336, -0.1858636, -0.9810687, 0.0543975, 0.9672307, -0.1729344, 0.1858989, -0.1729724, 0.0871667, 0.9810619) })
						I[36] = new("Pose", I[35], "Handle", { CFrame = CFrame.new(-0.2945691, -1.0808706, -0.3341116, 0.9874681, 0.1555552, -0.0266344, 0.0488604, -0.1408591, 0.9888232, 0.1500649, -0.9777327, -0.1466944) })
							I[37] = new("Pose", I[36], "Mag")
							I[38] = new("Pose", I[36], "Slide")
					I[39] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-0.4561408, -0.5233854, -0.9345949, -0.2469556, 0.6487355, -0.7198299, -0.9571278, -0.0472459, 0.285787, 0.1513912, 0.7595459, 0.6325905) })
	return I[1]
end

return build
