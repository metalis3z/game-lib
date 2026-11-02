local Radioactive = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Radioactive.OnStart()
	ReplicatedStorage:SetAttribute("RadioactiveEvent", true)
end

function Radioactive.OnStop()
	ReplicatedStorage:SetAttribute("RadioactiveEvent", false)
	ReplicatedStorage:SetAttribute("RadioactiveEvent", nil)
end

return Radioactive