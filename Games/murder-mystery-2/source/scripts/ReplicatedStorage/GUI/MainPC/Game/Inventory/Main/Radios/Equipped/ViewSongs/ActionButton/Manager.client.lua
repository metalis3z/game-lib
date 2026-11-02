local plr = game.Players.LocalPlayer

script.Parent.MouseButton1Click:Connect(function()
	plr.PlayerGui.MainGUI.Game.Inventory.Visible = false
	plr.PlayerGui.MainGUI.Game.Radio.Visible = true
end)