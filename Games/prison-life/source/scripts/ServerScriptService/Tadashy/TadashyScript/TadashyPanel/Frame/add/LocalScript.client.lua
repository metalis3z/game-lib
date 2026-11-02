script.Parent.MouseButton1Click:Connect(function()
	local text = script.Parent.Parent.TextBox.Text
	game.ReplicatedStorage.TadashyConfig.addgrosmots:FireServer(text)
end)