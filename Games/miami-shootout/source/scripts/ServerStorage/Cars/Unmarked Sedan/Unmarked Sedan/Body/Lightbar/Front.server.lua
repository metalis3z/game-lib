while true do
	wait()
	if script.Parent.on.Value == true then

		script.Parent.F1.Transparency = 0
		script.Parent.F2.Transparency = 1
		script.Parent.F3.Transparency = 1
		script.Parent.F4.Transparency = 0
		wait(0.26)

		script.Parent.F1.Transparency = 1
		script.Parent.F2.Transparency = 0
		script.Parent.F3.Transparency = 0
		script.Parent.F4.Transparency = 1
		wait(0.26)
	else
		script.Parent.F1.Transparency = 1
		script.Parent.F2.Transparency = 1
		script.Parent.F3.Transparency = 1
		script.Parent.F4.Transparency = 1
	end
end