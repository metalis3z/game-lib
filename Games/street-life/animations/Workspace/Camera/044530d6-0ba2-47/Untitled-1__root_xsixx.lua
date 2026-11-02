-- Generated from animations/Workspace/Camera/044530d6-0ba2-47/Untitled-1__root_xsixx.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Untitled-1__root|xsixx", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "RightLowerArm", { Weight = 0 })
				I[4] = new("Pose", I[3], "RightHand")
			I[5] = new("Pose", I[2], "LeftUpperArm", { Weight = 0 })
				I[6] = new("Pose", I[5], "LeftLowerArm")
			I[7] = new("Pose", I[2], "UpperTorso", { Weight = 0 })
				I[8] = new("Pose", I[7], "LeftUpperArm")
				I[9] = new("Pose", I[7], "RightUpperArm")
			I[10] = new("Pose", I[2], "RightUpperArm", { Weight = 0 })
				I[11] = new("Pose", I[10], "RightLowerArm")
			I[12] = new("Pose", I[2], "LeftLowerArm", { Weight = 0 })
				I[13] = new("Pose", I[12], "LeftHand")
		I[14] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 })
			I[15] = new("Pose", I[14], "UpperTorso", { Weight = 0 })
				I[16] = new("Pose", I[15], "RightUpperArm", { CFrame = CFrame.new(-0.0282039, 0.1418095, -0.2202663, 0.9606948, -0.1920049, -0.2004983, -0.0287799, 0.6494617, -0.7598495, 0.2761108, 0.7357538, 0.6184086) })
				I[17] = new("Pose", I[15], "LeftUpperArm", { CFrame = CFrame.new(0.0259023, 0.0909672, -0.369821, 0.9778923, -0.1909731, 0.0851816, 0.1863651, 0.6111891, -0.7692307, 0.0948403, 0.7680997, 0.6332678) })
		I[18] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[19] = new("Pose", I[18], "RightLowerArm", { Weight = 0 })
				I[20] = new("Pose", I[19], "RightHand", { CFrame = CFrame.new(-0.0035992, 0.0123231, -0.0171297, 0.9143746, -0.1461521, -0.3775694, -0.0514987, 0.8830111, -0.4665184, 0.4015805, 0.4460169, 0.7998763) })
			I[21] = new("Pose", I[18], "LeftUpperArm", { Weight = 0 })
				I[22] = new("Pose", I[21], "LeftLowerArm", { CFrame = CFrame.new(0, 0.0126468, 0.0033817, 0.9848077, -0.1736482, 0, 0.1422442, 0.8067071, -0.5735767, 0.0996005, 0.5648627, 0.8191519) })
			I[23] = new("Pose", I[18], "UpperTorso", { Weight = 0 })
				I[24] = new("Pose", I[23], "LeftUpperArm", { CFrame = CFrame.new(0.0314105, 0.0730814, 0.0474626, 0.6684885, -0.7409559, 0.0640879, -0.7208351, -0.6242933, 0.3010888, -0.1830839, -0.2474713, -0.95144) })
				I[25] = new("Pose", I[23], "RightUpperArm", { CFrame = CFrame.new(-0.1067288, 0.0606155, 0.1155055, 0.8836386, 0.440368, 0.1589307, 0.2526109, -0.7342878, 0.6300868, 0.3941708, -0.5166214, -0.7600869) })
			I[26] = new("Pose", I[18], "LeftLowerArm", { Weight = 0 })
				I[27] = new("Pose", I[26], "LeftHand", { CFrame = CFrame.new(0, 0.0053203, -0.0019805, 1, 0, 0, 0, 0.976296, -0.2164397, 0, 0.2164397, 0.976296) })
			I[28] = new("Pose", I[18], "RightUpperArm", { Weight = 0 })
				I[29] = new("Pose", I[28], "RightLowerArm", { CFrame = CFrame.new(0, 0.0057486, 0.0010106, 0.8191521, 0.5713938, 0.0499903, -0.5648625, 0.8187718, -0.1026785, -0.0996006, 0.0558716, 0.9934576) })
		I[30] = new("Keyframe", I[1], "Keyframe", { Time = 0.5 })
			I[31] = new("Pose", I[30], "RightLowerArm", { Weight = 0 })
				I[32] = new("Pose", I[31], "RightHand", { CFrame = CFrame.new(0, 0, 0, 0.4023955, 0.5949772, -0.6957585, 0.5480478, 0.452207, 0.7036706, 0.7332949, -0.6644629, -0.1441099) })
			I[33] = new("Pose", I[30], "LeftUpperArm", { Weight = 0 })
				I[34] = new("Pose", I[33], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660253, -0.5000002, 0, 0.5000002, 0.8660253) })
			I[35] = new("Pose", I[30], "UpperTorso", { Weight = 0 })
				I[36] = new("Pose", I[35], "LeftUpperArm", { CFrame = CFrame.new(0, -0.0000001, -0.0000001, 0.7355826, -0.5836284, -0.3439418, -0.0034658, 0.5044631, -0.8634263, 0.6774262, 0.6363134, 0.3690515) })
				I[37] = new("Pose", I[35], "RightUpperArm", { CFrame = CFrame.new(0, 0, -0.0000001, 0.3213938, 0.341535, 0.8832099, 0.7660444, 0.4545194, -0.4545196, -0.5566704, 0.8226578, -0.1155513) })
			I[38] = new("Pose", I[30], "LeftLowerArm", { Weight = 0 })
				I[39] = new("Pose", I[38], "LeftHand", { CFrame = CFrame.new(0, 0, 0, 0.8660254, -0.5, 0, 0.409576, 0.7094064, 0.5735766, -0.2867883, -0.4967319, 0.8191519) })
			I[40] = new("Pose", I[30], "RightUpperArm", { Weight = 0 })
				I[41] = new("Pose", I[40], "RightLowerArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396925, -0.3420203, 0, 0.3420203, 0.9396925) })
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 1 })
			I[43] = new("Pose", I[42], "RightLowerArm", { Weight = 0 })
				I[44] = new("Pose", I[43], "RightHand", { CFrame = CFrame.new(0, 0, 0, 0.4023955, 0.5949772, -0.6957585, 0.5480478, 0.452207, 0.7036706, 0.7332949, -0.6644629, -0.1441099) })
			I[45] = new("Pose", I[42], "LeftUpperArm", { Weight = 0 })
				I[46] = new("Pose", I[45], "LeftLowerArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.8660253, -0.5000002, 0, 0.5000002, 0.8660253) })
			I[47] = new("Pose", I[42], "UpperTorso", { Weight = 0 })
				I[48] = new("Pose", I[47], "LeftUpperArm", { CFrame = CFrame.new(0, -0.0000001, -0.0000001, 0.7355826, -0.5836284, -0.3439418, -0.0034658, 0.5044631, -0.8634263, 0.6774262, 0.6363134, 0.3690515) })
				I[49] = new("Pose", I[47], "RightUpperArm", { CFrame = CFrame.new(0, 0, -0.0000001, 0.3213938, 0.341535, 0.8832099, 0.7660444, 0.4545194, -0.4545196, -0.5566704, 0.8226578, -0.1155513) })
			I[50] = new("Pose", I[42], "LeftLowerArm", { Weight = 0 })
				I[51] = new("Pose", I[50], "LeftHand", { CFrame = CFrame.new(0, 0, 0, 0.8660254, -0.5, 0, 0.409576, 0.7094064, 0.5735766, -0.2867883, -0.4967319, 0.8191519) })
			I[52] = new("Pose", I[42], "RightUpperArm", { Weight = 0 })
				I[53] = new("Pose", I[52], "RightLowerArm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9396925, -0.3420203, 0, 0.3420203, 0.9396925) })
	return I[1]
end

return build
