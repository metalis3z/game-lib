-- Generated from animations/ServerStorage/Assets/Rigs/Killers/1x1x1x1/RoaringKnight1x1x1x1/AnimSaves/Untitled.rbxm by _tools/rbxm2lua.luau
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
				I[5] = new("Pose", I[3], "Torso", { CFrame = CFrame.new(0, 0, 0, 0.9825031, -0.1856039, 0.0154568, 0.1418469, 0.7994828, 0.583701, -0.1206946, -0.5712954, 0.8118216) })
					I[6] = new("Pose", I[5], "Spike1.L", { CFrame = CFrame.new(0, 0, 0, 0.9705602, 0, 0.2408587, 0, 1, 0, -0.2408587, 0, 0.9705602) })
					I[7] = new("Pose", I[5], "Right Arm", { CFrame = CFrame.new(-0.1239655, -0.1843029, -0.1903457, -0.0918552, -0.4897557, -0.8670075, 0.9045771, 0.3229635, -0.2782713, 0.4162967, -0.8098357, 0.4133559) })
					I[8] = new("Pose", I[5], "Left Arm", { CFrame = CFrame.new(0.1239655, -0.1843029, -0.1903458, -0.0444214, 0.4963038, 0.8670117, -0.8694327, 0.408251, -0.2782407, -0.4920503, -0.7661681, 0.4133677) })
					I[9] = new("Pose", I[5], "Left Leg", { CFrame = CFrame.new(-0.3165847, 0.0610962, 0.1361949, 0.7559679, -0.5040699, 0.4176436, 0.4760615, 0.8612561, 0.1777737, -0.4493085, 0.0644329, 0.8910501) })
					I[10] = new("Pose", I[5], "Head", { CFrame = CFrame.new(0, 0, 0, 0.9982389, 0.0593024, -0.001559, -0.0592418, 0.997904, 0.0260384, 0.0030999, -0.0259002, 0.9996597) })
					I[11] = new("Pose", I[5], "Spike4.L", { CFrame = CFrame.new(0, 0, 0, 0.9069681, 0, 0.4211993, 0, 1, 0, -0.4211993, 0, 0.9069681) })
					I[12] = new("Pose", I[5], "Spike1.R", { CFrame = CFrame.new(0, 0, 0, 0.9290451, 0, -0.3699666, 0, 1, 0, 0.3699666, 0, 0.9290451) })
					I[13] = new("Pose", I[5], "Spike2.L", { CFrame = CFrame.new(0, 0, 0, 0.9069681, 0, 0.4211993, 0, 1, 0, -0.4211993, 0, 0.9069681) })
					I[14] = new("Pose", I[5], "Right Leg", { CFrame = CFrame.new(0.3165847, 0.0610962, 0.1361949, 0.7559679, 0.5040699, -0.4176436, -0.4760615, 0.8612561, 0.1777737, 0.4493085, 0.0644329, 0.8910501) })
					I[15] = new("Pose", I[5], "Spike3.L", { CFrame = CFrame.new(0, 0, 0, 0.9069681, 0, 0.4211993, 0, 1, 0, -0.4211993, 0, 0.9069681) })
	return I[1]
end

return build
