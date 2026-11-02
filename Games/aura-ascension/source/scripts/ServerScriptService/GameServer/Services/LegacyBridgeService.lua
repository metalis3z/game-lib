local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)

local LegacyBridgeService = {}
LegacyBridgeService.__index = LegacyBridgeService

function LegacyBridgeService.new()
	return setmetatable({}, LegacyBridgeService)
end

function LegacyBridgeService:Init(registry)
	self.Registry = registry
	self.Communication = ReplicatedStorage:WaitForChild("Communication")
	self.Tick = self.Communication:WaitForChild("Tick")
	self.AreaStatus = self.Communication:WaitForChild("Area Status")
	self.RequestRebirth = self.Communication:WaitForChild("RequestRebirth")
	self.Inactivity = self.Communication:WaitForChild("Inactivity")
	self.ActivePing = self.Communication:WaitForChild("ActivePing")
	self.RequestAFKReturnTeleport = self.Communication:WaitForChild("RequestAFKReturnTeleport")
	self.ProductPurchased = self.Communication:WaitForChild("ProductPurchased")
	self.RequestTutorialData = self.Communication:WaitForChild("Request Tutorial Data")
	self.FX = self.Communication:WaitForChild("FX")
	self.ForwardData = self.Communication:WaitForChild("ForwardData")
	self.ChestCommunication = self.Communication:WaitForChild("ChestCommunication")
	self.CursedZoneShake = self.Communication:WaitForChild("CursedZoneShake")
	self.RequestCursedZoneTimerState = self.Communication:WaitForChild("RequestCursedZoneTimerState")

	self.RequestRebirth.OnServerInvoke = function(player)
		local ok, payload = self.Registry:Get("PlayerService"):RequestRebirth(player)
		return ok, payload
	end

	self.RequestTutorialData.OnServerInvoke = function(player)
		return self.Registry:Get("PlayerService"):GetTutorialData(player)
	end

	self.ChestCommunication.OnServerEvent:Connect(function(player, action)
		self:_onChestCommunication(player, action)
	end)
	self.RequestCursedZoneTimerState.OnServerEvent:Connect(function(player)
		self:PushCursedZoneState(player)
	end)
	self.ActivePing.OnServerEvent:Connect(function(player, resumedFromAFK)
		self:_onActivePing(player, resumedFromAFK)
	end)
	self.Inactivity.OnServerEvent:Connect(function(player)
		self:_onInactive(player)
	end)
	self.RequestAFKReturnTeleport.OnServerEvent:Connect(function(player)
		self:_onRequestAFKReturnTeleport(player)
	end)
end

function LegacyBridgeService:Start()
	local dataService = self.Registry:Get("DataService")
	local function pushInitialState(player)
		task.defer(function()
			self:PushTrainingAreasData(player)
			self:PushCursedZoneState(player)
			self.Registry:Get("CursedZoneService"):PushStateToPlayer(player)
			self:PushKOTHState(self.Registry:Get("TrainingAreasService"):_copyKOTHState(), player)
		end)
	end

	dataService.ProfileLoaded.Event:Connect(function(player)
		pushInitialState(player)
	end)

	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if dataService:GetProfile(player) then
			pushInitialState(player)
		end
	end
end

function LegacyBridgeService:_forward(player, payload)
	if not GameConfig.LegacyCompatibility.Enabled then
		return
	end
	if player then
		self.ForwardData:FireClient(player, payload)
	else
		self.ForwardData:FireAllClients(payload)
	end
end

function LegacyBridgeService:PushTrainingAreasData(player, data)
	data = data or self.Registry:Get("TrainingAreasService"):GetTrainingAreasData(player)
	self:_forward(player, {
		Type = "SetTrainingAreasData",
		Data = data,
	})
end

function LegacyBridgeService:PushCursedZoneState(player)
	local state = self.Registry:Get("CursedZoneService"):GetTimerState(player)
	self:_forward(player, {
		Type = "CursedZoneTimerState",
		IsActive = state.IsActive == true,
		EndsAt = tonumber(state.EndsAt) or 0,
		NextSpawnAt = tonumber(state.NextSpawnAt) or 0,
	})
end

