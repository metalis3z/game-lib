-- Generated from animations/ServerScriptService/Server/Rooms_Rooms/Rooms_Issues/Rooms_Locker/Model/Wardrobe/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1664725801" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Main", { Weight = 0 })
				I[4] = new("Pose", I[3], "Door1", { CFrame = CFrame.new(0, 0, 0, -0.7606915, 0, -0.6491137, 0, 0.9999999, 0, 0.6491137, 0, -0.7606915) })
				I[5] = new("Pose", I[3], "Door2", { CFrame = CFrame.new(0, 0.0000005, 0, -0.6743504, 0, 0.7384115, 0, 1, 0, -0.7384115, 0, -0.6743504) })
		I[6] = new("Keyframe", I[1], "Keyframe", { Time = 0.2 })
			I[7] = new("Pose", I[6], "Main", { Weight = 0 })
				I[8] = new("Pose", I[7], "Door1", { CFrame = CFrame.new(-0.000001, 0, 0, 0.9994312, 0, -0.03372, 0, 1, 0, 0.03372, 0, 0.9994312) })
				I[9] = new("Pose", I[7], "Door2", { CFrame = CFrame.new(0, 0.000001, 0.0000019, 0.9999992, 0, 0.0011733, 0, 0.9999994, 0, -0.0011733, 0, 0.9999992) })
		I[10] = new("Keyframe", I[1], "Keyframe", { Time = 0.3 })
			I[11] = new("Pose", I[10], "Main", { Weight = 0 })
				I[12] = new("Pose", I[11], "Door1", { CFrame = CFrame.new(0, 0, 0, 0.9884755, 0, -0.1513811, 0, 1, 0, 0.1513811, 0, 0.9884755) })
		I[13] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[14] = new("Pose", I[13], "Main", { Weight = 0 })
				I[15] = new("Pose", I[14], "Door1", { CFrame = CFrame.new(-0.000001, 0, 0, 0.9994312, 0, -0.03372, 0, 1, 0, 0.03372, 0, 0.9994312) })
				I[16] = new("Pose", I[14], "Door2", { CFrame = CFrame.new(0, 0.000001, 0.0000019, 0.9999992, 0, 0.0011733, 0, 0.9999994, 0, -0.0011733, 0, 0.9999992) })
	return I[1]
end

return build
