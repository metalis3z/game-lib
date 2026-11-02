task.wait(3)

for _, v in pairs(workspace:WaitForChild('Teleports'):GetDescendants()) do
	if v:IsA('ProximityPrompt') and v.Name == 'Teleport' then
		v.Triggered:Connect(function(Player)
			task.spawn(function()
				if Player.Character then
					if Player.Character:FindFirstChild('HumanoidRootPart') then
						if Player:FindFirstChild('Enter') then
							Player:FindFirstChild('Enter').Value = true
							task.wait(3)
							Player:FindFirstChild('Enter').Value = false
							if Player.Character:FindFirstChild('Humanoid') then
								if Player.Character:FindFirstChild('Humanoid').Health >= 250 then
									Player.Character:FindFirstChild('Humanoid').Health = 100
								end
							end
							if Player.Character:FindFirstChildOfClass('ForceField') then
								Player.Character:FindFirstChildOfClass('ForceField'):Destroy()
							end
						end
					end
				end
			end)
		end)
	end
end