function LegacyBridgeService:PushAreaStatus(player, areaName, auraBoost)
	if not GameConfig.LegacyCompatibility.Enabled then
		return
	end
	self.AreaStatus:FireClient(player, areaName, auraBoost)
end

function LegacyBridgeService:PushTick(_, _)
	-- The active client stack uses TrainingAreasService.Tick through Knit.
	-- Leaving the legacy Communication.Tick remote silent avoids dropped-event spam.
end

function LegacyBridgeService:PushRankUpAnnouncement(player, rankName)
	self:_forward(nil, {
		Type = "SystemMessage",
		MessageType = "RankUp",
		PlayerName = player.DisplayName,
		RankName = rankName,
	})
end

function LegacyBridgeService:PushKOTHState(state, player)
	self:_forward(player, {
		Type = "KOTHState",
		IsClaimed = state and state.IsClaimed == true,
		KingUserId = state and state.KingUserId or nil,
		KingName = state and state.KingName or nil,
		ClaimStartedAt = state and state.ClaimStartedAt or 0,
	})
end

function LegacyBridgeService:PushKOTHNotification(message, notificationType)
	self:_forward(nil, {
		Type = "KOTHNotification",
		Message = message,
		NotificationType = notificationType,
	})
end

function LegacyBridgeService:PushCursedZoneNotification(message, notificationType)
	self:_forward(nil, {
		Type = "CursedZoneNotification",
		Message = message,
		NotificationType = notificationType,
	})
end

function LegacyBridgeService:PushCursedZoneShake(origin, duration)
	if not GameConfig.LegacyCompatibility.Enabled then
		return
	end
	self.CursedZoneShake:FireAllClients(origin or Vector3.zero, duration or 3)
end

function LegacyBridgeService:FireHighlightFX(userId)
	if not GameConfig.LegacyCompatibility.Enabled then
		return
	end
	self.FX:FireAllClients(userId)
end

function LegacyBridgeService:HandleProductPurchased(player, payload)
	if not GameConfig.LegacyCompatibility.Enabled then
		return
	end
	self.ProductPurchased:FireClient(player, payload)
end

function LegacyBridgeService:_translateChestState(state)
	local nextClaimAt = state and state.NextClaimAt or 0
	return {
		Remaining = math.max(0, nextClaimAt - os.time()),
		InGroup = state and state.InGroup == true,
	}
end

function LegacyBridgeService:_onChestCommunication(player, action)
	action = tostring(action or "")
	local chestService = self.Registry:Get("ChestService")
	if action == "RequestSync" then
		self.ChestCommunication:FireClient(player, "SyncCooldown", self:_translateChestState(chestService:GetState(player)))
		return
	end
	if action ~= "Claim" then
		return
	end

	local result = chestService:RequestClaim(player)
	if result and result.ok then
		self.ChestCommunication:FireClient(player, "ClaimSuccess", {
			Cooldown = GameConfig.Chest.CooldownSeconds,
		})
		return
	end

	local payload = {
		Reason = "Unknown",
	}
	if result and result.reason == "ON_COOLDOWN" then
		payload.Reason = "Cooldown"
		payload.Remaining = math.max(0, (result.nextClaimAt or 0) - os.time())
	elseif result and result.reason == "NOT_NEAR_CHEST" then
		payload.Reason = "TooFar"
	elseif result and result.reason == "RATE_LIMITED" then
		payload.Reason = "RateLimited"
	end
	self.ChestCommunication:FireClient(player, "ClaimFail", payload)
	self.ChestCommunication:FireClient(player, "SyncCooldown", self:_translateChestState(chestService:GetState(player)))
end

function LegacyBridgeService:_onActivePing(player, resumedFromAFK)
	player:SetAttribute("LastActivePingAt", os.time())
	if resumedFromAFK == true then
		player:SetAttribute("IsAFK", false)
		player:SetAttribute("AFKSince", 0)
	end
end

function LegacyBridgeService:_onInactive(player)
	player:SetAttribute("IsAFK", true)
	player:SetAttribute("AFKSince", os.time())
end

function LegacyBridgeService:_onRequestAFKReturnTeleport(player)
	if not GameConfig.AFK.ReturnTeleportEnabled or RunService:IsStudio() then
		return
	end
	pcall(function()
		TeleportService:TeleportAsync(game.PlaceId, { player })
	end)
end

return LegacyBridgeService