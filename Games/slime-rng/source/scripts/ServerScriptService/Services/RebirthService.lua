local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(ReplicatedStorage.Packages.DataService).server

local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)

local RebirthService = {}

function RebirthService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[RebirthService] Could not find _remotes")
		return
	end

	local rebirthRemotes = remotes:WaitForChild("RebirthService", 10)
	if not rebirthRemotes then
		warn("[RebirthService] Could not find RebirthService remotes")
		return
	end

	local remoteFunction = rebirthRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[RebirthService] Invoked - method:", method, "player:", player.Name)
			if method == "requestRebirth" then
				return self:requestRebirth(player)
			end
			warn("[RebirthService] Unknown method:", method)
			return false, nil
		end
		print("[RebirthService] OnServerInvoke set successfully")
	else
		warn("[RebirthService] RemoteFunction not found")
	end

	local remoteEvent = rebirthRemotes:FindFirstChild("RemoteEvent")
	if remoteEvent then
		remoteEvent.OnServerEvent:Connect(function(player: Player, method: string, ...)
			if method == "requestRebirth" then
				self:requestRebirth(player)
			end
		end)
	end

	print("[RebirthService] Initialized")
end

function RebirthService:requestRebirth(player: Player)
	local data = DataService:waitForData(player)
	if not data then
		warn("[RebirthService] No data for", player.Name)
		return false, "Profile unavailable"
	end

	self._rebirthing = self._rebirthing or {}
	if self._rebirthing[player.UserId] then
		warn("[RebirthService] Already rebirthing:", player.Name)
		return false, "Already processing rebirth"
	end
	self._rebirthing[player.UserId] = true

	local success, result, errMsg = pcall(function()
		local currentRebirths = data:get("rebirths") or 0
		local currentGoop     = data:get("goop") or 0

		local cost = RebirthServiceUtils.getCost(currentRebirths)
		if currentGoop < cost then
			return false, "Not enough goop"
		end

		local newRebirths = currentRebirths + 1
		local newGoop     = currentGoop - cost

		DataService:set(player, "goop",     newGoop)
		DataService:set(player, "rebirths", newRebirths)

		DataService:set(player, "coins", 0)

		DataService:set(player, "zone",        1)
		DataService:set(player, "maxZone",     1)
		DataService:set(player, "furthestZone", 1)


		print("[RebirthService]", player.Name,
			"rebirthed! rebirths:", newRebirths,
			"| goop spent:", cost,
			"| goop remaining:", newGoop)

		return true, newRebirths
	end)

	self._rebirthing[player.UserId] = nil

	if not success then
		warn("[RebirthService] pcall error for", player.Name, ":", result)
		return false, "Server error"
	end

	return result, errMsg
end

return RebirthService