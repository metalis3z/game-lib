-- Generated from animations/ServerStorage/RBX_ANIMSAVES/rafi050393/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, { ["ViralWorkerRef"] = "vw_b6b76a5a9d" }, { "1779487772" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_bae93c0c13" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_d4ab0a772e" })
				I[4] = new("Pose", I[3], "LowerTorso", { CFrame = CFrame.new(1.4958191, -1.8714895, -1.6610718, -0.743103, 0.6691771, 0, 0, 0, -1, -0.6691771, -0.743103, 0) }, { ["ViralWorkerRef"] = "vw_d870d080f0" })
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(0, 0, -0.0000072, 1, 0.0000001, 0.0000001, 0.0000001, 0.7431446, 0.6691306, 0.0000001, -0.6691303, 0.7431447) }, { ["ViralWorkerRef"] = "vw_901474255d" })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.000061, -0.0000229, -0.0000153, 0.1045284, 0.9945216, 0, -0.9945216, 0.1045284, 0, 0.0000001, 0, 0.9999997) }, { ["ViralWorkerRef"] = "vw_b352c0d079" })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0.0000153, -0.0000916, -0.0000229, 0.9781468, -0.2079115, 0, 0.2079117, 0.9781476, 0.0000001, 0, 0.0000001, 0.9999996) }, { ["ViralWorkerRef"] = "vw_2c91735621" })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0.0000153, 0, -0.0000076, 0.9781471, -0.2079113, 0.0000001, 0.207912, 0.9781476, 0, 0.0000001, 0, 0.9999997) }, { ["ViralWorkerRef"] = "vw_c2826665e9" })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, 0.0000229, 0.0000229, 0.1045284, -0.9945216, 0, 0.9945216, 0.1045283, -0.0000001, 0.0000001, 0.0000001, 0.9999996) }, { ["ViralWorkerRef"] = "vw_c7a659668f" })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(0.0000153, 0, 0.0000229, 0.9945211, 0.1045285, 0, -0.1045285, 0.9945221, -0.0000001, 0, 0, 0.9999996) }, { ["ViralWorkerRef"] = "vw_61f6f58b9a" })
								I[11] = new("Pose", I[10], "RightHand", { CFrame = CFrame.new(-0.0000153, 0, -0.0000153, 0.9781469, 0.2079115, 0, -0.2079118, 0.9781479, -0.0000001, 0.0000001, -0.0000001, 0.9999997) }, { ["ViralWorkerRef"] = "vw_34fff583ff" })
						I[12] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, -0.0000763, 0, 1, -0.0000001, 0.0000001, 0, 0.9135448, 0.4067363, 0.0000001, -0.4067363, 0.9135452) }, { ["ViralWorkerRef"] = "vw_950b8f485b" })
					I[13] = new("Pose", I[4], "RightUpperLeg", { CFrame = CFrame.new(0.0000305, -0.0000153, -0.0000005, 0.9781476, -0.2079117, 0, 0.2079118, 0.9781473, 0.0000002, 0, 0.0000002, 0.9999998) }, { ["ViralWorkerRef"] = "vw_2f6e94ff4c" })
					I[14] = new("Pose", I[4], "LeftUpperLeg", { CFrame = CFrame.new(0, -0.000061, -0.0000005, 0.9781477, 0.2079116, 0, -0.2079116, 0.9781474, 0.0000002, 0, 0.0000002, 0.9999998) }, { ["ViralWorkerRef"] = "vw_01bc941884" })
						I[15] = new("Pose", I[14], "LeftLowerLeg", { CFrame = CFrame.new(-0.000061, 0.000061, 0.0000024, 1, 0.0000001, 0, 0.0000001, 0.9945219, 0.1045286, 0, -0.1045283, 0.9945217) }, { ["ViralWorkerRef"] = "vw_df69228a84" })
		I[16] = new("AnimationRigData", I[1], "rafi050393AnimationRigData", nil, { ["ViralWorkerRef"] = "vw_5885c84f3e" })
	return I[1]
end

return build
