local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Folder = game.ServerScriptService.Scripts.Meowl.Trees
local Attribute = "MeowlEvent"

local spawnedItems = {}
local eventActive = false

local function activateEvent()
	if eventActive then return end
	eventActive = true

	for _, obj in pairs(Folder:GetChildren()) do
		local clone = obj:Clone()
		clone.Parent = Workspace
		table.insert(spawnedItems, clone)
	end
end

local function deactivateEvent()
	if not eventActive then return end
	eventActive = false

	for _, obj in pairs(spawnedItems) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(spawnedItems)
end

ReplicatedStorage:GetAttributeChangedSignal(Attribute):Connect(function()
	local active = ReplicatedStorage:GetAttribute(Attribute)
	if active then
		activateEvent()
	else
		deactivateEvent()
	end
end)