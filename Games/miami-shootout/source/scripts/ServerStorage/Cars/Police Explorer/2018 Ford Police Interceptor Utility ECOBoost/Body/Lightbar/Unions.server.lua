while true do
wait()
if script.Parent.on.Value == true then
	
	script.Parent.Union1.Transparency = 0
	script.Parent.Union2.Transparency = 1
	wait(0.25)
	
	script.Parent.Union1.Transparency = 1
	script.Parent.Union2.Transparency = 0
	wait(0.25)
else
	script.Parent.Union1.Transparency = 1
	script.Parent.Union2.Transparency = 1
end
end