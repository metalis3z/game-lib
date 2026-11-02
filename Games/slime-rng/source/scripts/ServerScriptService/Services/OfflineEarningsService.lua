local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local DataService = require(ReplicatedStorage.Packages.DataService).server
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local OfflineEarningsServiceUtils = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local OfflineEarningsService = {}

local BASE_COINS_PER_SECOND = 5
local BASE_GOOP_PER_SECOND  = 0  -- goop offline earnings (0 if not applicable)

local function getEarningsPerSecond(data)
	local upgrades  = data:get("upgrades") or {}
	local zone      = math.max(data:get("zone") or 1, 1)

	local coinIncomeLevel = UpgradeServiceUtils.getUpgradeLevel("coinIncome", upgrades)
	local coinIncomeMult  = UpgradeServiceUtils.getUpgradeValue("coinIncome", coinIncomeLevel)
	if coinIncomeMult <= 0 then coinIncomeMult = 1 end

	local offlineMult = OfflineEarningsServiceUtils.getOfflineLootMultiplier(upgrades)
	if offlineMult <= 0 then offlineMult = 0.1 end

	local zoneScale = 1 + (zone - 1) * 0.05

	local coinsPerSecond = BASE_COINS_PER_SECOND * coinIncomeMult * offlineMult * zoneScale
	local goopPerSecond  = BASE_GOOP_PER_SECOND  * offlineMult

	if not UpgradeServiceUtils.ownsUpgrade("goop", upgrades) then
		goopPerSecond = 0
	end

	return coinsPerSecond, goopPerSecond
end

local function calculateOfflineEarnings(data)
	local lastLogout = data:get("lastLogoutTime") or 0
	if lastLogout <= 0 then return nil end

	local now            = math.floor(os.time())
	local offlineSeconds = now - lastLogout
	local eligible       = OfflineEarningsServiceUtils.getEligibleOfflineSeconds(offlineSeconds)

	if eligible <= 0 then return nil end

	local coinsPerSecond, goopPerSecond = getEarningsPerSecond(data)

	local coins = math.floor(coinsPerSecond * eligible)
	local goop  = math.floor(goopPerSecond  * eligible)

	if coins <= 0 and goop <= 0 then return nil end

	return {
		offlineSeconds = eligible,
		coins          = coins,
		goop           = goop,
	}
end

function OfflineEarningsService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[OfflineEarningsService] Could not find _remotes")
		return
	end

	local offlineRemotes = remotes:WaitForChild("OfflineEarningsService", 10)
	if not offlineRemotes then
		warn("[OfflineEarningsService] Could not find OfflineEarningsService remotes")
		return
	end

	local remoteFunction = offlineRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[OfflineEarningsService] Invoked - method:", method, "player:", player.Name)
			if method == "requestClaim" then
				return self:requestClaim(player)
			end
			warn("[OfflineEarningsService] Unknown method:", method)
			return false, "unknown method"
		end
		print("[OfflineEarningsService] OnServerInvoke set successfully")
	else
		warn("[OfflineEarningsService] RemoteFunction not found")
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(function()
			local data = DataService:waitForData(player)
			if not data then return end

			local reward = calculateOfflineEarnings(data)

			DataService:set(player, "offlineEarnings", reward)

			DataService:set(player, "sessionStart", math.floor(os.time()))

			print(string.format(
				"[OfflineEarningsService] %s | offlineSeconds: %d | coins: %d | goop: %d",
				player.Name,
				reward and reward.offlineSeconds or 0,
				reward and reward.coins or 0,
				reward and reward.goop or 0
				))
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		local ok, data = pcall(function()
			return DataService:waitForData(player)
		end)
		if not ok or not data then return end

		DataService:set(player, "lastLogoutTime", math.floor(os.time()))
		DataService:set(player, "offlineEarnings", nil)
	end)

	print("[OfflineEarningsService] Initialized")
end

function OfflineEarningsService:requestClaim(player: Player)
	local data = DataService:waitForData(player)
	if not data then
		warn("[OfflineEarningsService] No data for", player.Name)
		return false, "No data"
	end

	local rawReward = data:get("offlineEarnings")
	local reward    = OfflineEarningsServiceUtils.reconcileRewardData(rawReward)

	if not reward then
		return false, "No offline earnings to claim"
	end

	if reward.coins > 0 then
		local current = data:get("coins") or 0
		DataService:set(player, "coins", current + reward.coins)

		local totalCoins = data:get({"stats", "totalCoins"}) or 0
		DataService:set(player, {"stats", "totalCoins"}, totalCoins + reward.coins)
	end

	if reward.goop > 0 then
		local current = data:get("goop") or 0
		DataService:set(player, "goop", current + reward.goop)
	end

	DataService:set(player, "offlineEarnings", nil)

	print(string.format(
		"[OfflineEarningsService] %s claimed offline earnings | coins: %d | goop: %d",
		player.Name, reward.coins, reward.goop
		))

	return true, nil, reward
end

return OfflineEarningsService