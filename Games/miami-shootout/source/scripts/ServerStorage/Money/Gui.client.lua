script.Parent.Equipped:Connect(function()
	local ui = script.Parent.Pocketcash:Clone()
	ui.Parent = game.Players.LocalPlayer.PlayerGui
end)

script.Parent.Unequipped:Connect(function()
game.Players.LocalPlayer.PlayerGui.Pocketcash:Destroy()	
end)