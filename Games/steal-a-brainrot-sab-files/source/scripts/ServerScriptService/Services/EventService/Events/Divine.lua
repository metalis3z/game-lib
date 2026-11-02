local Divine = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Divine.OnStart()
	ReplicatedStorage:SetAttribute("DivineEvent", true)
	ReplicatedStorage:SetAttribute("DivineStairsEnabled", true)
end

function Divine.OnStop()
	ReplicatedStorage:SetAttribute("DivineEvent", false)
	ReplicatedStorage:SetAttribute("DivineEvent", nil)
	ReplicatedStorage:SetAttribute("DivineStairsEnabled", false)
	ReplicatedStorage:SetAttribute("DivineStairsEnabled", nil)
	ReplicatedStorage:SetAttribute("DivineEventLastTime", os.time())
end

return Divine