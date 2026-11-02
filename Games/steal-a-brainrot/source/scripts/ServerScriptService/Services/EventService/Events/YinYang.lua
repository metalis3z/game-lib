local YinYang = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function YinYang.OnStart()
	ReplicatedStorage:SetAttribute("YinYangEvent", true)
end

function YinYang.OnStop()
	ReplicatedStorage:SetAttribute("YinYangEvent", false)
	ReplicatedStorage:SetAttribute("YinYangEvent", nil)
end

return YinYang