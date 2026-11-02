-- Generated from animations/Workspace/Weapon Models/Test/AnimSaves/Untitled.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Untitled")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[6] = new("IntValue", I[5], "Null")
					I[7] = new("Pose", I[5], "UpperTorso", { CFrame = CFrame.new(0.2111905, 5.0385766, -1.5377865) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 1.6166667 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("IntValue", I[9], "Null")
				I[11] = new("Pose", I[9], "LowerTorso", { Weight = 0 })
					I[12] = new("IntValue", I[11], "Null")
					I[13] = new("Pose", I[11], "UpperTorso", { CFrame = CFrame.new(0.2111905, 6.0182571, -1.5377865, 1, 0, 0, 0, 0.9668128, 0.2554858, 0, -0.2554858, 0.9668128) })
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 1.9833333 })
			I[15] = new("Pose", I[14], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("IntValue", I[15], "Null")
				I[17] = new("Pose", I[15], "LowerTorso", { Weight = 0 })
					I[18] = new("IntValue", I[17], "Null")
					I[19] = new("Pose", I[17], "UpperTorso", { CFrame = CFrame.new(0.2111905, 6.0182571, -1.5377865, 1, 0, 0, 0, 0.9668128, 0.2554858, 0, -0.2554858, 0.9668128) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 3.5 })
			I[21] = new("Pose", I[20], "HumanoidRootPart", { Weight = 0 })
				I[22] = new("IntValue", I[21], "Null")
				I[23] = new("Pose", I[21], "LowerTorso", { Weight = 0 })
					I[24] = new("IntValue", I[23], "Null")
					I[25] = new("Pose", I[23], "UpperTorso", { CFrame = CFrame.new(0.2111905, 5.0385766, -1.5377865) })
	return I[1]
end

return build
