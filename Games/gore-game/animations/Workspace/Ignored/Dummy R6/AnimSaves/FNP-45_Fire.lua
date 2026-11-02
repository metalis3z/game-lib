-- Generated from animations/Workspace/Ignored/Dummy R6/AnimSaves/FNP-45_Fire.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "FNP-45_Fire", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.167503, -0.4110038, -0.278338, -0.2160022, -0.8807123, 0.4215316, 0.9685844, -0.1387866, 0.2063557, -0.1232371, 0.4528622, 0.8830223) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[7] = new("Pose", I[6], "Magazine")
							I[8] = new("Pose", I[6], "Slider")
					I[9] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.3302573, -0.5996149, -0.7238461, 0.1019129, 0.6147514, -0.7821089, -0.8293875, -0.3816135, -0.4080285, -0.5492996, 0.6902547, 0.4709759) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso", { Weight = 0 })
					I[13] = new("Pose", I[12], "Right Arm", { CFrame = CFrame.new(0.0304655, -0.4983717, -0.2479954, -0.2317576, -0.8681994, 0.4387695, 0.9720494, -0.1892854, 0.1388938, -0.0375349, 0.4586952, 0.8878006) })
						I[14] = new("Pose", I[13], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[15] = new("Pose", I[14], "Magazine")
							I[16] = new("Pose", I[14], "Slider", { CFrame = CFrame.new(-0.0023804, 0.0035095, -0.2943115) })
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.2820764, -0.6262339, -0.6653283, 0.0762112, 0.5688176, -0.8189252, -0.8863168, -0.3375955, -0.3169733, -0.4567654, 0.749984, 0.478424) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[19] = new("Pose", I[18], "HumanoidRootPart", { Weight = 0 })
				I[20] = new("Pose", I[19], "Torso", { Weight = 0 })
					I[21] = new("Pose", I[20], "Right Arm", { CFrame = CFrame.new(0.1674038, -0.4110188, -0.2783743, -0.2078953, -0.8844895, 0.4176816, 0.9671193, -0.1219172, 0.2231963, -0.1464922, 0.4503494, 0.8807528) })
						I[22] = new("Pose", I[21], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[23] = new("Pose", I[22], "Magazine")
							I[24] = new("Pose", I[22], "Slider")
					I[25] = new("Pose", I[20], "Left Arm", { CFrame = CFrame.new(-0.3302319, -0.599607, -0.7238358, 0.1156062, 0.6147596, -0.780196, -0.8221807, -0.3815191, -0.4224474, -0.5573634, 0.6902996, 0.4613376) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.167503, -0.4110038, -0.278338, -0.2160022, -0.8807123, 0.4215316, 0.9685844, -0.1387866, 0.2063557, -0.1232371, 0.4528622, 0.8830223) })
						I[30] = new("Pose", I[29], "Handle", { CFrame = CFrame.new(-0.1232697, -0.9380424, -0.2978051, -0.8809683, 0.2015, 0.4281277, -0.4597734, -0.1507081, -0.8751549, -0.1118214, -0.9678251, 0.2254128) })
							I[31] = new("Pose", I[30], "Magazine")
							I[32] = new("Pose", I[30], "Slider")
					I[33] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.3302573, -0.5996149, -0.7238461, 0.1019129, 0.6147514, -0.7821089, -0.8293875, -0.3816135, -0.4080285, -0.5492996, 0.6902547, 0.4709759) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.0333333 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { Weight = 0 })
					I[37] = new("Pose", I[36], "Right Arm", { Weight = 0 })
						I[38] = new("Pose", I[37], "Handle", { Weight = 0 })
							I[39] = new("Pose", I[38], "Slider", { CFrame = CFrame.new(0.0001831, 0.0027161, -0.24646) })
		I[40] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[41] = new("Pose", I[40], "HumanoidRootPart", { Weight = 0 })
				I[42] = new("Pose", I[41], "Torso", { Weight = 0 })
					I[43] = new("Pose", I[42], "Right Arm", { Weight = 0 })
						I[44] = new("Pose", I[43], "Handle", { Weight = 0 })
							I[45] = new("Pose", I[44], "Slider", { CFrame = CFrame.new(-0.0041504, 0.0040588, -0.0435791) })
	return I[1]
end

return build
