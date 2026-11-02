game.ReplicatedStorage.Engine.RemotesEvents.DisplayMessage.OnClientEvent:Connect(function(message)
	game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage('<font color= "rgb(0, 255, 255)">'..message..'</font>')	
end)
