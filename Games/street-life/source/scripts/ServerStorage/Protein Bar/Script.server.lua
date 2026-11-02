local acti = false

local maxUses = 10
local uses = maxUses

local idle

script.Parent.Activated:Connect(function()
	local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
	if acti == false and uses <= maxUses then
		acti = true
		uses = uses - 1

		local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Drink)
		animation.Priority = Enum.AnimationPriority.Action2
		animation:Play()
		animation:AdjustSpeed(1.5)

		local sound = script.Parent.Handle.Eat
		wait(.2)
		sound:Play()
		wait(1)
		
		plr.Character.Humanoid.Health = plr.Character.Humanoid.Health + math.random(4, 6)
		
		plr.Character:FindFirstChild('Boost').Value = true
		spawn(function()
			task.wait(120)
			if plr.Character:FindFirstChild('Boost').Value == true then
				plr.Character:FindFirstChild('Boost').Value = false
			end
		end)
		
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