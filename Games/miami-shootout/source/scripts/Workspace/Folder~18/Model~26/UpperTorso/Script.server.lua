local ClickDetector = script.Parent.ClickDetector

ClickDetector.MouseClick:Connect(function(Player)
	if Player.PlayerGui:FindFirstChild("Job") == nil then
		local UI = game.ServerStorage.GUIS.Job:Clone()
		UI.Parent = Player.PlayerGui
	end
end)