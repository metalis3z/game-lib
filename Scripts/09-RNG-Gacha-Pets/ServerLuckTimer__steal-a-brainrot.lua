-- Game: steal-a-brainrot
-- Original: ServerScriptService/Services/LuckService.lua
-- What it does: Tiny service that holds a server-wide luck index and end time in a replicated channel and counts it down once per second.

local LuckService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local ServerLuck = Synchronizer:Create("ServerLuck", {Index = 0, EndTime = 0})

function LuckService:SetLuck(Value: number)
	ServerLuck:Set("Index", Value)
end

function LuckService:GetLuck(): number
	return ServerLuck:Get("Index")
end

function LuckService:GetEndTime(): number
	return ServerLuck:Get("EndTime")
end

function LuckService:StartLuck(Index: number, Duration: number)
	ServerLuck:Set("Index", Index)
	ServerLuck:Set("EndTime", Duration)

	spawn(function()
		while true do
			local Current = ServerLuck:Get("EndTime")
			if Current <= 0 then
				ServerLuck:Set("Index", 1)
				ServerLuck:Set("EndTime", 0)
				break
			end
			ServerLuck:Set("EndTime", Current - 1)
			task.wait(1)
		end
	end)
end

Players.PlayerAdded:Connect(function(Player: Player)
	ServerLuck:AddListener(Player)
end)

return LuckService
