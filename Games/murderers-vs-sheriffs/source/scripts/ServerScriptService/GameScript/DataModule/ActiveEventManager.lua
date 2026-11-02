-- @42devy

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes
local Events = Remotes.Events

local ActiveEventManager = {
	CurrentEvent = "Summer2026",
	LeaderboardHandlers = {}
}

local Players = game:GetService("Players")
function ActiveEventManager:IsEventActive()
	return ActiveEventManager.CurrentEvent ~= nil
end

function ActiveEventManager:GetActiveEventInfo()
	if not script:FindFirstChild(ActiveEventManager.CurrentEvent) then
		warn("Current event not found: " .. ActiveEventManager.CurrentEvent)
		return
	end
	local EventInfo = require(script:FindFirstChild(ActiveEventManager.CurrentEvent))
	return EventInfo
end

function ActiveEventManager:InitializeLeaderboardHandler(LeaderboardHandler)
	local Handler = require(LeaderboardHandler)
	ActiveEventManager.LeaderboardHandlers[LeaderboardHandler.Name] = Handler
	Players.PlayerAdded:Connect(function(Player)
		Handler:InitPlayer(Player)
	end)
end

ReplicatedStorage.Insight.CoinCollected.Event:Connect(function(Player)
	for i,v in ActiveEventManager.LeaderboardHandlers do
		v:Collect("Points", Player, 1)
	end
end)

Events.GetEvents.OnServerInvoke = function()
	return {
		ActiveEventManager:GetActiveEventInfo()
	}
end

return ActiveEventManager