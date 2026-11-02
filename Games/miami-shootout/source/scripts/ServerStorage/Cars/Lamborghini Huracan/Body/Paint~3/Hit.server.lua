function onTouched(part)		
	
	if script.Parent.Velocity.Magnitude > 20 then
		if part.Parent.Humanoid.Health > 0 then
	    part.Parent.Humanoid.PlatformStand = true
		part.Parent.Humanoid.Health = part.Parent.Humanoid.Health - script.Parent.Velocity.Magnitude / math.random(1, 1.65)
		script.Parent.Sound.Playing = true
		S = script.GetUp:Clone()
		S.Parent = part.Parent
		S.Disabled = false
		script.Disabled = true
		wait(0.5)
		script.Disabled = false
		end
		end
	
end

script.Parent.Touched:connect(onTouched)
	














