repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local human = script.Parent.Parent:FindFirstChild("Humanoid")
local char = script.Parent.Parent

local using = false
local debounce = false
local damage = 40
local stunTime = 3
local stun = 20
local forceSpeed = 10
local useCool = true

script.Parent.ConnectM6D.OnServerEvent:Connect(function(plr, location)

	local char = plr.Character
	char["Right Arm"].ToolGrip.Part0 = char["Right Arm"]
	char["Right Arm"].ToolGrip.Part1 = location
end)

script.Parent.DisconnectM6D.OnServerEvent:Connect(function(plr)

	plr.Character["Right Arm"].ToolGrip.Part1 = nil
end)

script.SwingEvent.OnServerEvent:Connect(function()
	using = true
	wait(0.5)
	using = false
end)

script.Parent.Damage.Touched:Connect(function(target)
	if target.Parent ~= nil then
		if debounce == false and target.Parent:FindFirstChild("NPC") ~= nil and using == true then 
			local human = target.Parent:FindFirstChild("NPC")
			debounce = true 
			human:TakeDamage(damage)
			local aSound = math.random(2)
			if aSound == 1 then
				script.Parent.Base.Hit:Play()
			else
				script.Parent.Base.Hit2:Play()
			end
			target.Parent.Configuration.StunTime.Value = target.Parent.Configuration.StunTime.Value + stunTime
			target.Parent.Stun.GetStuns.Value = target.Parent.Stun.GetStuns.Value + stun
			local bv = Instance.new("BodyVelocity")
			bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
			bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * forceSpeed
			bv.Parent = target.Parent.HumanoidRootPart
			game:GetService("Debris"):AddItem(bv,0.1)
			wait(0.8)
			debounce = false
		end
	end 
end)

script.Parent.Activated:Connect(function()
	if useCool == true and char.StaminaBar.Stamina.Value > 25 then
		useCool = false
		char.StaminaBar.Stamina.Value = script.Parent.Parent.StaminaBar.Stamina.Value - 25
		char.StaminaBar.StaminaRefill.Disabled = true
		char.StaminaBar.StaminaRefill.Disabled = false
		wait(0.2)
		script.Parent.Base.Swing:Play()
		wait(0.6)
		useCool = true
	end
end)