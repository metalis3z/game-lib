local AnimatePlayerEvent = game.ReplicatedStorage:WaitForChild("AnimatePlayerEvent")
AnimatePlayerEvent.OnServerEvent:Connect(function(player, animationData)
	for _, otherplayer in pairs(game.Players:GetPlayers()) do
		if otherplayer.Character and otherplayer.Character:FindFirstChild("HumanoidRootPart") then
			if otherplayer ~= player and (otherplayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude < 50 then
				AnimatePlayerEvent:FireClient(otherplayer, player, animationData)
			end
		end
	end
end)

-- Created and Fixed by BUILDG Studios