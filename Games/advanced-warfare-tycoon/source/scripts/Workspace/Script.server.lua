gui = script.ScreenGui
game.Players.PlayerAdded:connect(function (plr)
	wait(1)
	local qe = script.LocalScript:Clone()
	qe.Parent = plr.PlayerGui
	qe.Disabled = false
	local gui2 = gui:Clone()
	gui2.Parent = plr.PlayerGui
end)