-- Roblox Premium membership tracking ("Roblox Plus" boost in-game).
-- While a player has active Roblox Premium, registers a cash boost via
-- CashBoostService and pushes UI state to the client. Clicking the locked chip
-- on the client prompts MarketplaceService:PromptPremiumPurchase.

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local CashBoostService = require(ServerScriptService.Source.Services.CashBoostService)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ServiceRemotes = Remotes:FindFirstChild("RobloxPlusService")
if not ServiceRemotes then
	ServiceRemotes = Instance.new("Folder")
	ServiceRemotes.Name = "RobloxPlusService"
	ServiceRemotes.Parent = Remotes
end
local StatusUpdateEvent = ServiceRemotes:FindFirstChild("StatusUpdate")
if not StatusUpdateEvent then
	StatusUpdateEvent = Instance.new("RemoteEvent")
	StatusUpdateEvent.Name = "StatusUpdate"
	StatusUpdateEvent.Parent = ServiceRemotes
end
local GetStatusFunc = ServiceRemotes:FindFirstChild("GetStatus")
if not GetStatusFunc then
	GetStatusFunc = Instance.new("RemoteFunction")
	GetStatusFunc.Name = "GetStatus"
	GetStatusFunc.Parent = ServiceRemotes
end
local PromptPurchaseEvent = ServiceRemotes:FindFirstChild("PromptPurchase")
if not PromptPurchaseEvent then
	PromptPurchaseEvent = Instance.new("RemoteEvent")
	PromptPurchaseEvent.Name = "PromptPurchase"
	PromptPurchaseEvent.Parent = ServiceRemotes
end

local RobloxPlusService = {}

local activeCache = {}

local function getBoostPercent()
	local cfg = GameConfig.RobloxPlus
	return (cfg and cfg.BoostPercent) or 10
end

local function fetchStatus(player)
	if not player or not player.Parent then
		return false
	end
	return player.MembershipType == Enum.MembershipType.Premium
end

local function setActive(player, isActive)
	local prev = activeCache[player]
	activeCache[player] = isActive and true or false
	StatusUpdateEvent:FireClient(player, activeCache[player])
	if prev ~= activeCache[player] then
		CashBoostService.PushUpdate(player)
	end
end

local function refreshPlayer(player)
	if not player or not player.Parent then
		return
	end
	local isActive = fetchStatus(player)
	setActive(player, isActive)
end

function RobloxPlusService.IsActive(player)
	return activeCache[player] == true
end

function RobloxPlusService.GetPercent(player)
	if activeCache[player] then
		return getBoostPercent()
	end
	return 0
end

function RobloxPlusService.Init()
	CashBoostService.RegisterSource("RobloxPlus", function(plr)
		return RobloxPlusService.GetPercent(plr)
	end)

	GetStatusFunc.OnServerInvoke = function(plr)
		return activeCache[plr] == true
	end

	PromptPurchaseEvent.OnServerEvent:Connect(function(plr)
		local ok, err = pcall(function()
			MarketplaceService:PromptPremiumPurchase(plr)
		end)
		if not ok then
			warn(string.format("[RobloxPlusService] PromptPremiumPurchase failed for %s: %s", plr.Name, tostring(err)))
		end
	end)

	Players.PlayerMembershipChanged:Connect(function(plr)
		refreshPlayer(plr)
	end)

	MarketplaceService.PromptPremiumPurchaseFinished:Connect(function(plr)
		task.delay(1, function()
			refreshPlayer(plr)
		end)
	end)

	Players.PlayerAdded:Connect(function(plr)
		task.spawn(refreshPlayer, plr)
	end)

	for _, plr in ipairs(Players:GetPlayers()) do
		task.spawn(refreshPlayer, plr)
	end

	Players.PlayerRemoving:Connect(function(plr)
		activeCache[plr] = nil
	end)
end

return RobloxPlusService
