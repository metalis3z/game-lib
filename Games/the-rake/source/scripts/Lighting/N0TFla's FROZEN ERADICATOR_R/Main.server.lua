repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Swing2 = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing2)
local Clicked = false
local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 2350
local Speed = 200
local Force = 25000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 7
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 10
				local shocksound = math.random(1,2)
				if shocksound == 1 then
					script.Parent.Crucible.Blade.ShockSound:Play()
				elseif shocksound == 2 then
					script.Parent.Crucible.Blade.ShockSound2:Play()
				end
				local laserhit = math.random(1,2)
				if laserhit == 1 then
					script.Parent.Crucible.Blade.Hit:Play()
				elseif laserhit == 2 then
					script.Parent.Crucible.Blade.Hit2:Play()
				end
				local particles = script.Parent.Crucible.DamagedParticles:Clone()
				particles.Enabled = true
				particles.Parent = game.Workspace.The_Rake.Torso

				local dmgscript = script.Parent.Crucible.DamageScript:Clone()
				dmgscript.Parent = game.Workspace.The_Rake.Torso
				dmgscript.Disabled = false
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
				workspace.The_Rake.NPC.PlatformStand = true
				script.Parent.Crucible.HitLight.Enabled = true
				wait(0.1)
				workspace.The_Rake.NPC.PlatformStand = false
				script.Parent.Crucible.HitLight.Enabled = false
				if RandomSound == 1 then
					workspace.The_Rake.RakeDied:Play()
				elseif RandomSound == 2 then
					workspace.The_Rake.RakeDied2:Play()
				elseif RandomSound == 3 then
					workspace.The_Rake.Head.RakeHurt4:Play()
				end
			end 
		end 
	end 
end

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 35 and script.Parent.Can.Value == true then
Clicked = true
		local anim = math.random(1,2)
		if anim == 1 then
			Swing:Play()
		elseif anim == 2 then
			Swing2:Play()
		end
		wait(0.14)
		local randomswingsound = math.random(1,4)
		if randomswingsound == 1 then
			script.Parent.Base.SwingSound:Play()
		elseif randomswingsound == 2 then
			script.Parent.Base.SwingSound2:Play()
		elseif randomswingsound == 3 then
			script.Parent.Base.SwingSound3:Play()
		elseif randomswingsound == 4 then
			script.Parent.Base.SwingSound4:Play()
		end
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 35
char.StaminaBar.StaminaRefill.Disabled = true
		char.StaminaBar.StaminaRefill.Disabled = false
		script.Parent.Crucible.Blade.Trail.Enabled = true
wait(0.1)
Damage = true
wait(0.6)		
		Damage = false
		script.Parent.Crucible.Blade.Trail.Enabled = false
wait(0.2)
Clicked = false
end
end)

script.Parent.ShockPart.Touched:connect(OnTouched)