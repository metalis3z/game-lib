game.ReplicatedStorage.LevelChatted.OnClientEvent:Connect(function(Player)
	game.StarterGui:SetCore('ChatMakeSystemMessage', {
		Text = Player.Name .. ' has just prestiged!', 
		Font = Enum.Font.SourceSansBold, 
		Color = Color3.new(255, 255, 255), 
		FontSize = Enum.FontSize.Size12
	})
end)