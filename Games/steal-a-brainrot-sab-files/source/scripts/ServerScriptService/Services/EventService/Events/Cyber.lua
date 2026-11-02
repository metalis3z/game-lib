local Cyber = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Cyber.OnStart()
	ReplicatedStorage:SetAttribute("CyberEvent", true)
end

function Cyber.OnStop()
	ReplicatedStorage:SetAttribute("CyberEvent", false)
	ReplicatedStorage:SetAttribute("CyberEvent", nil)
	ReplicatedStorage:SetAttribute("CyberEventLastTime", os.time())
end

return Cyber