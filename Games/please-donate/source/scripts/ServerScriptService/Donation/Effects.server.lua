--[[
    Adjusted by arxx
]]

local sfcsounds = game.ServerStorage.SFXSounds
local sfceffects = game.ServerStorage.SFXLevels

local WaitTime = {
	Level1 = 2,
	Level2 = 2.25,
	Level3 = 3.5,
	Level4 = 10,
	Level5 = 25,
	Level6 = 40,
}


function GetLevel(RobuxAmount)

	if RobuxAmount >= 10000000 then
		return 6
	elseif RobuxAmount >= 100000 then
		return 5
	elseif RobuxAmount >= 10000 then
		return 4
	elseif RobuxAmount >= 1000 then
		return 3
	elseif RobuxAmount >= 100 then
		return 2
	elseif RobuxAmount >= 1 then
		return 1
	end

end

script.Parent.CreateDonationSFX.Event:Connect(function(Parent, RobuxAmount)




	print(1)
	local Level = GetLevel(RobuxAmount)
	local FallingCoins = sfcsounds.FallingCoins:Clone()
	local DonationSoundd = sfcsounds['DonationLevel' .. Level]:Clone()
	print(1, 2, Level)

	if Level >= 4 then

		local X = Parent.Position.X + math.random(-10, 10)
		local Z = Parent.Position.Z + math.random(-10, 10)
		local Position = Vector3.new(X, 4, Z)

		game.ReplicatedStorage.Events.Fireworks:FireAllClients(Level * 2, Position)
	end


	spawn(function()
		if RobuxAmount >= 1e7 then
			DonationSoundd.Parent = Parent
			DonationSoundd:Play()
		elseif RobuxAmount >= 1e5 then
			DonationSoundd.Parent = Parent
			DonationSoundd:Play()
		elseif RobuxAmount >= 1e4 then
			DonationSoundd.Parent = Parent
			DonationSoundd:Play()
		elseif RobuxAmount >= 1e3 then
			DonationSoundd.Parent = Parent
			DonationSoundd:Play()
		end
	end)



	local DonationSFX = sfceffects['Level' .. Level]

	for i, v in pairs(DonationSFX:GetChildren()) do
		local Particle = v:Clone()

		game.Debris:AddItem(Particle, 60)
		Particle.Parent = Parent

		if v.Name == "Star" then

			Particle:Emit(1)	
			task.wait(1.5)
		elseif v.Name == "Lines" or "RobuxParticles" then
			game.TweenService:Create(Particle, TweenInfo.new(WaitTime['Level' .. Level], Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {Rate = 0}):Play()
			Particle:Emit(Level * 10)	
		elseif v.Name == "Burst2" then
			wait(12)
			Particle.Enabled = false
		elseif v.Name == "Sparkles" then
			game.TweenService:Create(Particle, TweenInfo.new(WaitTime['Level' .. Level], Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {Rate = 0}):Play()
		elseif v.Name == "Sparks" then	
			Particle:Emit(30)
		else
			Particle:Emit(Level)
		end

	end

end)
