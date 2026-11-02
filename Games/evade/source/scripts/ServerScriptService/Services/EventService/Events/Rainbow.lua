local Rainbow = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local Burst = Net:RemoteEvent("EventService/Rainbow/Burst")

local isActive = false

function Rainbow.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("RainbowEvent", true)

end

function Rainbow.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("RainbowEvent", false)
end

return Rainbow
