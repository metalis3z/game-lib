game.ReplicatedStorage.Events.CreateChatMessage.OnClientEvent:Connect(function(Message,Color,font)
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			["Text"] = Message,
			["Color"] = Color,
			["Font"] = font
		})
end)