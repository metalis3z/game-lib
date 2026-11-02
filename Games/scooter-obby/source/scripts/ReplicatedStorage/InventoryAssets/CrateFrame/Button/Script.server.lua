script.Parent.Activated:Connect(function()
	local name
	for i, v in pairs(script.Parent.Parent.CrateImageHolder.Icon:GetChildren()) do
		if not v:IsA("Camera") then
			name = v.Name
		end
	end
	game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.currentSelect.Value = name
	if game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.currentEquip.Value == name then
		game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.Main.Inside.Content.LeftSide.EquipButton.Back.Top.Label.Text = "Equipped"
	else
		game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.Main.Inside.Content.LeftSide.EquipButton.Back.Top.Label.Text = "Equip"
	end
	if name == "Scooter" and game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.currentEquip.Value == "default" then
		game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.Main.Inside.Content.LeftSide.EquipButton.Back.Top.Label.Text = "Equipped"
	end
	if name == "default" and game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.currentEquip.Value == "Scooter" then
		game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.InventoryFrame.Main.Inside.Content.LeftSide.EquipButton.Back.Top.Label.Text = "Equipped"
	end
end)