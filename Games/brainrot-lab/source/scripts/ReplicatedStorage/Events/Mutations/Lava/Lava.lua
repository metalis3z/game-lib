--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/Lava/Lava
-- Módulo de mutação Lava: aplica e remove efeitos visuais no brainrot

local Mutation = {}

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_Lava") then
			part:SetAttribute("OriginalColor_Lava", part.Color)
			part.Color = Color3.fromRGB(255, 80, 0)
			part.Material = Enum.Material.Neon
		end
	end

	if not model:FindFirstChild("LavaVFX", true) then
		local attachment = Instance.new("Attachment")
		attachment.Name = "LavaVFX"
		attachment.Parent = model

		local particles = Instance.new("ParticleEmitter")
		particles.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 0)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 50)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
		})
		particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 0) })
		particles.Lifetime = NumberRange.new(0.6, 1.2)
		particles.Rate = 12
		particles.Speed = NumberRange.new(2, 6)
		particles.SpreadAngle = Vector2.new(180, 180)
		particles.LightEmission = 1
		particles.Parent = attachment
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_Lava")
			if original then
				part.Color = original
				part.Material = Enum.Material.Plastic
				part:SetAttribute("OriginalColor_Lava", nil)
			end
		end
	end

	local vfx = model:FindFirstChild("LavaVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation