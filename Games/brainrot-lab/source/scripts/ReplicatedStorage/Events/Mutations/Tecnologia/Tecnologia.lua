--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/Tecnologia/Tecnologia
-- Módulo de mutação Tecnologia: aplica e remove efeitos visuais no brainrot

local Mutation = {}

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_Tecnologia") then
			part:SetAttribute("OriginalColor_Tecnologia", part.Color)
			part.Color = Color3.fromRGB(255, 100, 200)
		end
	end

	if not model:FindFirstChild("TecnologiaVFX", true) then
		local attachment = Instance.new("Attachment")
		attachment.Name = "TecnologiaVFX"
		attachment.Parent = model

		local particles = Instance.new("ParticleEmitter")
		particles.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 100)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 255)),
		})
		particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
		particles.Lifetime = NumberRange.new(0.5, 1)
		particles.Rate = 7
		particles.Speed = NumberRange.new(1, 4)
		particles.SpreadAngle = Vector2.new(45, 45)
		particles.LightEmission = 0.7
		particles.Parent = attachment
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_Tecnologia")
			if original then
				part.Color = original
				part:SetAttribute("OriginalColor_Tecnologia", nil)
			end
		end
	end

	local vfx = model:FindFirstChild("TecnologiaVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation