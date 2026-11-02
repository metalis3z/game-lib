local Summer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Summer.OnStart()
	ReplicatedStorage:SetAttribute("SummerEvent", true)
end

function Summer.OnStop()
	ReplicatedStorage:SetAttribute("SummerEvent", false)
	ReplicatedStorage:SetAttribute("SummerEvent", nil)
	ReplicatedStorage:SetAttribute("SummerEventLastTime", os.time())
end

return Summer