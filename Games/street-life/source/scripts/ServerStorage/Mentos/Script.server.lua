local acti = false
local uses = 3
local idle

script.Parent.Activated:Connect(function()
	local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
	if acti == false then
		acti = true
		local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Eat)
		animation:Play()

		local sound = script.Parent.Handle.Eat
		wait(.5)
		sound:Play()

		if script.Parent.Handle.Transparency == 0 then
			script.Parent.Handle.Transparency = 1
		elseif script.Parent.Skittle1.Transparency == 0 then
			script.Parent.Skittle1.Transparency = 1
		else script.Parent.Skittle2.Transparency = 1
		end

		wait(2)

		uses = uses - 1
		local a = script.Fooderyes:Clone()
		a.Parent = plr.Character
		a.Enabled = true

		game.Debris:AddItem(a, 40)

		if plr.Character.Humanoid.MaxHealth < 140 then
			plr.Character.Humanoid.MaxHealth = plr.Character.Humanoid.MaxHealth + 10
		end

		plr.Character.Humanoid.Health = plr.Character.Humanoid.Health + 10

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
	idle = plr.Character.Humanoid:LoadAnimation(script.Parent.Hold)
	idle:Play()
end)


script.Parent.Unequipped:Connect(function()
	if idle then
		idle:Stop()
	end
end)