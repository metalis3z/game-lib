-- Generated from animations/ServerStorage/RBX_ANIMSAVES/astrorotrix/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, { ["ViralWorkerRef"] = "vw_e560146b96" }, { "1779488564" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_fc2c15dbc1" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_0f12bcae25" })
				I[4] = new("Pose", I[3], "LowerTorso", { CFrame = CFrame.new(-0.0001221, -1.4289947, 1.0004578, 0.9999998, 0, 0, 0, -0.0000254, -0.9999999, 0, 0.9999999, -0.0000254) }, { ["ViralWorkerRef"] = "vw_a056e82bc2" })
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(0, -0.0000305, -0.000021, 0.9999997, -0.0000001, 0, -0.0000001, 0.8090171, 0.5877854, 0, -0.5877854, 0.8090171) }, { ["ViralWorkerRef"] = "vw_adace5d1a7" })
						I[6] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(-0.0000305, 0, 0.000061, 0.1045284, 0, 0.9945219, 0.3072783, 0.9510715, -0.0322964, -0.9458613, 0.3089709, 0.099414) }, { ["ViralWorkerRef"] = "vw_f6414cf565" })
							I[7] = new("Pose", I[6], "RightLowerArm", { CFrame = CFrame.new(-0.0000305, -0.0001221, -0.0000458, 0.9999998, -0.0000384, -0.0000535, -0.0000005, 0.8090566, -0.5877306, 0.0000659, 0.5877306, 0.8090566) }, { ["ViralWorkerRef"] = "vw_d6ccfb2336" })
								I[8] = new("Pose", I[7], "RightHand", { CFrame = CFrame.new(-0.0000076, 0, 0, 0.8660256, 0.0000001, 0.5000001, 0.0000001, 1, -0.0000004, -0.5000002, -0.0000004, 0.8660256) }, { ["ViralWorkerRef"] = "vw_839f75e223" })
						I[9] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0.0000305, -0.0000305, 0, 0.9999996, -0.0000001, 0, -0.0000001, 0.9510567, 0.309017, 0, -0.3090171, 0.9510567) }, { ["ViralWorkerRef"] = "vw_aac19c4d31" })
		I[10] = new("AnimationRigData", I[1], "astrorotrixAnimationRigData", nil, { ["ViralWorkerRef"] = "vw_83b5c53eb5" })
	return I[1]
end

return build
