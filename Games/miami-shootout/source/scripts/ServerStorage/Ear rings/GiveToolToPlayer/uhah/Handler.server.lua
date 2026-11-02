

local db = false

script.Parent.OnServerEvent:connect(function(plr,who,from,tool,L5)
	
	local character = plr.Character
	local head = plr.Character:WaitForChild("HumanoidRootPart")
	local origin = head.Position
	local lookDirection = head.CFrame.lookVector
	local ray = Ray.new(origin, lookDirection * 50)
	
	local part, hitPosition = workspace:FindPartOnRay(ray, character)
	
	if not part then print("RETURN") return end 
	local partparent = part.Parent
	
	if part.Parent:FindFirstChild("Humanoid") then
		
	
	
	
	
	
	if plr ~= who then
	
	if tool:IsA("Tool") and tool.Parent == plr.Backpack then
	
	
	if plr == script.Parent.Parent.Parent.Parent.Parent then
	
	
	
	if plr.Character.Humanoid.Health <=0 then
		---not giving tools while dead
		return
		
	end	
	

	db = true
	
	wait(.4)
		
		
		local Char = plr.Character:FindFirstChild("HumanoidRootPart")
		
		
		
		if (Char.Position - who.HumanoidRootPart.Position).magnitude < 5 then			
		--gorilla check
		
		if L5 and L5 >=-2 and L5 <=6 then
			---retard check
			
			local plrer = game.Players:GetPlayerFromCharacter(who)
				
				


				tool.Parent = plrer.Backpack
					

	
		end


	
	

	
		end
		


	wait(.5)
		db = false
		
		
		
	
		end
		
		
		
	end
		
		
	end
		
		
	end
end)






