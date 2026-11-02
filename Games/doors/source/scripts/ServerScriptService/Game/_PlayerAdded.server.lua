local Players = game.Players

local Settings = {
	MaxSpeed = 23
}

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		task.wait()
		local root = Character:FindFirstChild("HumanoidRootPart")
		local lastPosition = root.Position
		local lastTime = tick()
		
		while Character.Parent do
			task.wait(0.5)
			
			local timetaken = tick() - lastTime
			local distanceMoved = (lastPosition - root.Position).Magnitude
			local speed = distanceMoved / timetaken
			
			if speed > Settings.MaxSpeed then
				print("CHEATER")
			end
			
			lastPosition = root.Position
			lastTime = tick()
			
		end
	end)
end)