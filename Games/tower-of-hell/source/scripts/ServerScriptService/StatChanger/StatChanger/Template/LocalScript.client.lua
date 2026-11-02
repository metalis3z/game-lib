script.Parent.Submit.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Stat:FireServer(script.Parent.Title.Text, script.Parent.Stat.Text)
end)