-- Aggregates per-player cash-boost multipliers from all sources (Index, Rebirths, ...).
-- One-stop GetMultiplier(player) used by PodiumService for tick + offline cash.
-- Pushes BoostUpdate(totalPercent, breakdown) to the owning client for the HUD.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ServiceRemotes = Remotes:FindFirstChild("CashBoostService")
if not ServiceRemotes then
	ServiceRemotes = Instance.new("Folder")
	ServiceRemotes.Name = "CashBoostService"
	ServiceRemotes.Parent = Remotes
end
local BoostUpdateEvent = ServiceRemotes:FindFirstChild("BoostUpdate")
if not BoostUpdateEvent then
	BoostUpdateEvent = Instance.new("RemoteEvent")
	BoostUpdateEvent.Name = "BoostUpdate"
	BoostUpdateEvent.Parent = ServiceRemotes
end
local RequestBoostFunc = ServiceRemotes:FindFirstChild("RequestBoost")
if not RequestBoostFunc then
	RequestBoostFunc = Instance.new("RemoteFunction")
	RequestBoostFunc.Name = "RequestBoost"
	RequestBoostFunc.Parent = ServiceRemotes
end

local CashBoostService = {}

-- Source registry. Keys are stable identifiers; values are functions(player, playerData) -> percent.
-- Add a new source by calling RegisterSource(name, fn) from the system that owns it.
local sources = {}

local function getIndexBoostPercent(_player, playerData)
	return tonumber(playerData.IndexCashBoost) or 0
end

sources.Index = getIndexBoostPercent

function CashBoostService.RegisterSource(sourceName, fn)
	if type(sourceName) ~= "string" or type(fn) ~= "function" then
		return
	end
	sources[sourceName] = fn
end

function CashBoostService.UnregisterSource(sourceName)
	sources[sourceName] = nil
end

local function buildBreakdown(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return { Total = 0, Sources = {} }
	end

	local breakdown = {}
	local total = 0
	for name, fn in pairs(sources) do
		local ok, pct = pcall(fn, player, playerData)
		if ok and type(pct) == "number" and pct > 0 then
			breakdown[name] = pct
			total = total + pct
		end
	end

	return { Total = total, Sources = breakdown }
end

function CashBoostService.GetTotalPercent(player)
	local info = buildBreakdown(player)
	return info.Total
end

function CashBoostService.GetMultiplier(player)
	local pct = CashBoostService.GetTotalPercent(player)
	return 1 + pct / 100
end

function CashBoostService.GetBreakdown(player)
	return buildBreakdown(player)
end

function CashBoostService.PushUpdate(player)
	if not player or not player.Parent then
		return
	end
	local info = buildBreakdown(player)
	BoostUpdateEvent:FireClient(player, info.Total, info.Sources)
end

function CashBoostService.Init()
	RequestBoostFunc.OnServerInvoke = function(plr)
		return buildBreakdown(plr)
	end

	PlayerDataService.ProfileLoaded.Event:Connect(function(plr)
		task.defer(function()
			CashBoostService.PushUpdate(plr)
		end)
	end)

	PlayerDataService.DataChanged.Event:Connect(function(plr, statName)
		-- Push on any field that any registered source might read.
		if statName == "IndexCashBoost" or statName == "Rebirths" then
			CashBoostService.PushUpdate(plr)
		end
	end)

	Players.PlayerRemoving:Connect(function(plr)
		-- nothing to clean; per-player state is read fresh from PlayerDataService
	end)
end

return CashBoostService
