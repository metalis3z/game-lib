local Galaxy = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Galaxy.OnStart()
	ReplicatedStorage:SetAttribute("GalaxyEvent", true)
end

function Galaxy.OnStop()
	ReplicatedStorage:SetAttribute("GalaxyEvent", false)
	ReplicatedStorage:SetAttribute("GalaxyEvent", nil)
end

return Galaxy