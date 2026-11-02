-- Generated from animations/Workspace/StudioAssets/studiooo/WIP/kool killer/AnimSaves/Untitled_Autosave 30-12-2024 06_45_06.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "UntitledAutosave 30-12-2024 06:45:06")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "pelvis", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999139, 0, 0.0131207, 0, 1, 0, -0.0131207, 0, 0.9999139) })
						I[8] = new("Pose", I[7], "Tongue")
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("IntValue", I[10], "Null")
				I[12] = new("Pose", I[10], "pelvis", { Weight = 0 })
					I[13] = new("IntValue", I[12], "Null")
					I[14] = new("Pose", I[12], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999946, 0, -0.0032802, 0, 1, 0, 0.0032802, 0, 0.9999946) })
						I[15] = new("Pose", I[14], "Tongue", { CFrame = CFrame.new(0, 0.0787247, 0.1127327, 1, 0, 0, 0, 0.9282952, 0.3718441, 0, -0.3718441, 0.9282952) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("IntValue", I[17], "Null")
				I[19] = new("Pose", I[17], "pelvis", { Weight = 0 })
					I[20] = new("IntValue", I[19], "Null")
					I[21] = new("Pose", I[19], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999982, 0, -0.0018991, 0, 1, 0, 0.0018991, 0, 0.9999982) })
						I[22] = new("Pose", I[21], "Tongue", { CFrame = CFrame.new(0, 0.0719769, 0.1030699, 1, 0, 0, 0, 0.9399402, 0.3413393, 0, -0.3413393, 0.9399402) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[24] = new("Pose", I[23], "HumanoidRootPart", { Weight = 0 })
				I[25] = new("IntValue", I[24], "Null")
				I[26] = new("Pose", I[24], "pelvis", { Weight = 0 })
					I[27] = new("IntValue", I[26], "Null")
					I[28] = new("Pose", I[26], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9999139, 0, 0.0131207, 0, 1, 0, -0.0131207, 0, 0.9999139) })
						I[29] = new("Pose", I[28], "Tongue")
	return I[1]
end

return build
