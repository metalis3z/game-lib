--Made by DemonteDebutois
local SCP = script.Parent
local ServerStorage = game:GetService("ServerStorage")

SCP.Object.ProximityPrompt.Triggered:Connect(function(Player)
	SCP.Object.Coughing:Clone().Parent = Player.Character.Head
	Player.Character.Head.Coughing:Play()
	local RandomChance = math.random(1,9)
	wait(5)
	if RandomChance == 1 or RandomChance == 2 then
		local count = 10
		for i=1, count do
			SCP.Object.ProximityPrompt.Damage:FireClient(Player, "+")
			Player.Character.Humanoid:TakeDamage(10)
			wait(5)
		end
		Player.Character.Humanoid.Health = 0
	end
	if RandomChance == 3 or RandomChance == 4 then
		Player.Character.Humanoid.Health = 0
	end
	if RandomChance == 5 or RandomChance == 6 then
		local Explosion = Instance.new("Explosion")
		Explosion.BlastRadius = 0
		Explosion.BlastPressure = 0
		Explosion.ExplosionType = "NoCraters"
		Explosion.Parent = Player.Character
		local ExplosionSound = Instance.new("Sound")
		ExplosionSound.SoundId = "rbxassetid://142070127"
		ExplosionSound.Volume = 1
		ExplosionSound:Play()
	end
	if RandomChance == 7 or RandomChance == 8 then
		local RandomLimb = math.random(1,4)
		if RandomLimb == 1 then
			Player.Character.LeftUpperArm.LeftShoulder:Destroy()
		end
		if RandomLimb == 2 then
			Player.Character.RightUpperArm.RightShoulder:Destroy()
		end
		if RandomLimb == 3 then
			Player.Character.LeftUpperLeg.LeftHip:Destroy()
		end
		if RandomLimb == 4 then
			Player.Character.RightUpperLeg.RightHip:Destroy()
		end
	end
	if RandomChance == 9 then
		local InfectionScript = ServerStorage.FunctionalAssets.SCPs["SCP-1025"]:Clone()
		InfectionScript.Parent = Player.Character
		InfectionScript.Disabled = false
		InfectionScript.Coughing:Play()
	end
end)