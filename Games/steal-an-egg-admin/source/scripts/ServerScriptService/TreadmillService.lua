--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local DataService = require(game:GetService("ServerScriptService").DataService)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)

local TreadmillService = {}

local TreadmillRemote = Remotes.Treadmill


function TreadmillService.UpgradeTreadmill(player, treadmillId, skipPayment)
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end

	local currentLevel = profile.TreadmillUpgradeLevel
	if type(currentLevel) ~= "number" then
		currentLevel = 1
	end

	local nextConfig = Treadmills.GetByUpgradeLevel(currentLevel + 1)
	if not nextConfig then
		return false, "Max treadmill upgrade reached"
	end

	if nextConfig._id ~= treadmillId then
		return false, "This is not your next treadmill upgrade"
	end

	local price = nextConfig.Price or 0
	if not skipPayment and price > 0 then
		local money = profile.Money or 0
		if money < price then
			return false, "Not enough money"
		end
		DataService.AddMoney(player, -price)
	end

	profile.TreadmillUpgradeLevel = currentLevel + 1
	DataService.SyncChange(player, "TreadmillUpgradeLevel", profile.TreadmillUpgradeLevel)

	print(("[TreadmillService] %s upgraded treadmill to %s (level %d)"):format(
		player.Name, nextConfig.DisplayName or nextConfig._id, currentLevel + 1))
	return true
end

function TreadmillService.Init()
	TreadmillRemote.AskTierRaise.OnServerInvoke = function(player, treadmillId)
		if type(treadmillId) ~= "string" then
			return false, "Invalid request"
		end
		return TreadmillService.UpgradeTreadmill(player, treadmillId, false)
	end
end

function TreadmillService.Start()
end

return TreadmillService