local TeleportService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TPService = game:GetService("TeleportService")
local DataStoreService = game:GetService("DataStoreService")

local ReservedServers = DataStoreService:GetDataStore("ReservedServers")

local Net = require(ReplicatedStorage.Packages.Net)

local Reconnect = Net:RemoteEvent("TeleportService/Reconnect")
local TeleportToPrivate = Net:RemoteFunction("TeleportService/TeleportToPrivate")
local TeleportToGame = Net:RemoteEvent("TeleportService/TeleportToGame")

function TeleportToPrivate.OnServerInvoke(player: Player, placeId: number, privateServer: string)
	if not placeId or typeof(placeId) ~= "number" then
		return false, "Invalid placeId"
	end

	if not privateServer or typeof(privateServer) ~= "string" then
		return false, "Invalid privateServer code"
	end

	local reservedCode

	local success, err = pcall(function()
		if privateServer == "" then
			reservedCode = TPService:ReserveServer(placeId)
			TPService:TeleportToPrivateServer(placeId, reservedCode, {player})
		else
			TPService:TeleportToPrivateServer(placeId, privateServer, {player})
		end
	end)

	if not success then
		return false, "Teleport failed: " .. tostring(err)
	else
		if reservedCode then
			ReservedServers:SetAsync(player.UserId, reservedCode)
		end
	end

	return true
end

Reconnect.OnServerEvent:Connect(function(player: Player)
	TPService:Teleport(game.PlaceId, player)
end)

TeleportToGame.OnServerEvent:Connect(function(player: Player, gameId: number)
	if not gameId or typeof(gameId) ~= "number" then
		warn("[TeleportService] Invalid gameId from player:", player)
		return
	end

	local success, err = pcall(function()
		TPService:Teleport(gameId, player)
	end)

	if not success then
		warn("[TeleportService] Teleport failed for", player, ":", err)
	end
end)

return TeleportService