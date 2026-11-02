-- GameplayServiceClient (Client ModuleScript)
-- Place: ReplicatedStorage > Source > Features > Gameplay > GameplayServiceClient
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.GameplayServiceUtils)
local Networker = require(ReplicatedStorage.Packages.Networker)
local GameplayClient = require(ReplicatedStorage.Source.Features.Gameplay.Classes.GameplayClient)
local DataService = require(ReplicatedStorage.Packages.DataService).client
return {
	init = function(p1)
		p1.networker = Networker.client.new("GameplayService", p1)
		task.spawn(function()
			DataService:waitForData()
			local v5
			local attempts = 0
			repeat
				attempts += 1
				v5 = p1.networker:fetch("getGameplayData")
				if not v5 then task.wait(1) end
			until v5 or attempts >= 10
			if not v5 then return end
			p1.gameplay = GameplayClient.new(v5)
		end)
	end,
}