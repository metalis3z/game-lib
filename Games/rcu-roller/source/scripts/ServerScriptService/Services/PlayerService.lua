--[[
	PlayerService — Player notifications and tutorial state
	Handles client-fired signals for tutorial progression, update log
	dismissal, and auto-reconnect state, plus server-side notification dispatch.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

------------------------------------------------------------------------
-- PlayerService
------------------------------------------------------------------------
local PlayerService = Knit.CreateService({
	Name = "PlayerService",
	Client = {
		-- Server → client signals (no matching Client:method)
		notification = Knit.CreateSignal(),
		launchFireworks = Knit.CreateSignal(),
		shutdown = Knit.CreateSignal(),
		-- setTutorialStage, setUpdateNumber, setIsAutoReconnecting
		-- are RemoteFunctions (defined as Client:method below), NOT signals
	},
})

-- Cached reference to DataService, resolved in KnitInit
local DataService

------------------------------------------------------------------------
-- Server-side API
------------------------------------------------------------------------

-- Fires a notification to a specific player's client.
-- type     : string  — notification category (e.g. "success", "error", "info")
-- message  : string  — display text
-- duration : number  — how long (seconds) the notification stays visible
function PlayerService:SendNotification(player, type, message, duration)
	self.Client.notification:Fire(player, type, message, duration)
end

------------------------------------------------------------------------
-- Client signal handlers
------------------------------------------------------------------------

-- Client requests advancing their tutorial stage by exactly 1.
function PlayerService.Client:setTutorialStage(player)
	local replica = DataService:GetReplica(player)
	if not replica then
		warn("[PlayerService] setTutorialStage: no replica for", player.Name)
		return
	end

	local data = DataService:GetData(player)
	if not data then return end

	local currentStage = data.tutorialStage or 0
	local newStage = currentStage + 1

	replica:Set({"tutorialStage"}, newStage)
end

-- Client dismisses the update log; store the current update number so it
-- is not shown again on next login.
function PlayerService.Client:setUpdateNumber(player, updateNumber)
	if type(updateNumber) ~= "number" then
		warn("[PlayerService] setUpdateNumber: invalid value from", player.Name)
		return
	end

	local replica = DataService:GetReplica(player)
	if not replica then
		warn("[PlayerService] setUpdateNumber: no replica for", player.Name)
		return
	end

	replica:Set({"lastUpdateNumber"}, updateNumber)
end

-- Client notifies the server of its auto-reconnect state.
-- No data mutation needed — this is informational only.
function PlayerService.Client:setIsAutoReconnecting(player, isAutoReconnecting)
	-- Intentionally left as a no-op stub.
	-- Extend here if server logic needs to react to reconnect state.
end

------------------------------------------------------------------------
-- Knit lifecycle
------------------------------------------------------------------------
function PlayerService:KnitInit()
	DataService = Knit.GetService("DataService")
	print("[PlayerService] Initialized")
end

function PlayerService:KnitStart()
	print("[PlayerService] Started")
end

return PlayerService
