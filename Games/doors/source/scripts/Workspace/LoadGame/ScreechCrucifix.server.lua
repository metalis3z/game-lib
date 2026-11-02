game.Workspace.GameSettings.Fires.ScreechCrucifix.OnServerEvent:Connect(function(player, model, code)
	if game.Workspace:FindFirstChild("Screech") then
		
	else
		if code == "cameadadadwwfafw" then
			local ScreechCloned = game.ReplicatedStorage.Entities.Screech:Clone()

			ScreechCloned.Script.Enabled = true
			script.Crucifix_Config:Clone().Parent = ScreechCloned
			ScreechCloned.Parent = game.Workspace
			ScreechCloned:PivotTo(model)
		else
			player:Kick(
				"Developer has shut down all game servers or game server has shut down for other reasons, please reconnect!"
			)
		end
	end
end)