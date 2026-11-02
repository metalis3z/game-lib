repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Clicked = false
local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 4099
local Speed = 500
local Force = 450000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 10
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 10
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
				workspace.The_Rake.NPC.PlatformStand = true
				script.Parent.button.Transparency = 1
				script.Parent.button2.Transparency = 0
				script.Parent.button.sub.Transparency = 1
				script.Parent.button.sub2.Transparency = 1
				script.Parent.button2.subbed.Transparency = 0
				script.Parent.button2.subbed2.Transparency = 0
				script.Parent.button2.subbedlight.Enabled = true
				script.Parent.button.notsubbed.Enabled = false
				script.Parent.button.ShockSound:Play()
				script.Parent.button.HitSound:Play()
				local scream = math.random(1,2)
				if scream == 1 then
					game.Workspace.subbuttonscream1:Play()
				elseif scream == 2 then
					game.Workspace.subbuttonscream2:Play()
				end
				workspace.The_Rake.NPC.PlatformStand = true
				wait(0.1)
				workspace.The_Rake.NPC.PlatformStand = false
				if RandomSound == 1 then
					workspace.The_Rake.RakeDied:Play()
				elseif RandomSound == 2 then
					workspace.The_Rake.RakeDied2:Play()
				elseif RandomSound == 3 then
					workspace.The_Rake.Head.RakeHurt4:Play()
				end
				wait(1)
				script.Parent.button.Transparency = 0
				script.Parent.button2.Transparency = 1
				script.Parent.button.sub.Transparency = 0
				script.Parent.button.sub2.Transparency = 0
				script.Parent.button2.subbed.Transparency = 1
				script.Parent.button2.subbed2.Transparency = 1
				script.Parent.button2.subbedlight.Enabled = false
				script.Parent.button.notsubbed.Enabled = true	
				end
			end 
		end 
end

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 5 and script.Parent.Can.Value == true then
Clicked = true
Swing:Play()
		wait(0.14)
		local randomswingsound = math.random(1,3)
		if randomswingsound == 1 then
			script.Parent.Base.SwingSound:Play()
		elseif randomswingsound == 2 then
			script.Parent.Base.SwingSound2:Play()
		elseif randomswingsound == 3 then
			script.Parent.Base.SwingSound3:Play()
		end
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 5
char.StaminaBar.StaminaRefill.Disabled = true
		char.StaminaBar.StaminaRefill.Disabled = false
wait(0.1)
Damage = true
wait(0.6)		
		Damage = false
wait(1)
Clicked = false
end
end)

script.Parent.ShockPart.Touched:connect(OnTouched)