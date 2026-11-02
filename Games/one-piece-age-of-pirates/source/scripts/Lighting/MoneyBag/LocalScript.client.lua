script.Parent.Activated:connect(function(mouse)
	game.Players.LocalPlayer.Data.Money.Value = game.Players.LocalPlayer.Data.Money.Value + script.Parent.Value.Value
	script.Parent:remove()
end)