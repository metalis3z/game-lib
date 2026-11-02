repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 4000
local Speed = 450
local Force = 1500000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 5
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 10
				script.Parent.ShockPart.ShockSound:Play()
				script.Parent.ShockPart.ShockSound2:Play()
				script.Parent.ShockPart.ShockSound3:Play()
				game.Workspace.RakeHammerDamage:Play()
				local particles = script.Parent.Base.HAMMER.HammerHitParticle2:Clone()
				particles.Enabled = true
				particles.Parent = game.Workspace.The_Rake.Torso
				local light = script.Parent.Base.HAMMER.hitlight2:Clone()
				light.Enabled = true
				light.Parent = game.Workspace.The_Rake.Torso
				local scripthammer = script.Parent.ShockPart.hammershock2:Clone()
				scripthammer.Disabled = false
				scripthammer.Parent = game.Workspace.The_Rake
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
				workspace.The_Rake.NPC.PlatformStand = true
				wait(0.1)
				workspace.The_Rake.NPC.PlatformStand = false
				if RandomSound == 1 then
					workspace.The_Rake.RakeDied:Play()
				elseif RandomSound == 2 then
					workspace.The_Rake.RakeDied2:Play()
				elseif RandomSound == 3 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt4:Play()
				end
			end 
		end 
	end 
end

script.Parent.ShockPart.Touched:connect(OnTouched)


script.RemoteEvent.OnServerEvent:Connect(function()
	if char.StaminaBar.Stamina.Value > 150 and script.Parent.Canbeused.Value == true and script.Parent.Attacking2.Value == false then
		script.Parent.Attacking2.Value = true
		script.Parent.Attacking.Value = true
		Swing:Play()
		wait(0.14)
		script.Parent.Base.SwingSound:Play()
		char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 150
		char.StaminaBar.StaminaRefill.Disabled = true
		char.StaminaBar.StaminaRefill.Disabled = false
		wait(0.1)
		Damage = true
		wait(0.7)		
		Damage = false
		wait(1)
		script.Parent.Attacking.Value = false
		wait(80)
		script.Parent.Attacking2.Value = false
	end
end)
