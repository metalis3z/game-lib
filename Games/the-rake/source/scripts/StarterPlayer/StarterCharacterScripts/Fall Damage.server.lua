wait(0.1)
falldown = script.Parent
hed 	   = falldown:WaitForChild("Head")
torso	   = falldown:WaitForChild("Torso")
humanoid = falldown:WaitForChild("Humanoid")

debounce = false

game:GetService("ContentProvider"):Preload("rbxassetid://167094166")
game:GetService("ContentProvider"):Preload("rbxassetid://166221285")
game:GetService("ContentProvider"):Preload("rbxassetid://166221367")

humanoid.FreeFalling:connect(function(falling)
	
	if not falling then
		if not debounce then
			debounce = true
			if torso.Velocity.Y < -70 and torso.Velocity.Y > -100  then				
				humanoid.Health = humanoid.Health + torso.Velocity.Y / 1.7
				if humanoid.Health < 1 then
					
					local dedsound = hed:FindFirstChild("Died")
					if dedsound then
						if dedsound:IsA("Sound") then
							dedsound.Volume = 0
						end
					end
					
					torso.RotVelocity = torso.RotVelocity + Vector3.new(
						math.random(-40,40),
						math.random(-40,40),
						math.random(-40,40)
					)
				end
				script.Parent.Torso.FallSound:Play()
			elseif torso.Velocity.Y < -100 then
				humanoid.Health = humanoid.Health + torso.Velocity.Y / 1.7
				if humanoid.Health < 1 then
					
					for _,bodysplat in pairs(hed:GetChildren()) do
						if bodysplat:IsA("Sound") then
							if bodysplat.SoundId == "" then
								bodysplat.Volume = 0
							end
						end
					end
					
					torso.RotVelocity = torso.RotVelocity + Vector3.new(
						math.random(-90,90),
						math.random(-90,90),
						math.random(-90,90)
					)
				end
				script.Parent.Torso.FallSound:Play()
			end
			wait(.1)
			debounce = false
		end
	else return end
end)