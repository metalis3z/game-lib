script.Parent.MouseButton1Click:connect(function(person)
	bag = game.Lighting.MoneyBag:Clone()
	bag.Parent = game.Players.LocalPlayer.Backpack
	bag.Value.Value = script.Parent.Parent.TextBox.Text
	if bag.Value.Value > game.Players.LocalPlayer.Data.Money.Value or bag.Value.Value <= 0 then
		bag:Destroy()
		script.Parent.Parent.Parent:Destroy()
		return
	end
	game.Players.LocalPlayer.Data.Money.Value = game.Players.LocalPlayer.Data.Money.Value - bag.Value.Value
	script.Parent.Parent.Parent:Destroy()
end)