local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Conch = require(ReplicatedStorage.Packages.Conch)
local Net = require(ReplicatedStorage.Packages.Net)

local EventList = {}

if RunService:IsServer() then
	local ServerScriptService = game:GetService("ServerScriptService")
	local EventService = require(ServerScriptService.Services.EventService)

	for EventName in pairs(EventService.Events) do
		table.insert(EventList, EventName)
	end
else
	EventList = Net:Invoke("EventService/ListEvents")
end

table.sort(EventList)

return Conch.register_type(
	"Event",
	Conch.args.enum_new(EventList)
)