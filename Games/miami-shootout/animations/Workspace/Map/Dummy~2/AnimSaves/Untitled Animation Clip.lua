-- Generated from animations/Workspace/Map/Dummy~2/AnimSaves/Untitled Animation Clip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Untitled Animation Clip", { Loop = false }, nil, { "1674703648" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso")
					I[5] = new("Pose", I[4], "RightUpperLeg")
						I[6] = new("Pose", I[5], "RightLowerLeg", { CFrame = CFrame.new(-0.000061, 0.0000035, 0, 1, 0, 0, 0, 0.964604, 0.2637026, 0, -0.2637026, 0.964604) })
							I[7] = new("Pose", I[6], "RightFoot")
					I[8] = new("Pose", I[4], "UpperTorso")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "LowerTorso", { CFrame = CFrame.new(0, -0.0000002, 0, 1, 0, 0, 0, 0.9998901, 0.0148264, 0, -0.0148264, 0.9998901) })
					I[12] = new("Pose", I[11], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000243, 0, 1, 0, 0, 0, 0.3960216, -0.9182412, 0, 0.9182412, 0.3960216) })
						I[13] = new("Pose", I[12], "RightLowerLeg", { CFrame = CFrame.new(-0.000061, -0.0000271, 0, 1, 0, 0, 0, 0.2586112, 0.9659815, 0, -0.9659815, 0.2586112) })
					I[14] = new("Pose", I[11], "UpperTorso", { CFrame = CFrame.new(0, 0.0000012, 0, 1, 0, 0, 0, 0.9910702, 0.1333414, 0, -0.1333414, 0.9910702) })
		I[15] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[16] = new("Pose", I[15], "HumanoidRootPart", { Weight = 0 })
				I[17] = new("Pose", I[16], "LowerTorso", { CFrame = CFrame.new(0, -0.0711454, -0.1984863, 1, 0, 0, 0, 0.9820437, 0.1886533, 0, -0.1886533, 0.9820437) })
					I[18] = new("Pose", I[17], "RightUpperLeg", { CFrame = CFrame.new(0, -0.2334219, -0.3326416, 1, 0, 0, 0, 0.6004181, -0.7996863, 0, 0.7996863, 0.6004181) })
						I[19] = new("Pose", I[18], "RightLowerLeg", { CFrame = CFrame.new(-0.0001831, -0.000061, 0, 1, 0, 0, 0, 0.9696219, 0.2446088, 0, -0.2446088, 0.9696219) })
							I[20] = new("Pose", I[19], "RightFoot", { CFrame = CFrame.new(0, 0.000061, 0, 1, 0, 0, 0, 0.9004213, 0.4350189, 0, -0.4350189, 0.9004213) })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 0.3666667 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { Weight = 0 })
				I[23] = new("Pose", I[22], "LowerTorso")
					I[24] = new("Pose", I[23], "RightUpperLeg")
						I[25] = new("Pose", I[24], "RightLowerLeg")
					I[26] = new("Pose", I[23], "UpperTorso")
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 })
				I[29] = new("Pose", I[28], "LowerTorso", { Weight = 0 })
					I[30] = new("Pose", I[29], "RightUpperLeg", { Weight = 0 })
						I[31] = new("Pose", I[30], "RightLowerLeg", { Weight = 0 })
							I[32] = new("Pose", I[31], "RightFoot", { CFrame = CFrame.new(0, 0.0000916, 0.000061, 1, 0, 0, 0, 0.9997723, 0.0213396, 0, -0.0213396, 0.9997723) })
		I[33] = new("AnimationRigData", I[1], "DummyAnimationRigData")
	return I[1]
end

return build
