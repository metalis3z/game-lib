local MonsterTorso = script.Parent.Torso
local MonsterHumanoid = script.Parent.NPC
local Distance = 7
local RandomDebounce = false

while true do
	wait()
	for i, v in pairs(game.Workspace:GetChildren()) do
		local Human = v:FindFirstChild("Humanoid")
		local Torso = v:FindFirstChild("Torso")
		if Human and Torso and v ~= script.Parent then
			local Debounce = false
			if (MonsterTorso.Position - Torso.Position).magnitude < Distance and Debounce == false and Human.Health > 0  then
				if Human.Health > 0 then
				if Human.Health > 40 then
				local RandomSound = math.random(1,2)
				Debounce = true
				local Animation = script.Parent:FindFirstChild("Swing")
				local Animation2 = script.Parent:FindFirstChild("Swing2")
				local Rake = script.Parent:FindFirstChild("NPC")
				local Attack = Rake:LoadAnimation(Animation)
				local Attack2 = Rake:LoadAnimation(Animation2)
				local AlreadyRandom = false
				if RandomSound == 1 and AlreadyRandom == false then
					AlreadyRandom = true
					Attack:Play()
					AlreadyRandom = false
				end
				if RandomSound == 2 and AlreadyRandom == false then
					AlreadyRandom = true
					Attack2:Play()
					AlreadyRandom = false
				end
				wait(0.2)
			if (MonsterTorso.Position - Torso.Position).magnitude < Distance and Human.Health > 0  then	
				if RandomSound == 2 and AlreadyRandom == false then
					script.Parent.Torso.Hit.Pitch=0.9+(math.random()*0.1)
					script.Parent.Torso.Hit2.Pitch=0.9+(math.random()*0.1) 
				end
				if RandomSound == 1 and AlreadyRandom == false then
					script.Parent.Torso.Hit.Pitch=1.1+(math.random()*0.1)
					script.Parent.Torso.Hit2.Pitch=1.1+(math.random()*0.1)
				end
				if RandomSound == 2 and AlreadyRandom == false then
					script.Parent.Torso.Hit:Play()
				end
				if RandomSound == 1 and AlreadyRandom == false then
					script.Parent.Torso.Hit2:Play()
				end
							Human:TakeDamage(script.Parent.Configuration.Damage.Value)
			end	
				wait(0.3)
				Debounce = false
				--Distance = (MonsterTorso.Position - Torso.Position).magnitude
	end
	end
	end
		end
	end
	end