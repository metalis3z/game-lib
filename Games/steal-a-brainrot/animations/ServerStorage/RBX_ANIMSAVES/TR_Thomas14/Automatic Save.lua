-- Generated from animations/ServerStorage/RBX_ANIMSAVES/TR_Thomas14/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, { ["ViralWorkerRef"] = "vw_22b66cd56e" }, { "1779487452" })
		I[2] = new("Keyframe", I[1], "Keyframe", nil, { ["ViralWorkerRef"] = "vw_ef129cd305" })
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 }, { ["ViralWorkerRef"] = "vw_9d2636742d" })
				I[4] = new("Pose", I[3], "LowerTorso", { CFrame = CFrame.new(-0.0001068, -0.6306629, 3.0431213, 0.9999999, 0, 0, 0, -0.0007574, -0.9999997, 0, 0.9999996, -0.0007574) }, { ["ViralWorkerRef"] = "vw_d9f9101b7a" })
					I[5] = new("Pose", I[4], "UpperTorso", { CFrame = CFrame.new(-0.0000153, 0.000061, -0.0000143, 0.9999996, 0.0000001, 0, 0, 0.8660253, 0.5, 0, -0.5000001, 0.8660254) }, { ["ViralWorkerRef"] = "vw_c26b1635b3" })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(-0.0001373, 0.0001831, -0.0000916, 0.0866682, 0.4988492, -0.8623444, -0.9412408, -0.2426219, -0.2349496, -0.3264282, 0.8320361, 0.4485097) }, { ["ViralWorkerRef"] = "vw_e11ec3cd6b" })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 1.0000002, 0.0000001, -0.0000001, 0, 0.9781475, 0.2079117, -0.0000001, -0.2079117, 0.978148) }, { ["ViralWorkerRef"] = "vw_e0cb2a1494" })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(0.000061, -0.0000458, 0.0000076, 0.9781478, 0.2079118, -0.0000001, -0.2079116, 0.9781477, -0.0000001, -0.0000001, -0.0000001, 1.0000005) }, { ["ViralWorkerRef"] = "vw_6a66e1f9cd" })
						I[9] = new("Pose", I[5], "Head", { CFrame = CFrame.new(-0.0000458, -0.000061, -0.000061, 0.9889396, -0.1467533, 0.0214854, 0.0698481, 0.588605, 0.805398, -0.1308414, -0.7949893, 0.5923456) }, { ["ViralWorkerRef"] = "vw_d2627cadfb" })
						I[10] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0.0000153, 0.0001221, 0.0001831, -0.4459366, 0.2104558, 0.8699704, 0.8751909, 0.3062081, 0.3745376, -0.1875682, 0.9284106, -0.3207384) }, { ["ViralWorkerRef"] = "vw_4415087757" })
					I[11] = new("Pose", I[4], "LeftUpperLeg", { CFrame = CFrame.new(-0.0000153, 0.0000305, -0.0000005, 0.8090168, 0.5877851, 0, -0.5877852, 0.8090171, 0, 0, 0, 1.0000001) }, { ["ViralWorkerRef"] = "vw_c89f928014" })
					I[12] = new("Pose", I[4], "RightUpperLeg", { CFrame = CFrame.new(0.0000153, 0, 0.0000005, 0.9510562, -0.3090169, 0, 0.3090169, 0.9510566, 0, 0, 0, 1.0000001) }, { ["ViralWorkerRef"] = "vw_73228462ef" })
		I[13] = new("AnimationRigData", I[1], "TR_Thomas14AnimationRigData", nil, { ["ViralWorkerRef"] = "vw_a9432fbd95" })
	return I[1]
end

return build
