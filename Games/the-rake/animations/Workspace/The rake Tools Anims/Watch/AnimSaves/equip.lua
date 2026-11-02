-- Generated from animations/Workspace/The rake Tools Anims/Watch/AnimSaves/equip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "equip", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Torso", { Weight = 0 })
				I[4] = new("Pose", I[3], "Right Arm", { CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.9999999, 0, 0, 0, 1) })
					I[5] = new("StringValue", I[4], "xSIXxCustomStyle", { Value = "Quad" })
					I[6] = new("StringValue", I[4], "xSIXxCustomDir", { Value = "InOut" })
		I[7] = new("Keyframe", I[1], "Keyframe", { Time = 0.1166667 })
			I[8] = new("Pose", I[7], "Torso", { Weight = 0 })
				I[9] = new("Pose", I[8], "Right Arm", { CFrame = CFrame.new(0, 0, 0, -0.2041932, 0.1022339, -0.9735776, 0.4476945, 0.8941861, 0, 0.8705599, -0.4358655, -0.2283564) })
					I[10] = new("StringValue", I[9], "xSIXxCustomStyle", { Value = "Quad" })
					I[11] = new("StringValue", I[9], "xSIXxCustomDir", { Value = "InOut" })
		I[12] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[13] = new("Pose", I[12], "Torso", { Weight = 0 })
				I[14] = new("Pose", I[13], "Right Arm", { CFrame = CFrame.new(-0.0640538, 0.2524182, -0.2928051, -0.6036681, -0.5066707, -0.6155238, 0.6763573, 0.0832447, -0.7318529, 0.4220482, -0.8581113, 0.2924385) })
					I[15] = new("StringValue", I[14], "xSIXxCustomStyle", { Value = "Quad" })
					I[16] = new("StringValue", I[14], "xSIXxCustomDir", { Value = "InOut" })
		I[17] = new("Keyframe", I[1], "Keyframe", { Time = 0.2833333 })
			I[18] = new("Pose", I[17], "Torso", { Weight = 0 })
				I[19] = new("Pose", I[18], "Right Arm", { CFrame = CFrame.new(-0.0000001, 0, 0, -0.0819272, -0.9047715, 0.417943, 0.8747992, -0.2662021, -0.4047973, 0.4775069, 0.3324526, 0.8133034) })
		I[20] = new("Keyframe", I[1], "Keyframe", { Time = 0.0166667 })
			I[21] = new("IntValue", I[20], "xSIXxNull")
			I[22] = new("Pose", I[20], "Torso", { Weight = 0 })
				I[23] = new("IntValue", I[22], "xSIXxNull")
				I[24] = new("Pose", I[22], "Right Arm", { CFrame = CFrame.new(0.0076508, -0.0062203, -0.0235518, 0.9973158, -0.0128684, -0.0720806, 0.0140942, 0.999764, 0.0165235, 0.071851, -0.017495, 0.9972619) })
					I[25] = new("IntValue", I[24], "xSIXxNull")
		I[26] = new("Keyframe", I[1], "Keyframe", { Time = 0.0333333 })
			I[27] = new("IntValue", I[26], "xSIXxNull")
			I[28] = new("Pose", I[26], "Torso", { Weight = 0 })
				I[29] = new("IntValue", I[28], "xSIXxNull")
				I[30] = new("Pose", I[28], "Right Arm", { CFrame = CFrame.new(0.0332795, -0.022916, -0.080341, 0.9573557, -0.0434276, -0.2856292, 0.0629023, 0.9962527, 0.0593602, 0.281981, -0.0747955, 0.9565001) })
					I[31] = new("IntValue", I[30], "xSIXxNull")
		I[32] = new("Keyframe", I[1], "Keyframe", { Time = 0.05 })
			I[33] = new("IntValue", I[32], "xSIXxNull")
			I[34] = new("Pose", I[32], "Torso", { Weight = 0 })
				I[35] = new("IntValue", I[34], "xSIXxNull")
				I[36] = new("Pose", I[34], "Right Arm", { CFrame = CFrame.new(0.074533, -0.0417113, -0.1286249, 0.7906622, -0.0645756, -0.6088377, 0.1601755, 0.9816052, 0.103898, 0.590929, -0.1796691, 0.7864617) })
					I[37] = new("IntValue", I[36], "xSIXxNull")
		I[38] = new("Keyframe", I[1], "Keyframe", { Time = 0.0666667 })
			I[39] = new("IntValue", I[38], "xSIXxNull")
			I[40] = new("Pose", I[38], "Torso", { Weight = 0 })
				I[41] = new("IntValue", I[40], "xSIXxNull")
				I[42] = new("Pose", I[40], "Right Arm", { CFrame = CFrame.new(0.0952961, -0.0437536, -0.1133299, 0.4247007, -0.033506, -0.9047136, 0.2962326, 0.9494479, 0.1038981, 0.8554973, -0.3121312, 0.4131568) })
					I[43] = new("IntValue", I[42], "xSIXxNull")
		I[44] = new("Keyframe", I[1], "Keyframe", { Time = 0.0833333 })
			I[45] = new("IntValue", I[44], "xSIXxNull")
			I[46] = new("Pose", I[44], "Torso", { Weight = 0 })
				I[47] = new("IntValue", I[46], "xSIXxNull")
				I[48] = new("Pose", I[46], "Right Arm", { CFrame = CFrame.new(0.0637492, -0.0259129, -0.0578954, 0.0781565, 0.031215, -0.9964525, 0.3897707, 0.9189968, 0.0593602, 0.9175895, -0.3930272, 0.0596588) })
					I[49] = new("IntValue", I[48], "xSIXxNull")
		I[50] = new("Keyframe", I[1], "Keyframe", { Time = 0.1 })
			I[51] = new("IntValue", I[50], "xSIXxNull")
			I[52] = new("Pose", I[50], "Torso", { Weight = 0 })
				I[53] = new("IntValue", I[52], "xSIXxNull")
				I[54] = new("Pose", I[52], "Right Arm", { CFrame = CFrame.new(0.0193582, -0.0073719, -0.0149275, -0.1347849, 0.0832452, -0.9873719, 0.4349862, 0.9002854, 0.0165235, 0.8902921, -0.427266, -0.1575554) })
					I[55] = new("IntValue", I[54], "xSIXxNull")
		I[56] = new("Keyframe", I[1], "Keyframe", { Time = 0.1333333 })
			I[57] = new("IntValue", I[56], "xSIXxNull")
			I[58] = new("Pose", I[56], "Torso", { Weight = 0 })
				I[59] = new("IntValue", I[58], "xSIXxNull")
				I[60] = new("Pose", I[58], "Right Arm", { CFrame = CFrame.new(0.0006644, 0.0502394, -0.0244459, -0.222789, 0.0358239, -0.9742083, 0.490641, 0.867654, -0.0802977, 0.8423993, -0.4958759, -0.2108805) })
					I[61] = new("IntValue", I[60], "xSIXxNull")
		I[62] = new("Keyframe", I[1], "Keyframe", { Time = 0.15 })
			I[63] = new("IntValue", I[62], "xSIXxNull")
			I[64] = new("Pose", I[62], "Torso", { Weight = 0 })
				I[65] = new("IntValue", I[64], "xSIXxNull")
				I[66] = new("Pose", I[64], "Right Arm", { CFrame = CFrame.new(-0.0094796, 0.1706662, -0.1030154, -0.2971038, -0.153935, -0.9423553, 0.5980824, 0.7393311, -0.3093328, 0.7443299, -0.6555099, -0.1275923) })
					I[67] = new("IntValue", I[66], "xSIXxNull")
		I[68] = new("Keyframe", I[1], "Keyframe", { Time = 0.1666667 })
			I[69] = new("IntValue", I[68], "xSIXxNull")
			I[70] = new("Pose", I[68], "Torso", { Weight = 0 })
				I[71] = new("IntValue", I[70], "xSIXxNull")
				I[72] = new("Pose", I[70], "Right Arm", { CFrame = CFrame.new(-0.0420216, 0.2607609, -0.2176734, -0.44875, -0.3850834, -0.8064333, 0.684886, 0.4314866, -0.5871544, 0.5740687, -0.8158002, 0.0701085) })
					I[73] = new("IntValue", I[72], "xSIXxNull")
		I[74] = new("Keyframe", I[1], "Keyframe", { Time = 0.1833333 })
			I[75] = new("IntValue", I[74], "xSIXxNull")
			I[76] = new("Pose", I[74], "Torso", { Weight = 0 })
				I[77] = new("IntValue", I[76], "xSIXxNull")
				I[78] = new("Pose", I[76], "Right Arm", { CFrame = CFrame.new(-0.0605469, 0.2616642, -0.2776251, -0.5644673, -0.4849833, -0.6679584, 0.6862209, 0.1740406, -0.7062654, 0.458779, -0.8570305, 0.2345652) })
					I[79] = new("IntValue", I[78], "xSIXxNull")
		I[80] = new("Keyframe", I[1], "Keyframe", { Time = 0.2166667 })
			I[81] = new("IntValue", I[80], "xSIXxNull")
			I[82] = new("Pose", I[80], "Torso", { Weight = 0 })
				I[83] = new("IntValue", I[82], "xSIXxNull")
				I[84] = new("Pose", I[82], "Right Arm", { CFrame = CFrame.new(-0.0701394, 0.2350807, -0.3149042, -0.5688693, -0.5954206, -0.5673286, 0.6848294, 0.039035, -0.727657, 0.4554078, -0.8024651, 0.3855559) })
					I[85] = new("IntValue", I[84], "xSIXxNull")
		I[86] = new("Keyframe", I[1], "Keyframe", { Time = 0.2333333 })
			I[87] = new("IntValue", I[86], "xSIXxNull")
			I[88] = new("Pose", I[86], "Torso", { Weight = 0 })
				I[89] = new("IntValue", I[88], "xSIXxNull")
				I[90] = new("Pose", I[88], "Right Arm", { CFrame = CFrame.new(-0.0914034, 0.1737635, -0.3306903, -0.4476641, -0.8143367, -0.3693947, 0.7212446, -0.0846331, -0.6874907, 0.528586, -0.5741888, 0.6252232) })
					I[91] = new("IntValue", I[90], "xSIXxNull")
		I[92] = new("Keyframe", I[1], "Keyframe", { Time = 0.25 })
			I[93] = new("IntValue", I[92], "xSIXxNull")
			I[94] = new("Pose", I[92], "Torso", { Weight = 0 })
				I[95] = new("IntValue", I[94], "xSIXxNull")
				I[96] = new("Pose", I[94], "Right Arm", { CFrame = CFrame.new(-0.088745, 0.0732524, -0.2157367, -0.2449666, -0.9689997, 0.0321087, 0.7983397, -0.2203934, -0.5604287, 0.5501319, -0.1116526, 0.82758) })
					I[97] = new("IntValue", I[96], "xSIXxNull")
		I[98] = new("Keyframe", I[1], "Keyframe", { Time = 0.2666667 })
			I[99] = new("IntValue", I[98], "xSIXxNull")
			I[100] = new("Pose", I[98], "Torso", { Weight = 0 })
				I[101] = new("IntValue", I[100], "xSIXxNull")
				I[102] = new("Pose", I[100], "Right Arm", { CFrame = CFrame.new(-0.0321946, 0.0155549, -0.061528, -0.1190457, -0.9386466, 0.3236828, 0.8559178, -0.2622426, -0.4456829, 0.5032222, 0.2239893, 0.8346233) })
					I[103] = new("IntValue", I[102], "xSIXxNull")
	return I[1]
end

return build
