-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Rig~2/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1783343012" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { Weight = 0 })
						I[6] = new("Pose", I[5], "LeftUpperArm", { CFrame = CFrame.new(0, -0.0000038, 0, 0.9925461, -0.1218693, 0, 0.0783393, 0.6380225, -0.7660221, 0.0933546, 0.7603121, 0.6428137) })
							I[7] = new("Pose", I[6], "LeftLowerArm", { CFrame = CFrame.new(-0.012619, 0.0087891, -0.0000226, 0.9998487, 0.0173955, 0.0000267, -0.0173956, 0.9998484, -0.0000173, -0.000027, 0.0000165, 0.9999996) })
								I[8] = new("Pose", I[7], "LeftHand", { CFrame = CFrame.new(-0.0258179, 0.0089493, -0.0000403, 0.9998487, 0.0173955, 0.0000267, -0.0173956, 0.9998484, -0.0000173, -0.000027, 0.0000165, 0.9999996) })
						I[9] = new("Pose", I[5], "RightUpperArm", { CFrame = CFrame.new(0, -0.0000038, 0, 0.9925461, 0.1218693, 0, -0.0783393, 0.6380225, -0.7660221, -0.0933546, 0.7603121, 0.6428137) })
							I[10] = new("Pose", I[9], "RightLowerArm", { CFrame = CFrame.new(-0.0000458, -0.0000496, -0.0000172, 1, 0.0000959, 0.0000231, -0.0000959, 0.9999997, 0.0000242, -0.0000231, -0.0000245, 0.9999996) })
								I[11] = new("Pose", I[10], "RightHand", { CFrame = CFrame.new(-0.0000153, 0.0000057, -0.0000124, 1, 0.0000096, 0.0000231, -0.0000096, 0.9999998, 0.0000241, -0.0000231, -0.0000245, 0.9999996) })
		I[12] = new("AnimationRigData", I[1], "RigAnimationRigData")
	return I[1]
end

return build
