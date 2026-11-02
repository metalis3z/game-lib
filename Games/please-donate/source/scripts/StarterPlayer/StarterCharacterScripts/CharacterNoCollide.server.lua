local PhysicsService = game:GetService("PhysicsService")
local Character = script.Parent

local playerCollisionGroupName = "Players"

local previousCollisionGroups = {}

local function setCollisionGroup(object)
	if object:IsA("BasePart") then
		previousCollisionGroups[object] = object.CollisionGroupId
		PhysicsService:SetPartCollisionGroup(object, playerCollisionGroupName)
	end
end

local function setCollisionGroupRecursive(object)
	setCollisionGroup(object)

	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

local function resetCollisionGroup(object)
	pcall(function()
		local previousCollisionGroupId = previousCollisionGroups[object]
		if not previousCollisionGroupId then return end 

		local previousCollisionGroupName = PhysicsService:GetCollisionGroupName(previousCollisionGroupId)
		if not previousCollisionGroupName then return end

		PhysicsService:SetPartCollisionGroup(object, previousCollisionGroupName)
		previousCollisionGroups[object] = nil
	end)
end

setCollisionGroupRecursive(Character)

Character.DescendantAdded:Connect(setCollisionGroup)
Character.DescendantRemoving:Connect(resetCollisionGroup)