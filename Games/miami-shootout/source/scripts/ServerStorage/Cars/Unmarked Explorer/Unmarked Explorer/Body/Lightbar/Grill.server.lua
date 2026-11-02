while true do
wait()
if script.Parent.on.Value == true then
	script.Parent.Grill1.Transparency = 0
	script.Parent.Grill2.Transparency = 1
	wait(0.2)
	
	script.Parent.Grill1.Transparency = 1
	script.Parent.Grill2.Transparency = 0
	wait(0.2)
else
	script.Parent.Grill1.Transparency = 1
	script.Parent.Grill2.Transparency = 1
end
end