-- Generated from animations/ServerStorage/RBX_ANIMSAVES/D4rkAuraX/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, { ["ViralWorkerRef"] = "vw_c3f1e56bff" }, { "1779489477" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_f7226f92f1" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_8a53790e7a" })
				I[4] = new("Pose", I[3], "LowerTorso", { CFrame = CFrame.new(0, 0.0000052, 0, 1.0000002, 0, 0, 0, 0.2079115, -0.9781473, 0, 0.9781473, 0.2079117) }, { ["ViralWorkerRef"] = "vw_09294d2699" })
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(-0.0000153, 0.000061, -0.0000229, 1.0000001, 0, 0, 0, 0.9781476, 0.2079118, 0, -0.2079115, 0.9781469) }, { ["ViralWorkerRef"] = "vw_69630707ce" })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0.0000381, 0, 0.0000305, 0.1045284, 0.9945219, 0, -0.994522, 0.1045284, 0.0000004, 0, 0.0000004, 0.9999993) }, { ["ViralWorkerRef"] = "vw_03d9133d22" })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0, -0.0000076, 0, 1, 0, -0.0000004, 0, 0.9781477, -0.2079116, -0.0000004, 0.2079117, 0.9781471) }, { ["ViralWorkerRef"] = "vw_3f1bbca919" })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(-0.0000305, 0.0000229, 0, 1, -0.0000001, -0.0000004, -0.0000001, 1, -0.0000001, -0.0000005, -0.0000001, 0.9999995) }, { ["ViralWorkerRef"] = "vw_f4333c85fd" })
						I[9] = new("Pose", I[5], "Head", { CFrame = CFrame.new(-0.0000114, -0.0000305, -0.0000305, 1.0000002, 0, 0, 0, 0.9510566, 0.3090173, 0, -0.3090165, 0.951056) }, { ["ViralWorkerRef"] = "vw_afae0f323a" })
						I[10] = new("Pose", I[5], "RightUpperArm", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_e3737e9884" })
							I[11] = new("Pose", I[10], "RightLowerArm", { CFrame = CFrame.new(-0.0000076, -0.0000305, -0.0000153, 0.9945221, -0.1045285, 0, 0.1045285, 0.994522, 0.0000004, 0, 0.0000003, 0.9999994) }, { ["ViralWorkerRef"] = "vw_8b7af81169" })
					I[12] = new("Pose", I[4], "LeftUpperLeg", { CFrame = CFrame.new(0.0000153, 0.0000305, 0.0000153, 1.0000002, 0, 0, 0, 1, 0.0000001, 0, 0.0000001, 0.9999993) }, { ["ViralWorkerRef"] = "vw_288e9c4085" })
					I[13] = new("Pose", I[4], "RightUpperLeg", { CFrame = CFrame.new(0.0000153, 0, 0.0000153, 0.8090172, 0.5877854, 0, -0.5590259, 0.769433, -0.3089709, -0.1816086, 0.2499627, 0.9510706) }, { ["ViralWorkerRef"] = "vw_cc8993bac1" })
		I[14] = new("AnimationRigData", I[1], "D4rkAuraXAnimationRigData", nil, { ["ViralWorkerRef"] = "vw_81244eec9c" })
	return I[1]
end

return build
