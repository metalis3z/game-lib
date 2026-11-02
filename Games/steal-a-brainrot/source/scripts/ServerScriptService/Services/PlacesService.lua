local PlacesService = {}

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerData = require(ReplicatedStorage.Datas:WaitForChild("ServerData"))

local PlacesIDS = {
	Content = ServerData.ContentPlaceId,
	Duels = ServerData.DuelsPlaceId,
	Tsunami = ServerData.TsunamiPlaceId,
	NewPlayers = ServerData.NewPlayersPlaceId,
	Root = ServerData.RootPlaceId
}

function PlacesService:TeleportPlayer(Player, ServerType)
	local PlaceId = PlacesIDS[ServerType]
	if not PlaceId then
		warn("[PlacesService] Unknown server type:", ServerType)
		return false
	end

	TeleportService:Teleport(PlaceId, Player)
	return true
end

function PlacesService:TeleportPlayers(Players, ServerType)
	local PlaceId = PlacesIDS[ServerType]
	if not PlaceId then
		warn("[PlacesService] Unknown server type:", ServerType)
		return false
	end

	TeleportService:TeleportAsync(PlaceId, Players)
	return true
end

function PlacesService:TeleportAll(ServerType)
	return self:TeleportPlayers(Players:GetPlayers(), ServerType)
end

return PlacesService