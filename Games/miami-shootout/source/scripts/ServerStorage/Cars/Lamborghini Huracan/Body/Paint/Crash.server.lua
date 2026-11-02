function crashed(hit)
	if script.Parent.Velocity.Magnitude > hit.Velocity.Magnitude + 45 and hit.CanCollide == true or hit.Velocity.Magnitude > script.Parent.Velocity.Magnitude + 35 then
		script.Disabled = true
		script.Parent.Health.Value = script.Parent.Health.Value - script.Parent.Velocity.Magnitude / 1.25
		wait()
			if script.Parent.Health.Value > 0 then
		script.Parent.Sparks.Enabled = true
		local sound = math.random(1, 2)
		if sound == 1 then
			script.Parent.Collide.SoundId = "rbxassetid://490314550"
		end
		if sound == 2 then
			script.Parent.Collide.SoundId = "rbxassetid://215550851"
		end
		script.Parent.Collide.Playing = true
		wait(0.5)
		script.Parent.Sparks.Enabled = false
		wait()
		script.Disabled = false
			else
				script.Disabled = true
				script.Parent:BreakJoints()
				script.Parent.CanCollide = true
				script.Parent.Break.Playing = true
				script.Parent.Parent = workspace
				wait(15)
				script.Parent:remove()
	end
	end
	end
script.Parent.Touched:connect(crashed)