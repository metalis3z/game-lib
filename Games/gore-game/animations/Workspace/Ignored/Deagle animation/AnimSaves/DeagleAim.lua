-- Generated from animations/Workspace/Ignored/Deagle animation/AnimSaves/DeagleAim.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "DeagleAim", { Priority = Enum.AnimationPriority.Movement })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "CameraPart", { CFrame = CFrame.new(-0.0000156, 0.0000148, 0.0000013, 0.9924872, 0.0006281, 0.1223472, 0.0020066, 0.9997687, -0.0214102, -0.1223323, 0.0214949, 0.9922564) })
			I[4] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[5] = new("Pose", I[4], "Torso", { Weight = 0 })
					I[6] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.098053, -0.8410645, -0.2422699, -0.9139158, 0.3256736, 0.9661013, -0.2581024, -0.0056087, 0.089183, 0.3132748, 0.9454656) })
						I[7] = new("Pose", I[6], "Handle", { CFrame = CFrame.new(-0.2250671, -0.9547119, -0.3032837, 0.9491492, -0.0216288, -0.3140829, 0.2995768, -0.2446854, 0.9221621, -0.0967967, -0.9693613, -0.2257634) })
					I[8] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.6087837, -0.4089661, -0.2435275, 0.3650925, -0.8985558, -0.8082607, -0.588484, -0.0200516, -0.536106, 0.721384, 0.4384013) })
					I[9] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, -0.0000019, 0.9867194, 0, 0.162434, 0, 1, 0, -0.162434, 0, 0.9867194) })
			I[10] = new("Pose", I[2], "S1", { CFrame = CFrame.new(0, 0, -0.0000001) })
			I[11] = new("Pose", I[2], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 4 })
			I[13] = new("Pose", I[12], "CameraPart", { CFrame = CFrame.new(-0.0000156, 0.0000148, 0.0000013, 0.9924872, 0.0006281, 0.1223472, 0.0020066, 0.9997687, -0.0214102, -0.1223323, 0.0214949, 0.9922564) })
			I[14] = new("Pose", I[12], "HumanoidRootPart", { Weight = 0 })
				I[15] = new("Pose", I[14], "Torso", { Weight = 0 })
					I[16] = new("Pose", I[15], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.070219, -0.8310547, -0.2422822, -0.9139268, 0.3256335, 0.9660428, -0.2583081, -0.0062026, 0.0897825, 0.313073, 0.9454758) })
						I[17] = new("Pose", I[16], "Handle", { CFrame = CFrame.new(-0.2254615, -0.9574534, -0.3128923, 0.9491492, -0.0216288, -0.3140829, 0.2995768, -0.2446854, 0.9221621, -0.0967967, -0.9693613, -0.2257634) })
					I[18] = new("Pose", I[15], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.5809498, -0.4189758, -0.243505, 0.3650982, -0.8985595, -0.8086389, -0.5879738, -0.0197656, -0.5355455, 0.7217969, 0.4384066) })
					I[19] = new("Pose", I[15], "Head", { CFrame = CFrame.new(0, 0, -0.0000019, 0.9867194, 0, 0.162434, 0, 1, 0, -0.162434, 0, 0.9867194) })
			I[20] = new("Pose", I[12], "S1", { CFrame = CFrame.new(0, 0, -0.0000001) })
			I[21] = new("Pose", I[12], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
		I[22] = new("Keyframe", I[1], "Keyframe", { Time = 8 })
			I[23] = new("Pose", I[22], "CameraPart", { CFrame = CFrame.new(-0.0000156, 0.0000148, 0.0000013, 0.9924872, 0.0006281, 0.1223472, 0.0020066, 0.9997687, -0.0214102, -0.1223323, 0.0214949, 0.9922564) })
			I[24] = new("Pose", I[22], "HumanoidRootPart", { Weight = 0 })
				I[25] = new("Pose", I[24], "Torso", { Weight = 0 })
					I[26] = new("Pose", I[25], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.098053, -0.8410645, -0.2422699, -0.9139158, 0.3256736, 0.9661013, -0.2581024, -0.0056087, 0.089183, 0.3132748, 0.9454656) })
						I[27] = new("Pose", I[26], "Handle", { CFrame = CFrame.new(-0.2250671, -0.9547119, -0.3032837, 0.9491492, -0.0216288, -0.3140829, 0.2995768, -0.2446854, 0.9221621, -0.0967967, -0.9693613, -0.2257634) })
					I[28] = new("Pose", I[25], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.6087837, -0.4089661, -0.2435275, 0.3650925, -0.8985558, -0.8082607, -0.588484, -0.0200516, -0.536106, 0.721384, 0.4384013) })
					I[29] = new("Pose", I[25], "Head", { CFrame = CFrame.new(0, 0, -0.0000019, 0.9867194, 0, 0.162434, 0, 1, 0, -0.162434, 0, 0.9867194) })
			I[30] = new("Pose", I[22], "S1", { CFrame = CFrame.new(0, 0, -0.0000001) })
			I[31] = new("Pose", I[22], "M1", { CFrame = CFrame.new(0, 0, 0.0000001) })
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 2 })
			I[33] = new("Pose", I[32], "HumanoidRootPart", { Weight = 0 })
				I[34] = new("Pose", I[33], "Torso", { Weight = 0 })
					I[35] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.0480518, -0.8310547, -0.2422709, -0.9139184, 0.3256664, 0.9617037, -0.2705626, -0.0438466, 0.1281852, 0.3025717, 0.9444675) })
						I[36] = new("Pose", I[35], "Handle", { CFrame = CFrame.new(-0.2276306, -0.9519653, -0.2931519, 0.9480165, -0.0547387, -0.3134778, 0.2902086, -0.25542, 0.922247, -0.1305511, -0.9652794, -0.2262567) })
					I[37] = new("Pose", I[34], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.5587826, -0.4189758, -0.2435672, 0.3650906, -0.8985454, -0.8292713, -0.5588416, -0.0022753, -0.5029752, 0.7445837, 0.4388746) })
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 6 })
			I[39] = new("Pose", I[38], "HumanoidRootPart", { Weight = 0 })
				I[40] = new("Pose", I[39], "Torso", { Weight = 0 })
					I[41] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.1957397, -0.0880127, -0.8310547, -0.2423241, -0.9139045, 0.3256645, 0.9694545, -0.2412051, 0.0444746, 0.0379064, 0.3264942, 0.9444388) })
						I[42] = new("Pose", I[41], "Handle", { CFrame = CFrame.new(-0.2204237, -0.9548643, -0.3129923, 0.9480251, 0.0431998, -0.3152494, 0.3167405, -0.2227583, 0.9219838, -0.0303949, -0.9739161, -0.2248636) })
					I[43] = new("Pose", I[40], "Left Arm", { CFrame = CFrame.new(-0.6300049, -0.5987835, -0.4189758, -0.2435129, 0.3650477, -0.8985779, -0.7787932, -0.6257937, -0.0431777, -0.5780859, 0.6892919, 0.4366848) })
	return I[1]
end

return build
