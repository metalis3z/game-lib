local CollectionService = game:GetService("CollectionService")

local Phase = {}
local rocketTemplate = game.ReplicatedStorage.Models.Events["Phase 2: Galaxy Introduction"].Rocketship
local newrocket = nil
local isActive = false

function Phase.OnStart()
	if isActive then return end
	isActive = true

	task.delay(45.666, function()
		if not isActive then return end 
		newrocket = rocketTemplate:Clone()
		CollectionService:AddTag(newrocket:WaitForChild("Rocketship"), "Rocketship")
		newrocket.Parent = workspace
	end)
end

function Phase.OnStop()
	if not isActive then return end
	isActive = false

	if newrocket then
		newrocket:Destroy()
		newrocket = nil
	end
end

return Phase