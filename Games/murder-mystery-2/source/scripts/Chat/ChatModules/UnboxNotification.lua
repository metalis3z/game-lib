local CommandModules = script.Parent

return function(ChatService)
	game.ReplicatedStorage.ServerMessage.Event:connect(function(player, message)
		ChatService:SendMM2Message(player, message)
	end)
end