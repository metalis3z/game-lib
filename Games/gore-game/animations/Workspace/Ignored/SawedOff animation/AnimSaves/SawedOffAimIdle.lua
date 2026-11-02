-- Generated from animations/Workspace/Ignored/SawedOff animation/AnimSaves/SawedOffAimIdle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "SawedOffAimIdle", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso", { Weight = 0 })
					I[5] = new("Pose", I[4], "Right Arm", { CFrame = CFrame.new(-0.1549775, -0.1219346, -0.5208407, -0.24856, -0.8967334, 0.3661791, 0.9683995, -0.2380638, 0.0743506, 0.0205014, 0.3730882, 0.9275693) })
						I[6] = new("Pose", I[5], "Handle", { CFrame = CFrame.new(-0.5971069, -0.6357422, -0.3790741, 0.3473529, 0.0802001, 0.9342986, -0.9070119, -0.2242091, 0.3564544, 0.2380659, -0.9712355, -0.0051372) })
					I[7] = new("Pose", I[4], "Left Arm", { CFrame = CFrame.new(-0.9944426, 0.0015264, -0.5785167, -0.1874423, 0.8949684, -0.4048418, -0.9797728, -0.1409441, 0.1420563, 0.0700758, 0.4232804, 0.9032846) })
					I[8] = new("Pose", I[4], "Head", { CFrame = CFrame.new(0.0000529, 0, 0.0000064, 0.989832, 0, 0.142241, 0, 1, 0, -0.142241, 0, 0.989832) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 4 })
			I[10] = new("Pose", I[9], "HumanoidRootPart", { Weight = 0 })
				I[11] = new("Pose", I[10], "Torso", { Weight = 0 })
					I[12] = new("Pose", I[11], "Right Arm", { CFrame = CFrame.new(-0.1549775, -0.1219346, -0.5208407, -0.24856, -0.8967334, 0.3661791, 0.9683995, -0.2380638, 0.0743506, 0.0205014, 0.3730882, 0.9275693) })
						I[13] = new("Pose", I[12], "Handle", { CFrame = CFrame.new(-0.5971069, -0.6357422, -0.3790741, 0.3473529, 0.0802001, 0.9342986, -0.9070119, -0.2242091, 0.3564544, 0.2380659, -0.9712355, -0.0051372) })
					I[14] = new("Pose", I[11], "Left Arm", { CFrame = CFrame.new(-0.9944426, 0.0015264, -0.5785167, -0.1874423, 0.8949684, -0.4048418, -0.9797728, -0.1409441, 0.1420563, 0.0700758, 0.4232804, 0.9032846) })
					I[15] = new("Pose", I[11], "Head", { CFrame = CFrame.new(0.0000529, 0, 0.0000064, 0.989832, 0, 0.142241, 0, 1, 0, -0.142241, 0, 0.989832) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.5666667 })
			I[17] = new("Pose", I[16], "HumanoidRootPart", { Weight = 0 })
				I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
					I[19] = new("Pose", I[18], "Left Arm", { CFrame = CFrame.new(-0.9944458, 0.0015278, -0.5785217, -0.1845963, 0.8953381, -0.405332, -0.980313, -0.1383317, 0.1408932, 0.0700769, 0.4233605, 0.903247) })
					I[20] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.1549683, -0.1219349, -0.5208435, -0.2458597, -0.8973838, 0.3664088, 0.9690881, -0.2355704, 0.0733134, 0.0205248, 0.3731072, 0.9275612) })
		I[21] = new("Keyframe", I[1], "Keyframe", { Time = 1.1333333 })
			I[22] = new("Pose", I[21], "HumanoidRootPart", { Weight = 0 })
				I[23] = new("Pose", I[22], "Torso", { Weight = 0 })
					I[24] = new("Pose", I[23], "Left Arm", { CFrame = CFrame.new(-0.9944458, 0.0015278, -0.5785217, -0.1761757, 0.8965048, -0.4064988, -0.9818654, -0.1306721, 0.13735, 0.0700169, 0.4233249, 0.9032683) })
					I[25] = new("Pose", I[23], "Right Arm", { CFrame = CFrame.new(-0.1549683, -0.1219349, -0.5208435, -0.2374164, -0.8993739, 0.3670968, 0.971191, -0.2277482, 0.070134, 0.0205289, 0.3731721, 0.927535) })
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 1.7 })
			I[27] = new("Pose", I[26], "HumanoidRootPart", { Weight = 0 })
				I[28] = new("Pose", I[27], "Torso", { Weight = 0 })
					I[29] = new("Pose", I[28], "Left Arm", { CFrame = CFrame.new(-0.9944458, 0.0015278, -0.5785217, -0.1670341, 0.8976839, -0.4077538, -0.9834594, -0.122313, 0.1335927, 0.0700504, 0.4233239, 0.9032662) })
					I[30] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(-0.1549683, -0.1219349, -0.5208435, -0.2284013, -0.9014668, 0.3676828, 0.9733506, -0.219404, 0.0667128, 0.0205316, 0.3731215, 0.9275553) })
		I[31] = new("Keyframe", I[1], "Keyframe", { Time = 2.3 })
			I[32] = new("Pose", I[31], "HumanoidRootPart", { Weight = 0 })
				I[33] = new("Pose", I[32], "Torso", { Weight = 0 })
					I[34] = new("Pose", I[33], "Left Arm", { CFrame = CFrame.new(-0.9944458, 0.0015278, -0.5785217, -0.1726542, 0.8969738, -0.406975, -0.982484, -0.1274177, 0.1359779, 0.0701128, 0.4233235, 0.9032615) })
					I[35] = new("Pose", I[33], "Right Arm", { CFrame = CFrame.new(-0.1549683, -0.1219349, -0.5208435, -0.233964, -0.9001976, 0.3672947, 0.9720301, -0.2245276, 0.0688844, 0.0204582, 0.3731379, 0.9275503) })
		I[36] = new("Keyframe", I[1], "Keyframe", { Time = 2.8666666 })
			I[37] = new("Pose", I[36], "HumanoidRootPart", { Weight = 0 })
				I[38] = new("Pose", I[37], "Torso", { Weight = 0 })
					I[39] = new("Pose", I[38], "Left Arm", { CFrame = CFrame.new(-0.9944458, 0.0015278, -0.5785217, -0.1763043, 0.896488, -0.4064803, -0.9818357, -0.1307487, 0.1374907, 0.070112, 0.423337, 0.9032553) })
					I[40] = new("Pose", I[38], "Right Arm", { CFrame = CFrame.new(-0.1549683, -0.1219349, -0.5208435, -0.2375427, -0.8993689, 0.367028, 0.9711614, -0.2278528, 0.0702087, 0.0204848, 0.3731209, 0.9275566) })
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 3.4333334 })
			I[42] = new("Pose", I[41], "HumanoidRootPart", { Weight = 0 })
				I[43] = new("Pose", I[42], "Torso", { Weight = 0 })
					I[44] = new("Pose", I[43], "Left Arm", { CFrame = CFrame.new(-0.9944458, 0.0015278, -0.5785217, -0.1760668, 0.8965226, -0.4065068, -0.9818832, -0.1305631, 0.1373264, 0.0700414, 0.4233209, 0.9032683) })
					I[45] = new("Pose", I[43], "Right Arm", { CFrame = CFrame.new(-0.1549683, -0.1219349, -0.5208435, -0.237312, -0.8993998, 0.3671008, 0.971217, -0.2276437, 0.0701135, 0.0205081, 0.3731733, 0.927535) })
	return I[1]
end

return build
