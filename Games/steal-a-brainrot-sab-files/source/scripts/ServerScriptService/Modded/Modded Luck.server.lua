local animalservice = require(game.ServerScriptService.Services.AnimalService)
local net = require(game.ReplicatedStorage.Packages.Net)
local IsAdmin = require(game.ReplicatedStorage.Shared.IsAdmin)
local remote = net:RemoteEvent("AdminService/ModdedLuck")
local updateremote = net:RemoteEvent("AdminService/UpdateModdedButton")
local eventservice = require(game.ServerScriptService.Services.EventService)
local function setModdedLuck(enabled)
	animalservice.SetRandomMode(enabled)
	updateremote:FireAllClients(enabled)
end
remote.OnServerEvent:Connect(function(player, value)
	if not IsAdmin(player.UserId) then return end
	setModdedLuck(value)
end)
local isVIPServer = game.PrivateServerId ~= ""
if isVIPServer then
	setModdedLuck(false)
else
	setModdedLuck(false)
end