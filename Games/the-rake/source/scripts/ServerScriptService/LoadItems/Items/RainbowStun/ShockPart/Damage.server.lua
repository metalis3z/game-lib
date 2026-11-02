function OnTouched(Part) 
if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			script.Parent.Parent.LightPart.Trail.Enabled = false
local Humanoid = Part.Parent:FindFirstChild("NPC")
local ForceChance = math.random(1,3)
local DamageValue = 50 -- 90
local Speed = 20
local Force = 40000
local RandomShock = math.random(1,3)
if RandomShock == 1 then
script.Parent.ShockSound1:Play()
elseif RandomShock == 2 then
script.Parent.ShockSound2:Play()
elseif RandomShock == 3 then
script.Parent.ShockSound3:Play()
			end
			script.Parent.TaserSound:Play()
			script.Parent.DeflectSound:Play()
			if ForceChance == 1 or ForceChance == 3 then
local bv = Instance.new("BodyVelocity")
bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
bv.Velocity = script.Parent.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
				end
script.Parent.Parent.LightPart.ShockLight.Enabled = true
			script.Parent.Parent.LightPart.ShockEmitter.Enabled = true
			script.Parent.Parent.LightPart.ParticleEmitter.Enabled = true
local TrailElectricity = script.Parent.TrailElectricity:Clone()
TrailElectricity.Parent = Part
TrailElectricity.Enabled = true
Humanoid:TakeDamage(DamageValue)
workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 5
workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 24
workspace.The_Rake.Configuration.StunTime.Script.Disabled = true
workspace.The_Rake.Configuration.StunTime.Script.Disabled = false
script.Disabled=true
end
end 
end
script.Parent.Touched:connect(OnTouched)