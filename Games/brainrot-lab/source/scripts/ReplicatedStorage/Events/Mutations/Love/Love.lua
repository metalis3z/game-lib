--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/Love/Love
-- Módulo de mutação Love: aplica e remove efeitos visuais no brainrot

local Mutation = {}

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	-- Salvar cores originais e aplicar cor rosa
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_Love") then
			part:SetAttribute("OriginalColor_Love", part.Color)
			part.Color = Color3.fromRGB(255, 100, 150)
		end
	end

	-- Adicionar partículas de coração se não existir
	if not model:FindFirstChild("LoveVFX", true) then
		local attachment = Instance.new("Attachment")
		attachment.Name = "LoveVFX"
		attachment.Parent = model

		local particles = Instance.new("ParticleEmitter")
		particles.Color = ColorSequence.new(Color3.fromRGB(255, 100, 150))
		particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
		particles.Lifetime = NumberRange.new(0.5, 1)
		particles.Rate = 5
		particles.Speed = NumberRange.new(1, 3)
		particles.SpreadAngle = Vector2.new(45, 45)
		particles.LightEmission = 0.8
		particles.Parent = attachment
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	-- Restaurar cores originais
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_Love")
			if original then
				part.Color = original
				part:SetAttribute("OriginalColor_Love", nil)
			end
		end
	end

	-- Remover partículas
	local vfx = model:FindFirstChild("LoveVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation