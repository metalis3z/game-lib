local Debounce = false
local RandomSound = math.random(1,2)
local DamageValue = 7500
local Speed = 40
local Force = 50000
function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Debounce == false and Part.Parent:FindFirstChild("NPC") ~= nil then 
			local Humanoid = Part.Parent:FindFirstChild("NPC")
			Debounce = true 
			Humanoid:TakeDamage(DamageValue)
	local particle = script.Parent.Parent.HitParticle:Clone()
	particle.Enabled = true
	particle.Parent = game.Workspace.The_Rake.Torso
	local shockeffect = script.Parent.shockeffect
	shockeffect.Parent = game.Workspace.The_Rake
					shockeffect.Disabled = false
					script.Parent.Parent.ExplodeHit:Play()
			game.Workspace.The_Rake.Stunning.Value = 1
			game.Workspace.The_Rake.Configuration.StunTime.Value = game.Workspace.The_Rake.Configuration.StunTime.Value + 20
			game.Workspace.The_Rake.Stun.GetStuns.Value = game.Workspace.The_Rake.Stun.GetStuns.Value + 19
			if RandomSound == 1 then
				game.Workspace.The_Rake.RakeDied:Play()
			elseif RandomSound == 2 then
				game.Workspace.The_Rake.RakeDied2:Play()
			end
			
			wait(10000)
			Debounce = false
		end
	end 
end 
script.Parent.Touched:connect(OnTouched)