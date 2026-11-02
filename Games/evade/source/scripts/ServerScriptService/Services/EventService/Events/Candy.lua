local Candy = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Candy.OnStart()
	ReplicatedStorage:SetAttribute("CandyEvent", true)
end

function Candy.OnStop()
	ReplicatedStorage:SetAttribute("CandyEvent", false)
	ReplicatedStorage:SetAttribute("CandyEvent", nil)
end

return Candy