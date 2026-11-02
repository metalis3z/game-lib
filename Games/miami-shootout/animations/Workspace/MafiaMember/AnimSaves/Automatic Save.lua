-- Generated from animations/Workspace/MafiaMember/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1637925959" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.0000048, 0.0000148, 0, 0.9024575, -0.3832003, -0.1967945, 0.3406815, 0.9144677, -0.2183688, 0.2636411, 0.1300243, 0.9558175) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0.000001, -0.0000305, -0.0000305, 0.4245561, -0.2901794, -0.8576409, -0.2106682, 0.88959, -0.4052757, 0.8805516, 0.3527398, 0.3165493) })
						I[8] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(-0.0000067, 0.00003, -0.0000305, 0.9634671, 0.2603306, 0.062923, -0.194882, 0.8425939, -0.5020524, -0.1837181, 0.4714483, 0.8625452) })
							I[9] = new("Pose", I[8], "RightLowerArm", { CFrame = CFrame.new(-0.0000095, -0.0000458, -0.0000305, 0.0311897, 0.505793, 0.8620909, -0.0182871, 0.8626549, -0.5054622, -0.9993463, 0.0000001, 0.0361554) })
						I[10] = new("Pose", I[5], "Head")
		I[11] = new("Keyframe", I[1], "Keyframe", { Time = 4.5 })
			I[12] = new("Pose", I[11], "HumanoidRootPart", { Weight = 0 })
				I[13] = new("Pose", I[12], "LowerTorso", { Weight = 0 })
					I[14] = new("Pose", I[13], "UpperTorso")
						I[15] = new("Pose", I[14], "LeftUpperArm", { CFrame = CFrame.new(0.0000048, 0.0000148, 0, 0.9024575, -0.3832003, -0.1967945, 0.3406815, 0.9144677, -0.2183688, 0.2636411, 0.1300243, 0.9558175) })
							I[16] = new("Pose", I[15], "LeftLowerArm", { CFrame = CFrame.new(0.000001, -0.0000305, -0.0000305, 0.4245561, -0.2901794, -0.8576409, -0.2106682, 0.88959, -0.4052757, 0.8805516, 0.3527398, 0.3165493) })
						I[17] = new("Pose", I[14], "RightUpperArm", { CFrame = CFrame.new(-0.0000067, 0.00003, -0.0000305, 0.9634671, 0.2603306, 0.062923, -0.194882, 0.8425939, -0.5020524, -0.1837181, 0.4714483, 0.8625452) })
							I[18] = new("Pose", I[17], "RightLowerArm", { CFrame = CFrame.new(-0.0000095, -0.0000458, -0.0000305, 0.0311897, 0.505793, 0.8620909, -0.0182871, 0.8626549, -0.5054622, -0.9993463, 0.0000001, 0.0361554) })
						I[19] = new("Pose", I[14], "Head")
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.6666667 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("Pose", I[21], "LowerTorso", { Weight = 0 })
					I[23] = new("Pose", I[22], "UpperTorso", { CFrame = CFrame.new(0, 0.0334995, 0) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 1.8666667 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "LowerTorso", { Weight = 0 })
					I[27] = new("Pose", I[26], "UpperTorso", { CFrame = CFrame.new(0, -0.017627, 0) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 3.2666667 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "LowerTorso", { Weight = 0 })
					I[31] = new("Pose", I[30], "UpperTorso", { CFrame = CFrame.new(0, 0.0334995, 0) })
	return I[1]
end

return build
