-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Reuben/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1763163099" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "RootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "root", { Weight = 0 })
					I[5] = new("Pose", I[4], "spine1", { Weight = 0 })
						I[6] = new("Pose", I[5], "spine2", { Weight = 0 })
							I[7] = new("Pose", I[6], "spine3", { Weight = 0 })
								I[8] = new("Pose", I[7], "leg2_R", { Weight = 0 })
									I[9] = new("Pose", I[8], "kneeCapFront2_R", { CFrame = CFrame.new(0, 0.000007, 0, 1, 0, 0, 0, 0.9748713, 0.222769, 0, -0.222769, 0.9748713) })
									I[10] = new("Pose", I[8], "knee2_R", { CFrame = CFrame.new(0, -0.0000209, 0, 1, 0, 0.0000001, 0, 0.8181276, -0.5750366, -0.0000001, 0.5750366, 0.8181276) })
								I[11] = new("Pose", I[7], "neck", { Weight = 0 })
									I[12] = new("Pose", I[11], "neck2", { Weight = 0 })
										I[13] = new("Pose", I[12], "head", { CFrame = CFrame.new(-0.0005086, 0, -0.0000159, 1, 0, 0, 0, 0.9469997, 0.3212346, 0, -0.3212346, 0.9469997) })
											I[14] = new("Pose", I[13], "eye_R", { CFrame = CFrame.new(-2.9912314, -0.0001272, -0.0000636, 1, 0, 0, 0, 1, 0, 0, 0, 1) })
											I[15] = new("Pose", I[13], "eye_L", { CFrame = CFrame.new(3.4164429, -0.0002543, -0.0003497, 0.9999999, -0.000451, -0.0002576, 0.000451, 0.9999999, -0.0000088, 0.0002576, 0.0000087, 1) })
								I[16] = new("Pose", I[7], "leg2_L", { Weight = 0 })
									I[17] = new("Pose", I[16], "kneeCapFront2_L", { CFrame = CFrame.new(0, 0.0000397, 0, 0.9656813, 0, 0.2597299, 0.1831069, 0.7092174, -0.6807955, -0.184205, 0.7049899, 0.6848779) })
					I[18] = new("Pose", I[4], "pelvis", { Weight = 0 })
						I[19] = new("Pose", I[18], "leg_R", { Weight = 0 })
							I[20] = new("Pose", I[19], "knee_R", { CFrame = CFrame.new(0, -0.0000119, 0, 1, 0, 0.0000001, 0, 0.8512057, -0.5248322, -0.0000001, 0.5248322, 0.8512057) })
	return I[1]
end

return build
