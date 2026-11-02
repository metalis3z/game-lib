local module = {}
local charReplication = require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication)
local Actors = require(game.ReplicatedStorage.Modules.Actors)

module.Received = function(Player, Buffer)
	local actor = Actors.CurrentActors[Player]
	if not actor then return end
	local clientCFrame, clientVector = charReplication.Deserialize(Buffer)
	actor.ClientCF = clientCFrame
	actor.ClientV = clientVector
	actor.LastClientCFUpdateTime = tick()
end

return module
