repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Clicked = false
local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 90
local Speed = 30
local Force = 30000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 5
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 100
				local random = math.random(1,3)
				if random == 1 then
					script.Parent.Base.HitSounds.h1:Play()
				elseif random == 2 then
					script.Parent.Base.HitSounds.h2:Play()
				elseif random == 3 then
					script.Parent.Base.HitSounds.h3:Play()
				end
				script.Parent.Base.Hit1:Play()
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
end

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 45 and script.Parent.Can.Value == true then
Clicked = true
Swing:Play()
script.Parent.Base.SwingSound:Play()
wait(0.14)
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 45
char.StaminaBar.StaminaRefill.Disabled = true
char.StaminaBar.StaminaRefill.Disabled = false
wait(0.3)
Damage = true
wait(0.6)		
Damage = false
wait(1)
Clicked = false
end
end)

script.Parent.ShockPart.Touched:connect(OnTouched)