local Event3K = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)

local trove = Trove.new()

function Event3K.OnStart()
	ReplicatedStorage:SetAttribute("3KEvent", true)
end

function Event3K.OnStop()
	trove:Destroy()
	ReplicatedStorage:SetAttribute("3KEvent", nil)
end

function Event3K.OnLoad() end

return Event3K