-- Generated from animations/Workspace/StudioAssets/studiooo/WIP/kool killer/AnimSaves/Untitled_Autosave 30-12-2024 06_44_03.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "UntitledAutosave 30-12-2024 06:44:03")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "pelvis", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "Head", { Weight = 0 })
						I[8] = new("IntValue", I[7], "Null")
						I[9] = new("Pose", I[7], "Tongue")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("IntValue", I[11], "Null")
				I[13] = new("Pose", I[11], "pelvis", { Weight = 0 })
					I[14] = new("IntValue", I[13], "Null")
					I[15] = new("Pose", I[13], "Head", { Weight = 0 })
						I[16] = new("IntValue", I[15], "Null")
						I[17] = new("Pose", I[15], "Tongue", { CFrame = CFrame.new(0, 0.0787247, 0.1127327, 1, 0, 0, 0, 0.9282952, 0.3718441, 0, -0.3718441, 0.9282952) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("IntValue", I[19], "Null")
				I[21] = new("Pose", I[19], "pelvis", { Weight = 0 })
					I[22] = new("IntValue", I[21], "Null")
					I[23] = new("Pose", I[21], "Head", { Weight = 0 })
						I[24] = new("IntValue", I[23], "Null")
						I[25] = new("Pose", I[23], "Tongue", { CFrame = CFrame.new(0, 0.0719769, 0.1030699, 1, 0, 0, 0, 0.9399402, 0.3413393, 0, -0.3413393, 0.9399402) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("IntValue", I[27], "Null")
				I[29] = new("Pose", I[27], "pelvis", { Weight = 0 })
					I[30] = new("IntValue", I[29], "Null")
					I[31] = new("Pose", I[29], "Head", { Weight = 0 })
						I[32] = new("IntValue", I[31], "Null")
						I[33] = new("Pose", I[31], "Tongue")
	return I[1]
end

return build
