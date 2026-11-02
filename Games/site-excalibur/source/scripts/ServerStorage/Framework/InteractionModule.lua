local module = {}

game.ReplicatedStorage.Events.InteractionEvent.OnServerEvent:Connect(function(plr, object)
	local InteractedObject = require(object.Configuration.InteractMain)
	InteractedObject.Interact(plr,object)
end)

return module