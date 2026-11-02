repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Clicked = false
local Debounce = false
local DamageValue = 45
local Speed = 35
local Force = 40000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				local RandomPitch = math.random(1,3)
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 2
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 40
				script.Parent.Base.HitSound1:Play()
				if RandomPitch == 1 then
					script.Parent.Base.HitSound2.PlaybackSpeed = 1
				elseif RandomPitch == 2 then
					script.Parent.Base.HitSound2.PlaybackSpeed = 1.025
				elseif RandomPitch == 3 then
					script.Parent.Base.HitSound2.PlaybackSpeed = 1.125
				end
				script.Parent.Base.HitSound2:Play()
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
			end 
		end 
	end 
end

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 30 then
Clicked = true
Swing:Play()
wait(0.2)
script.Parent.Base.SwingSound:Play()
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 30
char.StaminaBar.StaminaRefill.Disabled = true
char.StaminaBar.StaminaRefill.Disabled = false
Damage = true
wait(0.3)		
Damage = false
wait(0.4)
Clicked = false
end
end)

script.Parent.HitBox.Touched:Connect(OnTouched)