local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 40
function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Debounce == false and Part.Parent:FindFirstChild("NPC") ~= nil then 
			script.Parent.Parent.Stamina.Value = 0
			script.Parent.Damaged.Value = true
			Debounce = true 
			Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
			
			--script.Parent.LongerStun.Disabled = true
			--script.Parent.ShockSound:Play()
			--script.Parent.Parent.LightPart.ShockLight.Enabled = true
			--script.Parent.Parent.LightPart.ParticleEmitter.Enabled = true
workspace.The_Rake.Stunning.Value = 1
workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 6
workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 70
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
			script.Parent.Damaged.Value = false
script.Disabled=true
wait(0.5)
Debounce = false
--elseif Part.Parent ~= nil then
			--if Debounce == false and Part.Parent:FindFirstChild("NPC") == nil then
				--Debounce = true
				--script.Parent.ShockSound:Play()
				--script.Parent.Parent.LightPart.ShockLight.Enabled = true
				--script.Parent.Parent.LightPart.ParticleEmitter.Enabled = true
				--wait(0.5)
				--Debounce = false
			--end
end
end 
end 
script.Parent.Touched:connect(OnTouched)