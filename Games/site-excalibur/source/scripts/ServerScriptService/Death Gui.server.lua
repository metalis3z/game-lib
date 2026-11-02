function udead(whodat, whodatplr)
	whodat.Humanoid.Died:connect(function()
		script.DeathGui:Clone().Parent = whodatplr.PlayerGui
	end)
end

game.Players.PlayerAdded:connect(function(plr)
	plr.CharacterAdded:wait()
	udead(plr.Character,plr)
	plr.CharacterAdded:connect(function(char)
		udead(char,plr)
	end)
end)