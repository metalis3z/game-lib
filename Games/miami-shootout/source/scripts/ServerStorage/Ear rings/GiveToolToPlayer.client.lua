wait()
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Char = Player.Character
local db = false

local equip = false

script.Parent.Equipped:Connect(function()
	
	equip = true
	
end)

script.Parent.Unequipped:Connect(function()
	
	equip = false
	
end)



Mouse.KeyDown:connect(function(k)
	
	if string.lower(k) == "q" and equip == true then

		local character = Player.Character
		

		local head = Player.Character:WaitForChild("HumanoidRootPart")

		local origin = head.Position
		local lookDirection = head.CFrame.lookVector
		local ray = Ray.new(origin, lookDirection * 50)

		local part, hitPosition = workspace:FindPartOnRay(ray, character)
			
		if not part then print("RETURN") return end 
		local partparent = part.Parent
		
		if part.Parent:FindFirstChild("Humanoid") then
				
				partparent = part.Parent
			else
				partparent = part.Parent.Parent
				
		end
		
		if partparent:FindFirstChild("Humanoid") then

		local HRP = partparent:FindFirstChild("HumanoidRootPart")

		if HRP then
			db = true
			local hit = part
			if (Char.HumanoidRootPart.Position - HRP.Position).magnitude < 5 then
			if game.Players:FindFirstChild(partparent.Name) then
					
			local tool = script.Parent
						
			Char.Humanoid:UnequipTools()
			
			
			if equip == true then equip = false		end
				

			
			local anim1 = Char.Humanoid:LoadAnimation(script.gives)
			anim1:Play()
			
			local anim2 = HRP.Parent.Humanoid:LoadAnimation(script.takes)
			anim2:Play()
			
			local ape = math.random(-2,6)
				
			local a
			
			script.uhah:FireServer(partparent,Player,tool,ape)
			

			wait(.25)
			db = false
			end
			end	

		end
		end
		end
	
end)


