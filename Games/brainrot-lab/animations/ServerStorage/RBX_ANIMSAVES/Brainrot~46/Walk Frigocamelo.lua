-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~46/Walk Frigocamelo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Walk Frigocamelo", { Priority = Enum.AnimationPriority.Core }, nil, { "1787506977" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[5] = new("Pose", I[4], "Bone.010")
						I[6] = new("Pose", I[5], "Bone.011", { CFrame = CFrame.new(0.1247651, -0.5551692, 0.0527518, 0.9827263, -0.1379296, 0.1233886, 0.1809951, 0.8553852, -0.4853425, -0.0386017, 0.4992915, 0.8655741) })
					I[7] = new("Pose", I[4], "Bone.007", { CFrame = CFrame.new(0.0000027, -0.0000109, 0, 0.9933665, 0.0290645, -0.1112595, 0.0290644, 0.8726593, 0.4874643, 0.1112595, -0.4874643, 0.8660256) })
						I[8] = new("Pose", I[7], "Bone.008")
					I[9] = new("Pose", I[4], "Bone.001", { Weight = 0 })
						I[10] = new("Pose", I[9], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9659259, -0.1900782, -0.1756633, 0.1900782, 0.9816222, -0.0169842, 0.1756632, -0.0169843, 0.984304) })
							I[11] = new("Pose", I[10], "Bone.004", { Weight = 0 })
								I[12] = new("Pose", I[11], "Bone.005", { CFrame = CFrame.new(0, -0.0000436, -0.0000054, 0.9997413, -0.022209, -0.0049315, 0.0227296, 0.9659279, 0.2578116, -0.0009621, -0.2578569, 0.9661829) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[14] = new("Pose", I[13], "Mesh", { Weight = 0 })
				I[15] = new("Pose", I[14], "Bone", { Weight = 0 })
					I[16] = new("Pose", I[15], "Bone.010", { CFrame = CFrame.new(-0.0175749, -0.2851813, 0, 0.99517, 0.0843862, 0.0501596, -0.0948938, 0.9577885, 0.2713608, -0.0251432, -0.2748099, 0.96117) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[18] = new("Pose", I[17], "Mesh", { Weight = 0 })
				I[19] = new("Pose", I[18], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848017, -0.1736824, 0, 0.1736824, 0.9848017, 0, 0, 0, 1) })
					I[20] = new("Pose", I[19], "Bone.010", { CFrame = CFrame.new(0, 0.0000027, 0, 0.983327, 0.1438392, 0.1112595, -0.1801289, 0.8543609, 0.4874643, -0.0249393, -0.4993778, 0.8660256) })
						I[21] = new("Pose", I[20], "Bone.011", { CFrame = CFrame.new(0.0493349, 0.0065613, -0.000218, 1.0000004, -0.0000137, 0.0000338, 0.0000137, 1.0000001, -0.0000143, -0.0000338, 0.000014, 1.0000002) })
					I[22] = new("Pose", I[19], "Bone.007", { CFrame = CFrame.new(-0.0355039, -0.2834947, 0, 0.9848139, 0.173614, 0, -0.173614, 0.9848139, 0, 0, 0, 1.0000002) })
						I[23] = new("Pose", I[22], "Bone.008", { CFrame = CFrame.new(-0.0626482, -0.2775628, 0.025722, 0.9997095, -0.0085844, -0.022532, -0.0038188, 0.8663132, -0.4994868, 0.0238076, 0.4994277, 0.8660287) })
					I[24] = new("Pose", I[19], "Bone.001", { Weight = 0 })
						I[25] = new("Pose", I[24], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9659232, 0.1900856, 0.1756701, -0.1900856, 0.9816208, -0.0169856, -0.17567, -0.0169856, 0.9843028) })
							I[26] = new("Pose", I[25], "Bone.004", { Weight = 0 })
								I[27] = new("Pose", I[26], "Bone.005", { CFrame = CFrame.new(0, -0.0000872, -0.0000109, 0.9989654, -0.0443996, -0.0098588, 0.0443996, 0.9990139, -0.0002297, 0.0098592, -0.0002079, 0.9999517) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[29] = new("Pose", I[28], "Mesh", { Weight = 0 })
				I[30] = new("Pose", I[29], "Bone", { CFrame = CFrame.new(0, 0, 0, 0.9848077, 0.1736482, 0, -0.1736482, 0.9848077, 0, 0, 0, 1) })
					I[31] = new("Pose", I[30], "Bone.010")
						I[32] = new("Pose", I[31], "Bone.011", { CFrame = CFrame.new(0.1247651, -0.5551692, 0.0527518, 0.9827263, -0.1379296, 0.1233886, 0.1809951, 0.8553852, -0.4853425, -0.0386017, 0.4992915, 0.8655741) })
					I[33] = new("Pose", I[30], "Bone.007", { CFrame = CFrame.new(0.0000027, -0.0000109, 0, 0.9933665, 0.0290645, -0.1112595, 0.0290644, 0.8726593, 0.4874643, 0.1112595, -0.4874643, 0.8660256) })
						I[34] = new("Pose", I[33], "Bone.008")
					I[35] = new("Pose", I[30], "Bone.001", { Weight = 0 })
						I[36] = new("Pose", I[35], "Bone.002", { CFrame = CFrame.new(0, 0, 0, 0.9659259, -0.1900782, -0.1756633, 0.1900782, 0.9816222, -0.0169842, 0.1756632, -0.0169843, 0.984304) })
							I[37] = new("Pose", I[36], "Bone.004", { Weight = 0 })
								I[38] = new("Pose", I[37], "Bone.005", { CFrame = CFrame.new(0, -0.0001308, -0.0000109, 0.9976727, -0.0665654, -0.0147805, 0.0681256, 0.9639131, 0.2573531, -0.0028836, -0.257761, 0.9662047) })
		I[39] = new("Keyframe", I[1], "Keyframe", { Time = 0.7666667 })
			I[40] = new("Pose", I[39], "Mesh", { Weight = 0 })
				I[41] = new("Pose", I[40], "Bone", { Weight = 0 })
					I[42] = new("Pose", I[41], "Bone.007", { CFrame = CFrame.new(0.001, -0.4174778, 0, 0.9947911, 0.0886846, -0.050258, -0.0718873, 0.9599108, 0.2709311, 0.0722706, -0.2659069, 0.9612861) })
		I[43] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
