for _,v in next, workspace:WaitForChild('Zones'):GetChildren() do
	v.Touched:Connect(function(Hit)
		if Hit.Name == 'HumanoidRootPart' then
			if string.find(Hit.Parent.Name, 'NPC ') then return end
			local Player = game:FindService('Players'):GetPlayerFromCharacter(Hit.Parent)
			local Humanoid = Hit.Parent:FindFirstChild('Humanoid')
			if Player then
				if Player.Team and Player.Team == game.Teams.Civilians then
					if Humanoid.Parent:FindFirstChild('Combat').Value == true then
						if v:FindFirstChild('Teleport') then
							Hit.CFrame = v:FindFirstChild('Teleport').CFrame
							game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You cant enter while Combat Logged!', 2)
							if Humanoid.Parent:FindFirstChildOfClass('Tool') then
								Humanoid.Parent:FindFirstChildOfClass('Tool').Parent = Player.Backpack
							end
						end
					else
						if v.Name ~= 'Extra'  then
							Humanoid.MaxHealth = 9e9
							Humanoid.Health = 9e9
						end
					end
				end
			end
		end
	end)

	if v.Name ~= 'Extra' then
		v.TouchEnded:Connect(function(Hit)
			if Hit.Name == 'HumanoidRootPart' then
				if string.find(Hit.Parent.Name, 'NPC ') then return end
				local Player = game:FindService('Players'):GetPlayerFromCharacter(Hit.Parent)
				local Humanoid = Hit.Parent:FindFirstChild('Humanoid')
				if Player then
					if Player.Team and Player.Team == game.Teams.Civilians then
						if Humanoid.Parent:FindFirstChild('Combat').Value ~= true then
							Humanoid.MaxHealth = 100
							Humanoid.Health = 100
							task.wait(1)
							Humanoid.MaxHealth = 100
							Humanoid.Health = 100
						end
						if Player.Character then
							if Player.Character:FindFirstChildOfClass('ForceField') then
								Player.Character:FindFirstChildOfClass('ForceField'):Destroy()
							end
						end
					end
				end
			end
		end)
	end
end

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		Character:WaitForChild('Humanoid')
		Character:FindFirstChild('Humanoid').Seated:Connect(function(Seated)
			if Character:FindFirstChild('Humanoid').MaxHealth >= 250 then
				Character:FindFirstChild('Humanoid').MaxHealth = 100
			end
			if Character:FindFirstChild('Humanoid').Health >= 250 then
				Character:FindFirstChild('Humanoid').Health = 100
			end
			task.wait(1)
			if Character:FindFirstChild('Humanoid').MaxHealth >= 250 then
				Character:FindFirstChild('Humanoid').MaxHealth = 100
			end
			if Character:FindFirstChild('Humanoid').Health >= 250 then
				Character:FindFirstChild('Humanoid').Health = 100
			end
		end)
	end)
end)