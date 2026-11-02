-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~2/Automatic Save.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Priority = Enum.AnimationPriority.Core }, nil, { "1786565723" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "Mesh", { Weight = 0 })
				I[4] = new("Pose", I[3], "Bone", { Weight = 0 })
					I[5] = new("Pose", I[4], "Bone.004", { CFrame = CFrame.new(-0.0000033, -0.0000134, 0, 0.9581053, -0.1025451, -0.2674298, -0.1025452, 0.7490015, -0.6545848, 0.2674298, 0.6545848, 0.7071068) })
					I[6] = new("Pose", I[4], "Bone.002", { CFrame = CFrame.new(-0.0000033, 0.0000033, 0, 0.9581053, 0.1025451, -0.2674298, 0.1025452, 0.7490015, 0.6545848, 0.2674298, -0.6545848, 0.7071068) })
					I[7] = new("Pose", I[4], "Bone.008", { CFrame = CFrame.new(0.0000017, -0.0000134, 0, 0.9999188, 0.0048788, 0.0117801, 0.0048788, 0.7071881, -0.7070087, -0.0117801, 0.7070087, 0.7071068) })
					I[8] = new("Pose", I[4], "Bone.006", { CFrame = CFrame.new(0.0000017, -0.0000134, 0, 0.9999188, 0.0048788, -0.0117801, 0.0048788, 0.7071881, 0.7070087, 0.0117801, -0.7070087, 0.7071068) })
		I[9] = new("Keyframe", I[1], "Keyframe", { Time = 0.4 })
			I[10] = new("Pose", I[9], "Mesh", { Weight = 0 })
				I[11] = new("Pose", I[10], "Bone", { Weight = 0 })
					I[12] = new("Pose", I[11], "Bone.004", { CFrame = CFrame.new(-0.0000067, -0.0000268, 0, 0.9581074, -0.1025403, 0.2674247, -0.1025404, 0.7490132, 0.6545721, -0.2674246, -0.6545721, 0.7071205) })
					I[13] = new("Pose", I[11], "Bone.002", { CFrame = CFrame.new(-0.0000067, 0.0000033, 0, 0.9580994, 0.1025625, 0.2674443, 0.1025583, 0.748962, -0.6546279, -0.2674459, 0.6546273, 0.7070614) })
					I[14] = new("Pose", I[11], "Bone.008", { CFrame = CFrame.new(0.0000033, -0.0000402, -0.0000268, 0.999526, -0.0284471, -0.0117713, 0.0284411, 0.706843, 0.7067987, -0.0117859, -0.7067985, 0.7073169) })
					I[15] = new("Pose", I[11], "Bone.006", { CFrame = CFrame.new(0.0000017, -0.0000134, 0, 0.9999188, 0.0048786, 0.0117799, 0.0048786, 0.7072018, -0.706995, -0.0117799, 0.706995, 0.7071206) })
		I[16] = new("Keyframe", I[1], "Keyframe", { Time = 0.9 })
			I[17] = new("Pose", I[16], "Mesh", { Weight = 0 })
				I[18] = new("Pose", I[17], "Bone", { Weight = 0 })
					I[19] = new("Pose", I[18], "Bone.004", { CFrame = CFrame.new(-0.0000033, -0.0000134, 0, 0.9581053, -0.1025451, -0.2674298, -0.1025452, 0.7490015, -0.6545848, 0.2674298, 0.6545848, 0.7071068) })
					I[20] = new("Pose", I[18], "Bone.002", { CFrame = CFrame.new(-0.0000033, 0.0000033, 0, 0.9581053, 0.1025451, -0.2674298, 0.1025452, 0.7490015, 0.6545848, 0.2674298, -0.6545848, 0.7071068) })
					I[21] = new("Pose", I[18], "Bone.008", { CFrame = CFrame.new(0.0000017, -0.0000134, 0, 0.9999188, 0.0048788, 0.0117801, 0.0048788, 0.7071881, -0.7070087, -0.0117801, 0.7070087, 0.7071068) })
					I[22] = new("Pose", I[18], "Bone.006", { CFrame = CFrame.new(0.0000017, -0.0000134, 0, 0.9999188, 0.0048788, -0.0117801, 0.0048788, 0.7071881, 0.7070087, 0.0117801, -0.7070087, 0.7071068) })
		I[23] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
