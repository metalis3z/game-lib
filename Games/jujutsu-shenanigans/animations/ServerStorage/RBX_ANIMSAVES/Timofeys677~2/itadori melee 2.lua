-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677~2/itadori melee 2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "itadori melee 2", { Loop = false }, nil, { "1735483760" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.5101331, -0.821823, 0.2537144, 0.8590269, 0.4721286, -0.1979075, 0.0428591, 0.3189067, 0.9468166) })
					I[5] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.2957668, -0.6919464, 0.2167469, -0.6612029, 0.7068504, -0.2513427, -0.6066544, -0.3066847, 0.7334269, 0.4413401, 0.6374222, 0.6315947) })
					I[6] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(0.919649, -0.5137282, 0.3581308, -0.3476158, -0.9374024, -0.0209753, -0.0691463, 0.0033192, 0.9976009, -0.9350838, 0.3482324, -0.0659717) })
					I[7] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0, -0.0000001, -0.0000005, 0.7443246, 0.6637706, -0.073414, -0.6220364, 0.7290979, 0.285459, 0.2430053, -0.166808, 0.9555749) })
		I[8] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[9] = new("Pose", I[8], "HumanoidRootPart", { Weight = 0 })
				I[10] = new("Pose", I[9], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9495261, -0.0936007, 0.2993972, 0.2193978, 0.8803197, -0.4205969, -0.2241971, 0.465055, 0.8564225) })
					I[11] = new("Pose", I[10], "Left Arm", { CFrame = CFrame.new(1.1954361, -0.5761166, 0.0096334, -0.4427714, 0.6150128, 0.6524665, -0.8775728, -0.4464944, -0.1746672, 0.1839001, -0.6499245, 0.7374136) })
					I[12] = new("Pose", I[10], "Right Arm", { CFrame = CFrame.new(0.9196478, -0.5137284, 0.3581307, 0.2487936, -0.8372949, -0.4868663, 0.2658059, -0.4243476, 0.8656073, -0.9313693, -0.3447694, 0.116983) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[14] = new("Pose", I[13], "HumanoidRootPart", { Weight = 0 })
				I[15] = new("Pose", I[14], "Torso", { Weight = 0 })
					I[16] = new("Pose", I[15], "Left Arm", { CFrame = CFrame.new(0.297919, -0.4297308, -0.4272515, -0.3292489, 0.6825559, 0.6524665, -0.9417735, -0.2873221, -0.1746672, 0.068248, -0.6719847, 0.7374136) })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[18] = new("Pose", I[17], "HumanoidRootPart", { Weight = 0 })
				I[19] = new("Pose", I[18], "Torso", { CFrame = CFrame.new(0.5901277, 0.0146849, 0.1073918, 0.0329909, 0.983547, -0.1776139, -0.9984531, 0.0244754, -0.0499225, -0.044754, 0.1789862, 0.9828331) })
					I[20] = new("Pose", I[19], "Left Arm", { CFrame = CFrame.new(-0.6898364, -0.039657, 1.1267529, -0.2685073, 0.7086545, 0.6524665, -0.9632315, -0.2041479, -0.1746672, 0.009421, -0.6753758, 0.7374136) })
					I[21] = new("Pose", I[19], "Right Arm", { CFrame = CFrame.new(0.2667455, -0.14475, 0.894389, -0.7017074, -0.5201613, -0.4868663, -0.3078454, -0.3949113, 0.8656073, -0.6425244, 0.7572827, 0.116983) })
					I[22] = new("Pose", I[19], "Head", { CFrame = CFrame.new(0, -0.0000001, -0.0000005, 0.2870152, -0.9551088, -0.073414, 0.9236711, 0.2556263, 0.285459, -0.2538778, -0.1497415, 0.9555749) })
			I[23] = new("KeyframeMarker", I[17], "hit")
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { Weight = 0 })
					I[27] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.6995909, -0.3343693, 0.2384955, -0.4151802, 0.7797897, 0.4685659, -0.9057437, -0.4025324, -0.1326519, 0.0851722, -0.479475, 0.8734126) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { CFrame = CFrame.new(0.2901269, 0.0146767, 0.107392, 0.3673941, 0.9249543, -0.0973693, -0.929868, 0.3674545, -0.0179651, 0.0191618, 0.097141, 0.9950862) })
					I[31] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.1427039, -0.7225575, -0.0283628, -0.4894674, 0.7892848, 0.3707439, -0.8652975, -0.4923064, -0.0943108, 0.1080815, -0.3669659, 0.9239342) })
					I[32] = new("Pose", I[30], "Right Arm", { CFrame = CFrame.new(0.1697665, -0.1958999, 0.460824, -0.2796818, -0.9572001, -0.0744699, 0.3354186, -0.1700931, 0.9265864, -0.8995956, 0.234171, 0.3686348) })
					I[33] = new("Pose", I[30], "Head", { CFrame = CFrame.new(0, 0, 0, 0.5735765, -0.816035, 0.0713938, 0.8191521, 0.5713938, -0.0499905, 0, 0.0871557, 0.9961947) })
		I[34] = new("Keyframe", I[1], "Keyframe", { Time = 0.0333333 })
			I[35] = new("Pose", I[34], "HumanoidRootPart", { Weight = 0 })
				I[36] = new("Pose", I[35], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.4597923, -0.8155338, 0.3514195, 0.8876322, 0.4338605, -0.1545123, -0.0264571, 0.3829749, 0.9233798) })
		I[37] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[38] = new("Pose", I[37], "HumanoidRootPart", { Weight = 0 })
				I[39] = new("Pose", I[38], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.4571502, -0.7976969, 0.3933108, 0.8862999, 0.3717666, -0.2761558, 0.0740688, 0.474836, 0.8769519) })
			I[40] = new("KeyframeMarker", I[37], "swing")
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[42] = new("Pose", I[41], "HumanoidRootPart", { Weight = 0 })
				I[43] = new("Pose", I[42], "Torso", { CFrame = CFrame.new(0.4401285, 0.0146812, 0.1073918, 0.2026011, 0.9313543, -0.3025432, -0.9792179, 0.1897654, -0.0715659, -0.0092409, 0.310755, 0.9504452) })
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[45] = new("Pose", I[44], "HumanoidRootPart", { Weight = 0 })
				I[46] = new("Pose", I[45], "Torso", { Weight = 0 })
					I[47] = new("Pose", I[46], "Right Arm", { CFrame = CFrame.new(1.276985, 0.0763672, -0.7068097, -0.5391604, -0.8048501, -0.2480371, -0.1517624, -0.1968428, 0.9686182, -0.8284167, 0.5598832, -0.0160161) })
		I[48] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 })
			I[49] = new("Pose", I[48], "HumanoidRootPart", { Weight = 0 })
				I[50] = new("Pose", I[49], "Torso", { Weight = 0 })
					I[51] = new("Pose", I[50], "Right Arm", { CFrame = CFrame.new(1.0625834, -0.2776897, -0.0678447, -0.7921917, -0.4766405, -0.3811118, -0.27208, -0.2831466, 0.9196742, -0.5462645, 0.8322511, 0.094622) })
		I[52] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[53] = new("KeyframeMarker", I[52], "swing")
	return I[1]
end

return build
