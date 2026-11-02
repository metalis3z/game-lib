





local acti = false

local uses = 15

local idle

script.Parent.Activated:Connect(function()
	
		local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
		
		if acti == false and uses == 15 then
			
			local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Cork)
			animation:Play()
			
			acti = true
			wait(.2)
			script.Parent.Handle.Cap:Play()
			
				uses = uses - 1

			
			wait(1)
			
			acti = false
			
			return
		
		elseif acti == false and uses <15 then
	
		acti = true

	
	
		local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Drink)
		animation:Play()
		uses = uses - 1
		local a = script.Fooderyes:Clone()
		
		a.Parent = plr.PlayerGui
		a.Disabled = false
		
		game.Debris:AddItem(a,1)
			
		local sound = script.Parent.Handle.Drink
		wait(.2)
		sound:Play()

		
		
		wait(2)



		uses = uses - 1

		plr.Character.Humanoid.Health = plr.Character.Humanoid.Health + 14

		if uses == 0 then
			if idle then
				idle:Stop()
				
			end
			
		script.Parent:Destroy()
		
	
		end
		
		wait(.2)
		
		acti = false
	
	end
end)


script.Parent.Equipped:Connect(function()
	
local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
	
	idle = plr.Character.Humanoid:LoadAnimation(script.Parent.Idle)
	
	
	idle:Play()
	
	
end)


script.Parent.Unequipped:Connect(function()
	
	if idle then
		
		idle:Stop()
		
	end
	
end)

