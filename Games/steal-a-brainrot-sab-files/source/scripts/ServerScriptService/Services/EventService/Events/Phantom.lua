local Phantom = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Phantom.OnStart()
	ReplicatedStorage:SetAttribute("PhantomEvent", true)
end

function Phantom.OnStop()
	ReplicatedStorage:SetAttribute("PhantomEvent", false)
	ReplicatedStorage:SetAttribute("PhantomEvent", nil)
	ReplicatedStorage:SetAttribute("PhantomEventLastTime", os.time())
end

return Phantom