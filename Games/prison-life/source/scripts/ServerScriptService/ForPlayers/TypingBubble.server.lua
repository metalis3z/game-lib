game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		local TypingBubble = script.TypingBubble:Clone()
		TypingBubble.Parent = Character.Head
	end)
end)

game.ReplicatedStorage.ToggleTypingBubble.OnServerEvent:Connect(function(Player, Toggle)
	Player.Character.Head.TypingBubble.Enabled = Toggle
end)