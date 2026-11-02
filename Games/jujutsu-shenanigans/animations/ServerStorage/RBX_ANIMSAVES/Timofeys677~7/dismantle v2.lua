-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Timofeys677~7/dismantle v2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "dismantle v2", { Loop = false }, nil, { "1738791008" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "Torso")
					I[5] = new("Pose", I[4], "Left Leg")
					I[6] = new("Pose", I[4], "Right Arm")
					I[7] = new("Pose", I[4], "Head")
					I[8] = new("Pose", I[4], "Right Leg")
					I[9] = new("Pose", I[4], "Left Arm")
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.55 })
			I[11] = new("Pose", I[10], "HumanoidRootPart", { Weight = 0 })
				I[12] = new("Pose", I[11], "Torso")
					I[13] = new("Pose", I[12], "Left Leg")
					I[14] = new("Pose", I[12], "Right Arm")
					I[15] = new("Pose", I[12], "Head")
					I[16] = new("Pose", I[12], "Right Leg")
					I[17] = new("Pose", I[12], "Left Arm", { CFrame = CFrame.new(-0.4618936, 0.3392826, 0.0194635, 0.1599021, 0.9552168, 0.2489825, -0.8204825, 0.2688504, -0.5045076, -0.5488532, -0.1236139, 0.8267283) })
			I[18] = new("KeyframeMarker", I[10], "Function", { Value = "End" })
		I[19] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[20] = new("Pose", I[19], "HumanoidRootPart", { Weight = 0 })
				I[21] = new("Pose", I[20], "Torso")
					I[22] = new("Pose", I[21], "Right Arm")
					I[23] = new("Pose", I[21], "Left Arm", { CFrame = CFrame.new(-0.6819066, 0.4106485, -0.0290652, -0.2499867, 0.9682197, -0.0075599, -0.4748431, -0.1293977, -0.8705058, -0.8438191, -0.2140251, 0.4921002) })
		I[24] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[25] = new("Pose", I[24], "HumanoidRootPart", { Weight = 0 })
				I[26] = new("Pose", I[25], "Torso", { Weight = 0 })
					I[27] = new("Pose", I[26], "Left Arm", { CFrame = CFrame.new(-0.5114306, 0.3079868, -0.0217984, 0.980552, 0.0872912, 0.1757783, 0.1806771, -0.0517503, -0.9821801, -0.0766391, 0.9948378, -0.0665152) })
		I[28] = new("Keyframe", I[1], "Keyframe", { Time = 0.45 })
			I[29] = new("Pose", I[28], "HumanoidRootPart", { Weight = 0 })
				I[30] = new("Pose", I[29], "Torso", { Weight = 0 })
					I[31] = new("Pose", I[30], "Left Arm", { CFrame = CFrame.new(-0.64665, 0.4749961, 0.0272497, -0.3811818, 0.9172136, 0.1158429, -0.6957008, -0.202063, -0.6893265, -0.6088521, -0.3433507, 0.715129) })
			I[32] = new("KeyframeMarker", I[28], "Function", { Value = "Hitbox" })
		I[33] = new("Keyframe", I[1], "Keyframe", { Time = 0.35 })
			I[34] = new("KeyframeMarker", I[33], "Function", { Value = "Hitbox" })
	return I[1]
end

return build
