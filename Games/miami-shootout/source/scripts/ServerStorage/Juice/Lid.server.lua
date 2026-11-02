local acti = false

local uses = 7

local idle

local tool = script.Parent

local anim = Instance.new("Animation")
anim.AnimationId = "http://www.roblox.com/Asset?ID=9584388618" 
local track3
tool.Equipped:Connect(function()
	wait(0.01)
	track3 = script.Parent.Parent.Humanoid:LoadAnimation(anim)
	track3.Priority = Enum.AnimationPriority.Action
	track3.Looped = true
	track3:Play()
end)

tool.Unequipped:Connect(function()
	if track3 then
		track3:Stop()
	end
end)

script.Parent.Activated:Connect(function()
	
		local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
		
		if acti == false and uses == 7 then
			
			local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Cup.Cork)
		animation:Play()
		wait(1)
		script.Parent.Handle["Lid "].Transparency = 1
			
			acti = true
			wait(.2)
		script.Parent.Handle["Open Lid"]:Play()
		wait(1)
		script.Parent.Cup.Disabled = false
		script.Disabled = true
			
					uses = uses - 1

			
			wait(1)
			
			acti = false
			
			return
		
		elseif acti == false and uses <7 then
	
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

		plr.Character.Humanoid.Health = plr.Character.Humanoid.Health + 5

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

