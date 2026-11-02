H1 = script.Parent.H1
H2 = script.Parent.H2 
while true do
	wait(0)
	if script.Parent.on.Value == true then
		H1.B1.Transparency = 0
		H1.B2.Transparency = 1
		H1.B3.Transparency = 0
		H1.B4.Transparency = 1
		H2.B1.Transparency = 0
		H2.B2.Transparency = 1
		H2.B3.Transparency = 0
		H2.B4.Transparency = 1
		
		H1.F1.Transparency = 0
		H1.F2.Transparency = 1
		H1.F3.Transparency = 0
		H2.F1.Transparency = 1
		H2.F2.Transparency = 0
		H2.F3.Transparency = 1
		wait(0.1)
		H1.B1.Transparency = 1
		H1.B2.Transparency = 0
		H1.B3.Transparency = 1
		H1.B4.Transparency = 0
		H2.B1.Transparency = 1
		H2.B2.Transparency = 0
		H2.B3.Transparency = 1
		H2.B4.Transparency = 0
		H1.F1.Transparency = 1
		H1.F2.Transparency = 0
		H1.F3.Transparency = 1
		H2.F1.Transparency = 0
		H2.F2.Transparency = 1
		H2.F3.Transparency = 0
		wait(0.1)
	else
		H1.B1.Transparency = 1
		H1.B2.Transparency = 1
		H1.B3.Transparency = 1
		H1.B4.Transparency = 1
		H2.B1.Transparency = 1
		H2.B2.Transparency = 1
		H2.B3.Transparency = 1
		H2.B4.Transparency = 1
		H1.F1.Transparency = 1
		H1.F2.Transparency = 1
		H1.F3.Transparency = 1
		H2.F1.Transparency = 1
		H2.F2.Transparency = 1
		H2.F3.Transparency = 1
	end
end