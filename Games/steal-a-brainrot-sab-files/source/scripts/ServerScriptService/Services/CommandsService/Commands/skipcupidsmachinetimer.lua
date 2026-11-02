local Players = game:GetService("Players")
local NotificationService = require(game.ServerScriptService.Services.NotificationService)
local Rarities = require(game.ReplicatedStorage.Datas.Rarities)
local AnimalsDB = require(game.ReplicatedStorage.Datas.Animals)

local module = function(Conch, Config)
	Conch.register("skipcupidsmachinetimer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return 
		end,
		callback = function()
			local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)
			local CupidsMachineService = require(game:GetService("ServerScriptService").Services.CupidsMachineService)

			for _, player in Players:GetPlayers() do
				local Data = Synchronizer:Get(player)
				if not Data then continue end

				local cupids = Data:Get("CupidsMachine")
				local currentTime = workspace:GetServerTimeNow()

				if cupids and cupids.StartTime and cupids.StartTime ~= 0 and currentTime < cupids.FinishTime then
					cupids.FinishTime = currentTime
					Data:Set("CupidsMachine", cupids)

					NotificationService.Notify(
						player,
						string.format('Admin skipped your <font color="#d943ff">Cupid\'s Machine timer</font>!'),
						5,
						"Sounds.Sfx.Success"
					)
				end
			end

			return true, "Skipped all active Cupid's Machine timers"
		end,
	})
end

return module