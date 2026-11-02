local team = game.Teams.Inmates
local team2 = game.Teams.Guards

game.Players.PlayerAdded:Connect(function(plr)					
		
	local value = Instance.new("NumberValue")
	value.Parent = plr
	value.Value = 3
	value.Name = "Chance"
	
	--local value2 = Instance.new("BoolValue")
	--value2.Parent = plr
	--value2.Value= true
	--value2.Name = "CanBePolice"
	
	local PunchValue = Instance.new("BoolValue")
	PunchValue.Parent = plr
	PunchValue.Value = false
	PunchValue.Name = "Punched"
	
	plr.CharacterAdded:connect(function(char)
		PunchValue.Value = false
		
		local humanoid = char:WaitForChild("Humanoid") -- Script yields until the humanoid is found
		humanoid.Died:Connect(function() -- Execute upon humanoid entering Dead state.
			if plr.Team == team then
				if not plr.Backpack:FindFirstChildOfClass("Tool") and not char:FindFirstChildOfClass("Tool") and PunchValue.Value == false then
					local tag = humanoid:FindFirstChild("creator")
					
					if tag then
						local Killer = tag.Value
						
						if Killer.Team == team2 then
							local Chance = Killer:WaitForChild("Chance")
							Chance.Value = Chance.Value - 1
							
							spawn(function()
								local Gui = script.WarnGui:Clone()
								Gui.Parent = Killer.PlayerGui

								wait(5)
								
								Gui:Destroy()
							end)
							
							
							if Chance.Value == 0 then
								Chance.Value = 3
								
								Killer.Team = team
								Killer.Character.Humanoid.Health = 0
								Killer.Status.isBadGuard.Value = true
							end
						end
					end
				end
			end
		end)
	end)
end)