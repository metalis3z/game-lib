-- Generated from animations/Workspace/StudioAssets/studiooo/WIP/kool killer/AnimSaves/Untitled_Autosave 30-12-2024 06_48_36.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "UntitledAutosave 30-12-2024 06:48:36")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "pelvis", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "Head", { Weight = 0 })
						I[8] = new("IntValue", I[7], "Null")
						I[9] = new("Pose", I[7], "Tongue")
						I[10] = new("Pose", I[7], "righteye", { CFrame = CFrame.new(-0.04, -0.06, 0) })
						I[11] = new("Pose", I[7], "GumUpper", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.953679, 0.3008261, 0, -0.3008261, 0.953679) })
						I[12] = new("Pose", I[7], "GumLower", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9054352, -0.4244845, 0, 0.4244845, 0.9054352) })
						I[13] = new("Pose", I[7], "lefteye", { CFrame = CFrame.new(0.08, -0.08, 0) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("IntValue", I[15], "Null")
				I[17] = new("Pose", I[15], "pelvis", { Weight = 0 })
					I[18] = new("IntValue", I[17], "Null")
					I[19] = new("Pose", I[17], "Head", { Weight = 0 })
						I[20] = new("IntValue", I[19], "Null")
						I[21] = new("Pose", I[19], "Tongue", { CFrame = CFrame.new(0, 0.0617796, 0.1596544, 1, 0, 0, 0, 0.9747946, -0.2231043, 0, 0.2231043, 0.9747946) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 })
			I[23] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[24] = new("IntValue", I[23], "Null")
				I[25] = new("Pose", I[23], "pelvis", { Weight = 0 })
					I[26] = new("IntValue", I[25], "Null")
					I[27] = new("Pose", I[25], "Head", { Weight = 0 })
						I[28] = new("IntValue", I[27], "Null")
						I[29] = new("Pose", I[27], "Tongue", { CFrame = CFrame.new(0, 0.0850374, 0.1930509, 1, 0, 0, 0, 0.9675547, -0.2526616, 0, 0.2526616, 0.9675547) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[31] = new("Pose", I[30], "HumanoidRootPart", { Weight = 0 })
				I[32] = new("IntValue", I[31], "Null")
				I[33] = new("Pose", I[31], "pelvis", { Weight = 0 })
					I[34] = new("IntValue", I[33], "Null")
					I[35] = new("Pose", I[33], "Head", { Weight = 0 })
						I[36] = new("IntValue", I[35], "Null")
						I[37] = new("Pose", I[35], "Tongue", { CFrame = CFrame.new(0, 0.1162279, 0.2774734, 1, 0, 0, 0, 0.9380406, 0.3465256, 0, -0.3465256, 0.9380406) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.2166667 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("IntValue", I[39], "Null")
				I[41] = new("Pose", I[39], "pelvis", { Weight = 0 })
					I[42] = new("IntValue", I[41], "Null")
					I[43] = new("Pose", I[41], "Head", { Weight = 0 })
						I[44] = new("IntValue", I[43], "Null")
						I[45] = new("Pose", I[43], "Tongue", { CFrame = CFrame.new(0, -0.0731987, 0.2181645, 1, 0, 0, 0, 0.8508078, 0.525477, 0, -0.525477, 0.8508078) })
		I[46] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[47] = new("Pose", I[46], "HumanoidRootPart", { Weight = 0 })
				I[48] = new("IntValue", I[47], "Null")
				I[49] = new("Pose", I[47], "pelvis", { Weight = 0 })
					I[50] = new("IntValue", I[49], "Null")
					I[51] = new("Pose", I[49], "Head", { Weight = 0 })
						I[52] = new("IntValue", I[51], "Null")
						I[53] = new("Pose", I[51], "Tongue")
	return I[1]
end

return build
