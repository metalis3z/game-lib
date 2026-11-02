--!strict
-- LOCATION: ReplicatedStorage/Events/Mutations/AuraInfinita/AuraInfinita
-- Módulo de mutação AuraInfinita: aplica e remove efeitos visuais no brainrot

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Mutation = {}

-- Find the appropriate BasePart to parent the VFX attachment to
local function findVFXParent(target: Instance): BasePart?
	if target:IsA("BasePart") then return target end
	if target:IsA("Model") then
		-- Look for a Brainrot folder, then a Mesh part, then any BasePart
		local brainrot = target:FindFirstChild("Brainrot")
		if brainrot and brainrot:IsA("Model") then
			local mesh = brainrot:FindFirstChild("Mesh")
			if mesh and mesh:IsA("BasePart") then return mesh end
			local torso = brainrot:FindFirstChild("Torso")
			if torso and torso:IsA("BasePart") then return torso end
			for _, d in ipairs(brainrot:GetDescendants()) do
				if d:IsA("BasePart") then return d end
			end
		end
		-- Fallback: any BasePart in the model
		for _, d in ipairs(target:GetDescendants()) do
			if d:IsA("BasePart") then return d end
		end
	end
	return nil
end

function Mutation.ApplyVFX(model: Instance)
	if not model or not model.Parent then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and not part:GetAttribute("OriginalColor_AuraInfinita") then
			part:SetAttribute("OriginalColor_AuraInfinita", part.Color)
			part.Color = Color3.fromRGB(150, 0, 255)
			part.Material = Enum.Material.Neon
		end
	end

	if not model:FindFirstChild("AuraInfinitaVFX", true) then
		-- Clone the custom VFX template from Events/Mutations/AuraInfinita
		local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
		local mutFolder = eventsFolder and eventsFolder:FindFirstChild("Mutations")
		local auraFolder = mutFolder and mutFolder:FindFirstChild("AuraInfinita")
		local template = auraFolder and auraFolder:FindFirstChild("AuraInfinitaVFX")
		
		if template then
			local vfxParent = findVFXParent(model)
			if vfxParent then
				local attachment = template:Clone()
				attachment.Name = "AuraInfinitaVFX"
				attachment.Parent = vfxParent
			end
		end
	end
end

function Mutation.RemoveVFX(model: Instance)
	if not model then return end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local original = part:GetAttribute("OriginalColor_AuraInfinita")
			if original then
			part.Color = original
			part.Material = Enum.Material.Plastic
			part:SetAttribute("OriginalColor_AuraInfinita", nil)
			end
		end
	end

	local vfx = model:FindFirstChild("AuraInfinitaVFX", true)
	if vfx then
		vfx:Destroy()
	end
end

return Mutation