repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local base = script.Parent.Base
local damagepart = script.Parent.DamagePart
local animations = script.Parent.Animations

local Swing = char:WaitForChild("Humanoid"):LoadAnimation(animations.Swing)
local Clicked = false
local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 85
local Speed = 32
local Force = 40000
local Damage = false

damagepart.Touched:Connect(function(Part)
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				local RandomHit = math.random(1,2)
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 5
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 50
				base.Hit:Play()
				if RandomHit == 1 then
					base.Hit1:Play()
				elseif RandomHit == 2 then
					base.Hit2:Play()
				end
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
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
end)

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 50 then
Clicked = true
Swing:Play()
wait(0.3)
base.Swing:Play()
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 50
char.StaminaBar.StaminaRefill.Disabled = true
char.StaminaBar.StaminaRefill.Disabled = false
Damage = true
wait(0.7)		
Damage = false
wait(0.4)
Clicked = false
end
end)