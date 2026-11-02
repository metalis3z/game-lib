-- Generated from animations/Workspace/Bacon/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso")
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8649583, 0.5018437, 0, -0.5018437, 0.8649583) })
						I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9935242, -0.1136212, 0, 0.1136212, 0.9935242) })
						I[7] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.71702, -0.6970527, 0, 0.6970527, 0.71702) })
							I[8] = new("Pose", I[7], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 0.1588295, -0.9873061, 0, 0.9873061, 0.1588295, 0, 0, 0, 1) })
								I[9] = new("Pose", I[8], "LeftHand", { CFrame = CFrame.new(0, 0, 0, -0.306049, 0.3752478, -0.8749418, -0.4919003, 0.7245259, 0.4828005, 0.8150878, 0.5781446, -0.037156) })
						I[10] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.7524257, -0.6586772, 0, 0.6586772, 0.7524257) })
							I[11] = new("Pose", I[10], "RightLowerArm", { CFrame = CFrame.new(-0.0000001, 0, 0, 0.2538057, 0.9531582, -0.164536, -0.9651012, 0.2382036, -0.1088058, -0.0645161, 0.1864095, 0.9803517) })
								I[12] = new("Pose", I[11], "RightHand", { CFrame = CFrame.new(0, 0, 0, 0.1417824, -0.3650994, 0.9201087, 0.3275684, 0.8944368, 0.3044367, -0.9341289, 0.2582347, 0.2464105) })
					I[13] = new("Pose", I[4], "RightUpperLeg", { CFrame = CFrame.new(0, -0.0000001, 0, 1, 0, 0, 0, -0.44876, -0.8936523, 0, 0.8936523, -0.44876) })
						I[14] = new("Pose", I[13], "RightLowerLeg", { CFrame = CFrame.new(0, 0, 0, 0.9999999, 0, 0, 0, 0.6299294, 0.7766524, 0, -0.7766524, 0.6299294) })
							I[15] = new("Pose", I[14], "RightFoot", { CFrame = CFrame.new(0, 0, 0, 0.9929323, -0.1084219, 0.0482718, 0, 0.4067312, 0.9135479, -0.1186822, -0.9070911, 0.4038566) })
					I[16] = new("Pose", I[4], "LeftUpperLeg", { CFrame = CFrame.new(0, 0, 0, 0.9985014, -0.053113, 0.0131932, -0.0170718, -0.5313328, -0.8469911, 0.0519962, 0.8454966, -0.5314432) })
						I[17] = new("Pose", I[16], "LeftLowerLeg", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.2552871, 0.9668652, 0, -0.9668652, 0.2552871) })
							I[18] = new("Pose", I[17], "LeftFoot", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.7201046, 0.6938655, 0, -0.6938655, 0.7201046) })
		I[19] = new("Keyframe", I[1], "KF2", { Time = 2 })
	return I[1]
end

return build
