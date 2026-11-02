while true do
	wait()
	if script.Parent.Humanoid.Health < 40 then
		script.Parent.Humanoid.PlatformStand = true
		script.Parent.Humanoid.AutoRotate = false
	elseif script.Parent.Humanoid.Health > 40 then
		script.Parent.Humanoid.PlatformStand = false
		script.Parent.Humanoid.AutoRotate = true
	end
end