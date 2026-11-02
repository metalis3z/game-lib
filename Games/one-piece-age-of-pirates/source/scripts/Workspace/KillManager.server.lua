
function monitorCharacter(char)
	
	char.Humanoid.Changed:connect(function()
		
		if (char.Humanoid.Health <= 0) then
			
			repeat wait() until (char.Parent == nil or char.Humanoid:FindFirstChild("Killer") ~= nil)
			
			if (char.Humanoid:FindFirstChild("Killer") ~= nil) then
				
				local killer = char.Humanoid:FindFirstChild("Killer").Value
				
				if (game.Players:FindFirstChild(killer) ~= nil and game.Players:FindFirstChild(killer):FindFirstChild("Data") ~= nil) then
					
					game.Players:FindFirstChild(killer).Data.Bounty.Value = game.Players:FindFirstChild(killer).Data.Bounty.Value + 500000
					
					char2 = game.Players:FindFirstChild(char.Name)
					themoney = char2.Data.Money.Value * 0.3
					
					char2.Data.Money.Value = char2.Data.Money.Value - themoney
					
					local d = char2.Backpack:GetChildren() 
					for i=1, #d do
					if (d[i].className == "Tool") and (d[i]:FindFirstChild("DevilFruit")) then 
					local clone = d[i]:Clone()
					clone.Parent = game.Players:FindFirstChild(killer).Backpack
					end
					end
					
					local d2 = char2.Character:GetChildren()
					for i2=1, #d2 do
					if (d2[i2].className == "Tool") and (d2[i2]:FindFirstChild("DevilFruit")) then 
					local clone = d2[i2]:Clone()
					clone.Parent = game.Players:FindFirstChild(killer).Backpack
					end
					end
					
					game.Players:FindFirstChild(killer).Data.Money.Value = game.Players:FindFirstChild(killer).Data.Money.Value + themoney / 2
					
				end
			
			end
			
		end
	
	end)
	
end

game.Workspace.ChildAdded:connect(function(char)
	
	if (char.ClassName == "Model" and char:FindFirstChild("Humanoid") ~= nil) then
		
		monitorCharacter(char)
		
	end
	
end)