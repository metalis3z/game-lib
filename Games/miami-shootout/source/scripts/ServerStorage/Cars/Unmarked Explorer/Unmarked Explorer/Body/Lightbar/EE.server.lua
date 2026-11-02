while true do
wait()
if script.Parent.on.Value == true then
	script.Parent.E1.Transparency = 0
	script.Parent.E.Transparency = 1
	wait(0.4)
	
	script.Parent.E1.Transparency = 1
	script.Parent.E.Transparency = 0
	wait(0.4)
else
	script.Parent.E1.Transparency = 1
	script.Parent.E.Transparency = 1
end
end