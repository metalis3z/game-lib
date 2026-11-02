repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Equip = char:WaitForChild("Humanoid"):LoadAnimation(script.Equip)
local Idle = char:WaitForChild("Humanoid"):LoadAnimation(script.Idle)
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Clicked = false
local Debounce = false
local DamageValue = 40
local Speed = 35
local Force = 40000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				local RandomSound = math.random(1,3)
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 5
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 40
				script.Parent.Base.Hit:Play()
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				game.Debris:AddItem(bv,0.1)
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.01)
				workspace.The_Rake.NPC.PlatformStand = true
				wait(0.1)
				workspace.The_Rake.NPC.PlatformStand = false
				if RandomSound == 1 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt:Play()
				elseif RandomSound == 2 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt2:Play()
				elseif RandomSound == 3 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt3:Play()
				end
			end 
		end 
	end 
end

script.Parent.Equipped:Connect(function()
	Idle:Play()
	Equip:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)

script.Parent.Activated:Connect(function()
if Clicked == false and script.Parent.Parent.StaminaBar.Stamina.Value > 24 then
Clicked = true
Swing:Play()
wait(0.2)
		script.Parent.Base.Swing:Play()
		script.Parent.Parent.StaminaBar.Stamina.Value = script.Parent.Parent.StaminaBar.Stamina.Value - 24
		script.Parent.Parent.StaminaBar.StaminaRefill.Disabled = true
		script.Parent.Parent.StaminaBar.StaminaRefill.Disabled = false
Damage = true
wait(0.7)		
Damage = false
wait(0.3)
Clicked = false
end
end)

script.Parent.Base.Touched:connect(OnTouched)