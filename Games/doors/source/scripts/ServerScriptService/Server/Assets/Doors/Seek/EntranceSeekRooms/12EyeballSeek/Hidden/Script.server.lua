script.Parent.Touched:Connect(function()
	local gd = game.ReplicatedStorage
	local gh = require(gd.ClientModules.Module_Events)
	gh.flickerLights(2)
	script.Parent.Parent.Parent.ValueC.Value = true
	script.Parent.Parent.KnobConstraint.TargetAngle = 45
	script.Parent.Parent.Door.Anchored = false
	script.Parent.Parent.Door.CanCollide = false
	script.Parent.CanTouch = false
	script.Parent.Parent.Door.Open:Play()
	wait(0.5)
	script.Parent.Parent.KnobConstraint.TargetAngle = 0
end)
