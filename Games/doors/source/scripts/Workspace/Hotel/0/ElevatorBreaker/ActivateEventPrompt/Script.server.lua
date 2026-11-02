script.Parent.Triggered:Connect(function(Player)
	game.ReplicatedStorage.EntityInfo.EngageMinigame:FireClient(Player, "ElevatorBreaker")
end)

--[[for i, v in pairs(script.Parent.Parent:GetChildren()) do
	if v.Name == "BreakerSwitch" then
		
	end
end--]]