local acti = false

local maxUses = 5
local uses = maxUses

local idle

script.Parent.Activated:Connect(function()
	
		local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
		print(uses)
		if acti == false and uses <= maxUses then
	
		acti = true

		uses = uses - 1
	
		local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Drink)
		animation.Priority = Enum.AnimationPriority.Action2
		animation:Play()
		--local a = script.Fooderyes:Clone()
		
		--a.Parent = plr.PlayerGui
		--a.Disabled = false
		
		--game.Debris:AddItem(a,1)
			
		local sound = script.Parent.Handle.Eat
		wait(.2)
		sound:Play()

		
		
		wait(2)

		plr.Character.Humanoid.Health = plr.Character.Humanoid.Health + 9
		game.ReplicatedStorage.HUNGEREVENT:FireClient(plr,"addHunger",script.Parent.GiveHunger.Value)

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

