local team = game.Teams.Guards
local Debris = game.ReplicatedStorage:WaitForChild("Debris")

game:GetService('Players').PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			if player.Team == team then
				local number = math.random(1,5)
				if number <=2  then
					local key = Debris.keycard:Clone()
					key.Parent = game.Workspace.keys
					key.Position = character.Head.Position
					--print("spawned Key Card")
					
					spawn(function()
						wait(50)
						key:Destroy()
					end)
				else
					local m9 = Debris.M9:Clone()
					m9.Parent = game.Workspace.keys
					m9.Position = character.Head.Position
					--print("spawned M9")
					
					spawn(function()
						wait(50)
						m9:Destroy()
					end)
				end
			end
		end)
	end)
end)

