local Debounce = false
local RandomSound = math.random(1,2)
local DamageValue = 1500
local Speed = 40
local Force = 50000
function OnTouched(Part) 
	if Part.Parent ~= nil then
	if Debounce == false and Part.Parent:FindFirstChild("NPC") ~= nil then 
	local Humanoid = Part.Parent:FindFirstChild("NPC")
	Debounce = true 
	Humanoid:TakeDamage(DamageValue)
	local particle1 = script.Parent.Parent.Parent.firehitparticle1:Clone()
	particle1.Enabled = true
	particle1.Parent = game.Workspace.The_Rake.Torso
	local particle2 = script.Parent.Parent.Parent.firehitparticle2:Clone()
	particle2.Enabled = true
	particle2.Parent = game.Workspace.The_Rake.Torso
	local light = script.Parent.Parent.Parent.hitlights.firehit:Clone()
	light.Enabled = true
	light.Parent = game.Workspace.The_Rake.Torso
	local shockscript = script.Parent.Parent.effects.fire:Clone()
	shockscript.Parent = game.Workspace.The_Rake
	shockscript.Disabled = false
	script.Parent.Parent.Parent.ExplodeHit:Play()
			game.Workspace.The_Rake.Stunning.Value = 1
			game.Workspace.The_Rake.Configuration.StunTime.Value = game.Workspace.The_Rake.Configuration.StunTime.Value + 16
			game.Workspace.The_Rake.Stun.GetStuns.Value = game.Workspace.The_Rake.Stun.GetStuns.Value + 14
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
script.Parent.Parent.Touched:connect(OnTouched)