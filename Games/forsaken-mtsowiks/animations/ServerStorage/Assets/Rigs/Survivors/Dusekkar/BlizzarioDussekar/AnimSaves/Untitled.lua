-- Generated from animations/ServerStorage/Assets/Rigs/Survivors/Dusekkar/BlizzarioDussekar/AnimSaves/Untitled.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Untitled", { Loop = false })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("IntValue", I[3], "Null")
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(-0.0000032, 0.0000033, 0.9100005, 0.8148205, 0.5691722, 0.1100483, -0.5726482, 0.8198012, -0.0000227, -0.0902307, -0.0630004, 0.9939262) })
					I[6] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0.001436, 0.0080935, -0.0288519, 0.8747513, -0.4822035, -0.0478525, 0.4534944, 0.8494443, -0.269791, 0.1707422, 0.2142992, 0.9617292) })
					I[7] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.5868583, 0.3199958, 0.0900001, 0.9042809, -0.3790174, 0.1965245, 0.3373609, 0.9164572, 0.21516, -0.2616557, -0.1282654, 0.9566004) })
					I[8] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.0402924, -0.6361217, -0.0577257, -0.1817667, -0.6019238, 0.7775915, 0.9043833, 0.2081345, 0.3725196, -0.386072, 0.7709524, 0.506538) })
						I[9] = new("Pose", I[8], "Staff", { CFrame = CFrame.new(-0.2152776, 0.1945669, 0.1006278, -0.2322475, -0.3577777, -0.9044645, 0.0347923, 0.92624, -0.3753253, 0.9720342, -0.1186368, -0.202669) })
					I[10] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(0.2851757, -0.7057164, 0.0065504, -0.8974355, 0.3663395, 0.2457746, -0.3738067, -0.9273452, 0.0173157, 0.2342612, -0.0763324, 0.9691724) })
					I[11] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.3818809, 0.2338098, 0, 0.870438, 0.4862568, -0.0767598, -0.4843759, 0.873816, 0.0427275, 0.0878505, -0.0000111, 0.9961337) })
	return I[1]
end

return build
