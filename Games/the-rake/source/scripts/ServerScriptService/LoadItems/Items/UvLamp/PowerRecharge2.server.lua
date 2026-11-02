local Power = script.Parent.Power

while true do
	wait()
	repeat
		wait(0.03)
		Power.Value = Power.Value + 0.5
	until script.Disabled == true
	
end