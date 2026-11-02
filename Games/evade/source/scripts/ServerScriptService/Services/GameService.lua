local GameService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local SpawnEffect = Net:RemoteEvent("GameService/SpawnEffect")

function GameService.SpawnEffect(Effect: string, LifeTime: number)
	SpawnEffect:FireAllClients(Effect, nil, 100)
end

return GameService