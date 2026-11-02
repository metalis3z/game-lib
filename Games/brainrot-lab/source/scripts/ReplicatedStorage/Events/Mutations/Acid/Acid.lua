--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/Acid/Acid
-- Módulo de mutação Acid: aplica e remove efeitos visuais no brainrot

local Mutation = {}

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_Acid") then
			part:SetAttribute("OriginalColor_Acid", part.Color)
			part.Color = Color3.fromRGB(100, 255, 100)
			part.Material = Enum.Material.Neon
		end
	end

	if not model:FindFirstChild("AcidVFX", true) then
		local attachment = Instance.new("Attachment")
		attachment.Name = "AcidVFX"
		attachment.Parent = model

		local particles = Instance.new("ParticleEmitter")
		particles.Color = ColorSequence.new(Color3.fromRGB(100, 255, 100))
		particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
		particles.Lifetime = NumberRange.new(0.5, 1.2)
		particles.Rate = 8
		particles.Speed = NumberRange.new(2, 5)
		particles.SpreadAngle = Vector2.new(180, 180)
		particles.LightEmission = 0.8
		particles.Parent = attachment
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_Acid")
			if original then
				part.Color = original
				part.Material = Enum.Material.Plastic
				part:SetAttribute("OriginalColor_Acid", nil)
			end
		end
	end

	local vfx = model:FindFirstChild("AcidVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation