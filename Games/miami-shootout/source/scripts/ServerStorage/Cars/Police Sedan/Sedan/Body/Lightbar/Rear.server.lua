while true do
	wait()
	if script.Parent.on.Value == true then

		script.Parent.R1.Transparency = 0
		script.Parent.R2.Transparency = 1
		script.Parent.R3.Transparency = 1
		script.Parent.R4.Transparency = 0
		wait(0.25)

		script.Parent.R1.Transparency = 1
		script.Parent.R2.Transparency = 0
		script.Parent.R3.Transparency = 0
		script.Parent.R4.Transparency = 1
		wait(0.25)
	else
		script.Parent.R1.Transparency = 1
		script.Parent.R2.Transparency = 1
		script.Parent.R3.Transparency = 1
		script.Parent.R4.Transparency = 1
	end
end