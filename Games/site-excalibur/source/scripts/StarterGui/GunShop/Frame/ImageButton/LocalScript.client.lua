button = script.Parent
player = game.Players.LocalPlayer
event = game.ReplicatedStorage.ShopEvents:WaitForChild("CloseGUI")

button.MouseButton1Click:Connect(function()
	event:FireServer(player)
end)