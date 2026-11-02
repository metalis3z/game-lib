local DoorMessage = game.ReplicatedStorage:WaitForChild("DoorMessage")
debounce = false

DoorMessage.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." made it to the top!"
		})
		debounce = false
	end
end)