local Rainbow = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Rainbow.OnStart()
	ReplicatedStorage:SetAttribute("RainbowEvent", true)
end

function Rainbow.OnStop()
	ReplicatedStorage:SetAttribute("RainbowEvent", false)
	ReplicatedStorage:SetAttribute("RainbowEvent", nil)
end

return Rainbow