local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()

game.ReplicatedStorage.Engine.RemotesEvents.toggleControlls.OnClientEvent:Connect(function(toggle)
	if toggle then
		controls:Enable()
	else
		controls:Disable()
	end
end)