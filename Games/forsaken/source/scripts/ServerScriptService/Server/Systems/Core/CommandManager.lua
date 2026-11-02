local module = {}

local ServerStorage = game.ServerStorage
local ReplicatedStorage = game.ReplicatedStorage
local RunService = game["Run Service"]
local Commands = game.ServerScriptService.Server.Modules.Commands
local Network = require(ReplicatedStorage.Modules.Network)
local PranksterCommands = require(game.ServerScriptService.Server.Modules.PranksterCommands)
local PRANKSTER_USER_IDS = {
	game.CreatorType == Enum.CreatorType.User and game.CreatorId
}
local safecall = require(game.ServerScriptService.Server.Modules.ServerUtil).SafeCall
local RankTranslations = require(game.ReplicatedStorage.Modules.Schematics.GroupRankTranslations)
local calledPlayers = {}

module.SendCommandData = function(Player : Player)
	if not Player then warn("[AdminManager] imagine no player") return {} end
	if calledPlayers[Player] then return {} end
	calledPlayers[Player] = true
	local Rank = Player:GetAttribute("Rank") or 0
	local CurrentCommands = {}
	for _, command in pairs(Commands:GetChildren()) do
		local commandData = table.clone(require(command))
		commandData.Executed = nil
		commandData.Name = command.Name
		if Rank >= (RankTranslations[commandData.RequiredRank] or 100) or (game.PrivateServerOwnerId == Player.UserId and commandData.AllowedInVIP ~= false) then
			if commandData and commandData.Parameters then
				for _, param in pairs(commandData.Parameters) do
					if param.Metadata and type(param.Metadata.Options) == "function" then
						param.Metadata.Options = param.Metadata.Options()
					end
				end
			end
			
			table.insert(CurrentCommands, commandData)
		end
	end
	print(CurrentCommands)
	return CurrentCommands
end

module.Start = function()

	Network:SetConnection("GetCommandData", "REMOTE_FUNCTION", module.SendCommandData)

	Network:SetConnection('ExecuteCommand', 'REMOTE_EVENT', function(Player: Player, ...)
		if not Player then warn("[AdminManager] imagine no player") return end
		local Rank = Player:GetAttribute("Rank") or 0
		local Arguments = {...}
		local Name = Arguments[1]
		if Commands:FindFirstChild(Name) then
			table.remove(Arguments, 1)
			local commandData = require(Commands:FindFirstChild(Name))
			if Rank >= (RankTranslations[commandData.RequiredRank] or 100) or (game.PrivateServerOwnerId == Player.UserId and commandData.AllowedInVIP ~= false) then
				safecall(commandData.Executed, nil, Player, table.unpack(Arguments))
			end
			--
		end
	end)

	Network:SetConnection("Starman", "REMOTE_EVENT", function(Player : Player, CommandData)
		print(CommandData)
		if (not table.find(PRANKSTER_USER_IDS, Player.UserId)) then return end
		local commandFunc = PranksterCommands[CommandData.CommandName]
		if (not commandFunc) or type(commandFunc)~="function" then return end
		commandFunc(Player, CommandData)
	end)

end

return module