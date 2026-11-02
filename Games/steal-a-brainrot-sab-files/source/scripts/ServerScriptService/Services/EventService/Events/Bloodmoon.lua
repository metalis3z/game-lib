local Bloodmoon = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Bloodmoon.OnStart()
	ReplicatedStorage:SetAttribute("BloodmoonEvent", true)
end

function Bloodmoon.OnStop()
	ReplicatedStorage:SetAttribute("BloodmoonEvent", false)
	ReplicatedStorage:SetAttribute("BloodmoonEvent", nil)
end

return Bloodmoon