local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local CashBoostService = require(ServerScriptService.Source.Services.CashBoostService)

local FriendBoostService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local BoostRemotes = Remotes:WaitForChild("FriendBoostService")
local FriendBoostUpdateEvent = BoostRemotes:WaitForChild("FriendBoostUpdate")
local GetFriendBoostFunction = BoostRemotes:WaitForChild("GetFriendBoost")

local boostCache = {}
local friendCache = {}

local function pairKey(a, b)
	if a < b then
		return a .. "_" .. b
	end
	return b .. "_" .. a
end

local function isFriendCached(playerA, playerB)
	local key = pairKey(playerA.UserId, playerB.UserId)
	local cached = friendCache[key]
	if cached ~= nil then
		return cached
	end
	local ok, isFriend = pcall(function()
		return playerA:IsFriendsWith(playerB.UserId)
	end)
	local result = ok and isFriend or false
	friendCache[key] = result
	return result
end

local function countFriendsInServer(player)
	local count = 0
	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player then
			if isFriendCached(player, other) then
				count = count + 1
			end
		end
	end
	return count
end

local function refreshPlayer(player)
	local friendCount = countFriendsInServer(player)
	local boostPercent = (GameConfig.FriendBoost and GameConfig.FriendBoost.BoostPercent) or 5
	local percent = friendCount > 0 and boostPercent or 0

	boostCache[player] = {
		FriendCount = friendCount,
		Percent = percent,
	}

	FriendBoostUpdateEvent:FireClient(player, friendCount, percent)
	CashBoostService.PushUpdate(player)
end

local function refreshAllPlayers()
	for _, plr in ipairs(Players:GetPlayers()) do
		task.spawn(refreshPlayer, plr)
	end
end

function FriendBoostService.GetPercent(player)
	local entry = boostCache[player]
	if entry then
		return entry.Percent
	end
	return 0
end

function FriendBoostService.GetFriendCount(player)
	local entry = boostCache[player]
	if entry then
		return entry.FriendCount
	end
	return 0
end

function FriendBoostService.Init()
	if not GameConfig.FriendBoost then
		return
	end

	CashBoostService.RegisterSource("Friend", function(plr)
		return FriendBoostService.GetPercent(plr)
	end)

	GetFriendBoostFunction.OnServerInvoke = function(player)
		local entry = boostCache[player]
		if entry then
			return entry.FriendCount, entry.Percent
		end
		return 0, 0
	end

	Players.PlayerAdded:Connect(function(_plr)
		task.delay(1, refreshAllPlayers)
	end)

	Players.PlayerRemoving:Connect(function(plr)
		boostCache[plr] = nil
		local prefix = tostring(plr.UserId) .. "_"
		local suffix = "_" .. tostring(plr.UserId)
		for key in pairs(friendCache) do
			if key:sub(1, #prefix) == prefix or key:sub(-#suffix) == suffix then
				friendCache[key] = nil
			end
		end
		task.defer(refreshAllPlayers)
	end)

	task.defer(refreshAllPlayers)
end

return FriendBoostService