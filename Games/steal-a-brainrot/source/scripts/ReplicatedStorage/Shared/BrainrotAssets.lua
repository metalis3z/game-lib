-- Reconstructed module (was missing from ReplicatedStorage.Shared)
-- Provides model lookup/preload for animal ("Brainrot") 3D models used by
-- the Glossary UI and the Workspace.Glossary.BrainrotOrbit display.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")

local AnimalsFolder = ReplicatedStorage:FindFirstChild("Models") and ReplicatedStorage.Models:FindFirstChild("Animals")

local BrainrotAssets = {}

-- Returns the source Model for a given animal name, or nil if not found.
function BrainrotAssets.getModel(name: string)
	if not AnimalsFolder then
		return nil
	end
	return AnimalsFolder:FindFirstChild(name)
end

-- Warms the asset cache (meshes/textures) for a list of animal names so
-- they pop in instantly the first time they're shown.
function BrainrotAssets.preload(names: {string})
	if RunService:IsServer() then
		return
	end

	local toPreload = {}
	for _, name in ipairs(names) do
		local model = BrainrotAssets.getModel(name)
		if model then
			table.insert(toPreload, model)
		end
	end

	if #toPreload > 0 then
		task.spawn(function()
			pcall(function()
				ContentProvider:PreloadAsync(toPreload)
			end)
		end)
	end
end

return BrainrotAssets
