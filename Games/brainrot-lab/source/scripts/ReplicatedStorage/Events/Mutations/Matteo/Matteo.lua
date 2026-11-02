--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/Matteo/Matteo
-- Módulo de mutação Matteo: aplica e remove efeitos visuais no brainrot

local Mutation = {}

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_Matteo") then
			part:SetAttribute("OriginalColor_Matteo", part.Color)
			part.Color = Color3.fromRGB(255, 200, 100)
		end
	end

	if not model:FindFirstChild("MatteoVFX", true) then
		local attachment = Instance.new("Attachment")
		attachment.Name = "MatteoVFX"
		attachment.Parent = model

		local particles = Instance.new("ParticleEmitter")
		particles.Color = ColorSequence.new(Color3.fromRGB(255, 200, 100))
		particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
		particles.Lifetime = NumberRange.new(0.5, 1)
		particles.Rate = 5
		particles.Speed = NumberRange.new(1, 3)
		particles.SpreadAngle = Vector2.new(30, 30)
		particles.LightEmission = 0.6
		particles.Parent = attachment
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_Matteo")
			if original then
				part.Color = original
				part:SetAttribute("OriginalColor_Matteo", nil)
			end
		end
	end

	local vfx = model:FindFirstChild("MatteoVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation