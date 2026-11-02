local YinYang = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function YinYang.OnStart()
	ReplicatedStorage:SetAttribute("YinYangEvent", true)
end

function YinYang.OnStop()
	ReplicatedStorage:SetAttribute("YinYangEvent", false)
	ReplicatedStorage:SetAttribute("YinYangEvent", nil)
	
	ReplicatedStorage:SetAttribute("YinYangEventLastTime", os.time())
end

return YinYang