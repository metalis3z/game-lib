fallTime = 0
while true do
	x = wait()
	if script.Parent.Torso.Velocity.Y <= -10 then --Finds whether or not the player has begun falling and starts a timer
		fallTime = fallTime + x
	end
	if script.Parent.Torso.Velocity.Y > -10 then --Finds when the player has stopped falling
		if fallTime >= 0.35 then --Finds whether or not the player has been falling long enough to take damage
			script.Parent.Humanoid:TakeDamage(fallTime * 50)
           script.Parent.Humanoid.Sit = true
         
wait(2)
script.Parent.Humanoid.Sit = false --Deals damage directly proportional to falling time; can simply change the 50 to another factor balance it differently
		end
		fallTime = 0
	end
end