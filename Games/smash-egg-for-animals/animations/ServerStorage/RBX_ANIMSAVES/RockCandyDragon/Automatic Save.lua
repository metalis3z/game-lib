-- Generated from animations/ServerStorage/RBX_ANIMSAVES/RockCandyDragon/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1791802978" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "RockCandyDragon", { Weight = 0 })
				I[4] = new("Pose", I[3], "Root", { Weight = 0 })
					I[5] = new("Pose", I[4], "Hips", { Weight = 0 })
						I[6] = new("Pose", I[5], "Spine", { Weight = 0 })
							I[7] = new("Pose", I[6], "Chest", { Weight = 0 })
								I[8] = new("Pose", I[7], "ArmUpper.L", { CFrame = CFrame.new(0, 0.000009, 0.000036, 1, 0, 0, 0, 0.9397029, -0.3419924, 0, 0.3419924, 0.9397029) })
		I[9] = new("AnimationRigData", I[1], "RockCandyDragonAnimationRigData")
	return I[1]
end

return build
