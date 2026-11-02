game.ReplicatedStorage.Events.PromptEvent.OnClientEvent:Connect(function()
	script.Parent.Visible = true
end)

script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Visible = false
	game.ReplicatedStorage.Events.ReadyUpForEvent:FireServer()
end)