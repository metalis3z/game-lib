local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GiveMoneyLogic = require(game.ServerScriptService.Services.CmdrService.Commands.CustomCommands.addcoinsServer)

local net = require(ReplicatedStorage.Packages.Net)
local giveMoneyRemote = net:RemoteFunction("AdminService/GiveMoney")

giveMoneyRemote.OnServerInvoke = function(player, amount, isAdd)
	local targetPlayers = {player}
	local resultMessage = GiveMoneyLogic(nil, targetPlayers, amount, isAdd)

	if string.find(resultMessage, "✅") then
		return true, resultMessage
	else
		return false, resultMessage
	end
end