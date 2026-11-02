local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Attribute = "MeowlEvent"

local SpawnedItems = {}
local EventActive = false

local function ActivateEvent()
	if EventActive then return end
	EventActive = true

	for _, Obj in pairs(script:GetChildren()) do
		local Clone = Obj:Clone()
		Clone.Parent = Workspace
		table.insert(SpawnedItems, Clone)
	end
end

local function DeactivateEvent()
	if not EventActive then return end
	EventActive = false

	for _, Obj in pairs(SpawnedItems) do
		if Obj and Obj.Parent then
			Obj:Destroy()
		end
	end
	table.clear(SpawnedItems)
end

ReplicatedStorage:GetAttributeChangedSignal(Attribute):Connect(function()
	local Active = ReplicatedStorage:GetAttribute(Attribute)
	if Active then
		ActivateEvent()
	else
		DeactivateEvent()
	end
end)