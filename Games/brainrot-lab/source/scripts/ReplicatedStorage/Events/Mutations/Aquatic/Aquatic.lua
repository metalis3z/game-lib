--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/Aquatic/Aquatic
-- Módulo de mutação Aquatic: aplica e remove efeitos visuais no brainrot

local Mutation = {}

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_Aquatic") then
			part:SetAttribute("OriginalColor_Aquatic", part.Color)
			part.Color = Color3.fromRGB(0, 150, 255)
			part.Material = Enum.Material.Glass
		end
	end

	if not model:FindFirstChild("AquaticVFX", true) then
		local attachment = Instance.new("Attachment")
		attachment.Name = "AquaticVFX"
		attachment.Parent = model

		local particles = Instance.new("ParticleEmitter")
		particles.Color = ColorSequence.new(Color3.fromRGB(0, 150, 255))
		particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 0) })
		particles.Lifetime = NumberRange.new(0.4, 0.8)
		particles.Rate = 10
		particles.Speed = NumberRange.new(1, 3)
		particles.SpreadAngle = Vector2.new(180, 180)
		particles.LightEmission = 0.9
		particles.Parent = attachment
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_Aquatic")
			if original then
				part.Color = original
				part.Material = Enum.Material.Plastic
				part:SetAttribute("OriginalColor_Aquatic", nil)
			end
		end
	end

	local vfx = model:FindFirstChild("AquaticVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation