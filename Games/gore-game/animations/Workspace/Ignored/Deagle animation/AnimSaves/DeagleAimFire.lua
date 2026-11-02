-- Generated from animations/Workspace/Ignored/Deagle animation/AnimSaves/DeagleAimFire.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "DeagleAimFire", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "CameraPart", { CFrame = CFrame.new(-0.0000156, 0.0000148, 0.0000013, 0.9924872, 0.0006281, 0.1223472, 0.0020066, 0.9997687, -0.0214102, -0.1223323, 0.0214949, 0.9922564) })
			I[4] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[5] = new("Pose", I[4], "Torso", { Weight = 0 })
					I[6] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.6087837, -0.4089661, -0.2435275, 0.3650925, -0.8985558, -0.8082607, -0.588484, -0.0200516, -0.536106, 0.721384, 0.4384013) })
					I[7] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, -0.0000019, 0.9867194, 0, 0.162434, 0, 1, 0, -0.162434, 0, 0.9867194) })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.098053, -0.8410645, -0.2422699, -0.9139158, 0.3256736, 0.9661013, -0.2581024, -0.0056087, 0.089183, 0.3132748, 0.9454656) })
						I[9] = new("Pose", I[8], "Handle", { CFrame = CFrame.new(-0.2250671, -0.9547119, -0.3032837, 0.9491492, -0.0216288, -0.3140829, 0.2995768, -0.2446854, 0.9221621, -0.0967967, -0.9693613, -0.2257634) })
							I[10] = new("Pose", I[9], "Slide")
			I[11] = new("Pose", I[2], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
			I[12] = new("Pose", I[2], "S1", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[14] = new("Pose", I[13], "CameraPart", { CFrame = CFrame.new(-0.0000117, 0.0000178, 0.0000012, 0.9924871, 0.011286, 0.1218275, 0.0019945, 0.9941117, -0.1083424, -0.1223329, 0.1077714, 0.9866205) })
			I[15] = new("Pose", I[13], "HumanoidRootPart", { Weight = 0 })
				I[16] = new("Pose", I[15], "Torso", { Weight = 0 })
					I[17] = new("Pose", I[16], "Left Arm", { CFrame = CFrame.new(-0.4998779, -0.578783, -0.4189758, -0.2435275, 0.3650925, -0.8985558, -0.8082607, -0.588484, -0.0200516, -0.536106, 0.721384, 0.4384013) })
					I[18] = new("Pose", I[16], "Right Arm", { CFrame = CFrame.new(0.0656128, -0.0680523, -0.8310547, -0.2422699, -0.9139158, 0.3256736, 0.9661013, -0.2581024, -0.0056087, 0.089183, 0.3132748, 0.9454656) })
						I[19] = new("Pose", I[18], "Handle", { CFrame = CFrame.new(-0.2078857, -1.0201416, -0.3581543, 0.948716, -0.0580932, -0.3107459, 0.3004443, -0.1400931, 0.943455, -0.0983416, -0.9884328, -0.1154548) })
							I[20] = new("Pose", I[19], "Slide", { CFrame = CFrame.new(-0.0004272, -0.0000992, 0.1299438) })
			I[21] = new("Pose", I[13], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
			I[22] = new("Pose", I[13], "S1", { CFrame = CFrame.new(-0.0003586, 0.0000033, -0.1501944) })
		I[23] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[24] = new("Pose", I[23], "CameraPart", { CFrame = CFrame.new(-0.0000145, 0.0000222, 0.0000006, 0.9924869, 0.0179956, 0.1210204, 0.0020238, 0.9865744, -0.1632998, -0.1223343, 0.1623179, 0.9791257) })
			I[25] = new("Pose", I[23], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { Weight = 0 })
					I[27] = new("Pose", I[26], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9994813, -0.0007402, 0.0321948, -0.0022921, 0.995565, 0.0940481, -0.0321216, -0.0940731, 0.995047) })
					I[28] = new("Pose", I[26], "Right Arm", { Weight = 0 })
						I[29] = new("Pose", I[28], "Handle", { CFrame = CFrame.new(-0.1784973, -1.0166626, -0.3709564, 0.9440224, -0.013801, -0.3295925, 0.3285797, -0.0493277, 0.9431872, -0.029275, -0.9986872, -0.0420316) })
							I[30] = new("Pose", I[29], "Slide", { CFrame = CFrame.new(-0.0012207, 0.0001526, 0.2704273) })
			I[31] = new("Pose", I[23], "S1", { CFrame = CFrame.new(0, 0, -0.0000001) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[33] = new("Pose", I[32], "CameraPart", { CFrame = CFrame.new(-0.0000156, 0.0000148, 0.0000013, 0.9924872, 0.0006281, 0.1223472, 0.0020066, 0.9997687, -0.0214102, -0.1223323, 0.0214949, 0.9922564) })
			I[34] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[35] = new("Pose", I[34], "Torso", { Weight = 0 })
					I[36] = new("Pose", I[35], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.578783, -0.4189758, -0.1970824, 0.398017, -0.8959584, -0.820849, -0.5666924, -0.0711845, -0.5360652, 0.7214172, 0.4383966) })
					I[37] = new("Pose", I[35], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.0680523, -0.8310547, -0.1869212, -0.9271251, 0.3248075, 0.9783242, -0.2056768, -0.0240711, 0.0891222, 0.3132675, 0.9454738) })
						I[38] = new("Pose", I[37], "Handle", { CFrame = CFrame.new(-0.180481, -1.0880737, -0.3070831, 0.9491492, -0.0216288, -0.3140829, 0.2995768, -0.2446854, 0.9221621, -0.0967967, -0.9693613, -0.2257634) })
							I[39] = new("Pose", I[38], "Slide", { CFrame = CFrame.new(-0.0006104, 0.0000753, 0.0349219) })
			I[40] = new("Pose", I[32], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
		I[41] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[42] = new("Pose", I[41], "CameraPart", { CFrame = CFrame.new(-0.0000156, 0.0000148, 0.0000013, 0.9924872, 0.0006281, 0.1223472, 0.0020066, 0.9997687, -0.0214102, -0.1223323, 0.0214949, 0.9922564) })
			I[43] = new("Pose", I[41], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "Torso", { Weight = 0 })
					I[45] = new("Pose", I[44], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.6087837, -0.4089661, -0.2435275, 0.3650925, -0.8985558, -0.8082607, -0.588484, -0.0200516, -0.536106, 0.721384, 0.4384013) })
					I[46] = new("Pose", I[44], "Head", { CFrame = CFrame.new(0, 0, -0.0000019, 0.9867194, 0, 0.162434, 0, 1, 0, -0.162434, 0, 0.9867194) })
					I[47] = new("Pose", I[44], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.098053, -0.8410645, -0.2422699, -0.9139158, 0.3256736, 0.9661013, -0.2581024, -0.0056087, 0.089183, 0.3132748, 0.9454656) })
						I[48] = new("Pose", I[47], "Handle", { CFrame = CFrame.new(-0.2250671, -0.9547119, -0.3032837, 0.9491492, -0.0216288, -0.3140829, 0.2995768, -0.2446854, 0.9221621, -0.0967967, -0.9693613, -0.2257634) })
							I[49] = new("Pose", I[48], "Slide")
			I[50] = new("Pose", I[41], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
			I[51] = new("Pose", I[41], "S1", { CFrame = CFrame.new(0, 0, -0.0000001) })
	return I[1]
end

return build
