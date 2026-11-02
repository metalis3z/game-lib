local Molten = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Molten.OnStart()
	ReplicatedStorage:SetAttribute("MoltenEvent", true)
end

function Molten.OnStop()
	ReplicatedStorage:SetAttribute("MoltenEvent", false)
	ReplicatedStorage:SetAttribute("MoltenEvent", nil)
end

return Molten