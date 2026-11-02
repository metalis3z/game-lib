script.Parent.MouseButton1Click:Connect(function()
	local text = script.Parent.Text
	
	game.ReplicatedStorage.TadashyConfig.deletegrosmots:FireServer(text)
	script.Parent:Destroy()
end)
