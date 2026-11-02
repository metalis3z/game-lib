local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local FatSammy = require(ServerScriptService.Services.EventService.Events.FatSammy)

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local module = function(Conch, Config)
	Conch.register("FinishEatSammy", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
	
		end,
		callback = function()
		
		FatSammy:AutoEat()

			return "executed"
		end,
	})
end

return module 