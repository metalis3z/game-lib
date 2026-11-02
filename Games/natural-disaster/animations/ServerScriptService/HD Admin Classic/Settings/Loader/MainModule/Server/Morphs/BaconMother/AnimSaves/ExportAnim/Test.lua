-- Generated from animations/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Morphs/BaconMother/AnimSaves/ExportAnim/Test.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Test")
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { CFrame = CFrame.new(0, 0, -0.6) })
					I[5] = new("Pose", I[4], "UpperTorso")
						I[6] = new("Pose", I[5], "Head")
							I[7] = new("Decal", I[6], "face")
						I[8] = new("Pose", I[5], "LeftUpperArm")
							I[9] = new("Pose", I[8], "LeftLowerArm")
						I[10] = new("Pose", I[5], "RightUpperArm")
							I[11] = new("Pose", I[10], "RightLowerArm")
					I[12] = new("Pose", I[4], "RightUpperLeg")
						I[13] = new("Pose", I[12], "RightLowerLeg")
							I[14] = new("Pose", I[13], "RightFoot")
					I[15] = new("Pose", I[4], "LeftUpperLeg")
						I[16] = new("Pose", I[15], "LeftLowerLeg")
							I[17] = new("Pose", I[16], "LeftFoot")
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "LowerTorso", { CFrame = CFrame.new(0, 0, -0.6) })
					I[21] = new("Pose", I[20], "UpperTorso")
						I[22] = new("Pose", I[21], "Head")
							I[23] = new("Decal", I[22], "face")
						I[24] = new("Pose", I[21], "LeftUpperArm")
							I[25] = new("Pose", I[24], "LeftLowerArm")
						I[26] = new("Pose", I[21], "RightUpperArm")
							I[27] = new("Pose", I[26], "RightLowerArm")
					I[28] = new("Pose", I[20], "RightUpperLeg")
						I[29] = new("Pose", I[28], "RightLowerLeg")
							I[30] = new("Pose", I[29], "RightFoot")
					I[31] = new("Pose", I[20], "LeftUpperLeg")
						I[32] = new("Pose", I[31], "LeftLowerLeg")
							I[33] = new("Pose", I[32], "LeftFoot")
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 1.8 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "LowerTorso", { CFrame = CFrame.new(1.0528117, 0, -0.6) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 1.85 })
			I[38] = new("Pose", I[37], "LowerTorso", { Weight = 0 })
				I[39] = new("Pose", I[38], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.5623242, 0, 0.8269169, 0, 1, 0, -0.8269169, 0, 0.5623242) })
					I[40] = new("Pose", I[39], "Head", { CFrame = CFrame.new(0, -0.1272812, 0, 0.6656934, 0, 0.7462254, 0, 1, 0, -0.7462254, 0, 0.6656934) })
						I[41] = new("Decal", I[40], "face")
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 4.8000002 })
			I[43] = new("Pose", I[42], "LowerTorso", { Weight = 0 })
				I[44] = new("Pose", I[43], "UpperTorso", { CFrame = CFrame.new(0, 0, 0, 0.476729, 0, 0.8790503, 0, 1, 0, -0.8790503, 0, 0.476729) })
		I[45] = new("Keyframe", I[1], "KF5", { Time = 5 })
	return I[1]
end

return build
