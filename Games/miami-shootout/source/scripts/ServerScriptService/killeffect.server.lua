game.ReplicatedStorage.deathevent.OnServerEvent:Connect(function(p,killer)
	spawn(function()
		local Clone = game.Lighting.Kill.KillEffectLocal:Clone()
		Clone.Parent = killer.PlayerGui 
		Clone.Enabled = true


		local Clone2 = game.Lighting.Kill.KillEffectLocal:Clone()
		Clone2.Parent = p.PlayerGui
		Clone2.Enabled = true

		killer.CLOG.Value = true
		wait(10)
		killer.CLOG.Value = false
	end)
end)