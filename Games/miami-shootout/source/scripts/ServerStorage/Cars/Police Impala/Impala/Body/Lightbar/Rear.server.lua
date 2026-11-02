MainVeh = script.Parent
while true do
	wait(0.001)
	if script.Parent.on.Value == true then
		MainVeh.R1.Transparency = 0
		MainVeh.R2.Transparency = 1
		MainVeh.R3.Transparency = 1
		MainVeh.R4.Transparency = 0
		wait(0.2)
		
		MainVeh.R1.Transparency = 1
		MainVeh.R2.Transparency = 0
		MainVeh.R3.Transparency = 0
		MainVeh.R4.Transparency = 1
		wait(0.2)
	else
		MainVeh.R1.Transparency = 1
		MainVeh.R2.Transparency = 1
		MainVeh.R3.Transparency = 1
		MainVeh.R4.Transparency = 1
		wait(0.2)
	end
end