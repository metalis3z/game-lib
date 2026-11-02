-- Generated from animations/Workspace/StudioAssets/studiooo/WIP/kool killer/AnimSaves/Untitled_Autosave 30-12-2024 06_46_09.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "UntitledAutosave 30-12-2024 06:46:09")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "pelvis", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999139, 0, 0.0131207, 0, 1, 0, -0.0131207, 0, 0.9999139) })
						I[8] = new("Pose", I[7], "Tongue")
						I[9] = new("Pose", I[7], "righteye", { CFrame = CFrame.new(-0.04, -0.06, 0) })
						I[10] = new("Pose", I[7], "GumUpper", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.953679, 0.3008261, 0, -0.3008261, 0.953679) })
						I[11] = new("Pose", I[7], "GumLower", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9054352, -0.4244845, 0, 0.4244845, 0.9054352) })
						I[12] = new("Pose", I[7], "lefteye", { CFrame = CFrame.new(0.08, -0.08, 0) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[14] = new("Pose", I[13], "HumanoidRootPart", { Weight = 0 })
				I[15] = new("IntValue", I[14], "Null")
				I[16] = new("Pose", I[14], "pelvis", { Weight = 0 })
					I[17] = new("IntValue", I[16], "Null")
					I[18] = new("Pose", I[16], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999946, 0, -0.0032802, 0, 1, 0, 0.0032802, 0, 0.9999946) })
						I[19] = new("Pose", I[18], "Tongue", { CFrame = CFrame.new(0, 0.0787247, 0.1127327, 1, 0, 0, 0, 0.9282952, 0.3718441, 0, -0.3718441, 0.9282952) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("IntValue", I[21], "Null")
				I[23] = new("Pose", I[21], "pelvis", { Weight = 0 })
					I[24] = new("IntValue", I[23], "Null")
					I[25] = new("Pose", I[23], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999954, 0, -0.0030213, 0, 1, 0, 0.0030213, 0, 0.9999954) })
						I[26] = new("Pose", I[25], "Tongue", { CFrame = CFrame.new(0, 0.0776001, 0.1111223, 1, 0, 0, 0, 0.9303076, 0.3667803, 0, -0.3667803, 0.9303076) })
		I[27] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[28] = new("Pose", I[27], "HumanoidRootPart", { Weight = 0 })
				I[29] = new("IntValue", I[28], "Null")
				I[30] = new("Pose", I[28], "pelvis", { Weight = 0 })
					I[31] = new("IntValue", I[30], "Null")
					I[32] = new("Pose", I[30], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999982, 0, -0.0018991, 0, 1, 0, 0.0018991, 0, 0.9999982) })
						I[33] = new("Pose", I[32], "Tongue", { CFrame = CFrame.new(0, 0.0719769, 0.1030699, 1, 0, 0, 0, 0.9399402, 0.3413393, 0, -0.3413393, 0.9399402) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("IntValue", I[35], "Null")
				I[37] = new("Pose", I[35], "pelvis", { Weight = 0 })
					I[38] = new("IntValue", I[37], "Null")
					I[39] = new("Pose", I[37], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999139, 0, 0.0131207, 0, 1, 0, -0.0131207, 0, 0.9999139) })
						I[40] = new("Pose", I[39], "Tongue")
	return I[1]
end

return build
