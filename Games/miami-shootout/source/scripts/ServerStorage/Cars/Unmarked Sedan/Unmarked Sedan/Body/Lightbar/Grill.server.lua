MainVeh = script.Parent
while true do
	wait(0.001)
	if script.Parent.on.Value == true then
		MainVeh.Gr1.Transparency = 0
		MainVeh.Gr2.Transparency = 1
		MainVeh.Gr3.Transparency = 1
		MainVeh.Gr4.Transparency = 0
		wait(0.2)
		
		MainVeh.Gr1.Transparency = 1
		MainVeh.Gr2.Transparency = 0
		MainVeh.Gr3.Transparency = 0
		MainVeh.Gr4.Transparency = 1
		wait(0.2)
	else
		MainVeh.Gr1.Transparency = 1
		MainVeh.Gr2.Transparency = 1
		MainVeh.Gr3.Transparency = 1
		MainVeh.Gr4.Transparency = 1
		wait(0.2)
	end
end