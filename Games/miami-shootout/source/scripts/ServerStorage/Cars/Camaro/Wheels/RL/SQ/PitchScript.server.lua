while true do
	wait(0.01)
	script.Parent.Pitch = 15 + script.Parent.Parent.Velocity.Magnitude/10
end

