local player = game.Players.LocalPlayer

repeat wait() until player.Character

script.Parent.MouseButton1Click:Connect(function()
	local findradio = player.Character:FindFirstChild("SuperFlyGoldBoombox")
	
	if findradio then
		findradio.NewSong:FireServer(0)
	end
end)