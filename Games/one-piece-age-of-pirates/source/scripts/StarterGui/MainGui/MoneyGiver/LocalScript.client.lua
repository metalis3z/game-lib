script.Parent.MouseButton1Click:connect(function(person)
	money = game.Lighting.MoneyGiver:Clone()
	money.Parent = game.Players.LocalPlayer.PlayerGui
end)