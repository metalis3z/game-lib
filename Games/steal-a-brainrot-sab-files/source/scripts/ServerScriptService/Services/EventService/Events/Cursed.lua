local Cursed = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Cursed.OnStart()
	ReplicatedStorage:SetAttribute("CursedEvent", true)
end

function Cursed.OnStop()
	ReplicatedStorage:SetAttribute("CursedEvent", false)
	ReplicatedStorage:SetAttribute("CursedEvent", nil)

	ReplicatedStorage:SetAttribute("CursedEventLastTime", os.time())
end

return Cursed