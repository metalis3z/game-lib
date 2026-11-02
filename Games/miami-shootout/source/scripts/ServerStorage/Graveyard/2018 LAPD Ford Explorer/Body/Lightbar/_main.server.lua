while true do
wait(0)
if script.Parent.on.Value == true then
	script.Parent.Union1.Transparency = 0
	script.Parent.Union2.Transparency = 1
	script.Parent.Union3.Transparency = 1
	wait(0.1)
	
	script.Parent.Union1.Transparency = 1
	script.Parent.Union2.Transparency = 1
	script.Parent.Union3.Transparency = 0
	wait(0.1)
	
	script.Parent.Union1.Transparency = 1
	script.Parent.Union2.Transparency = 0
	script.Parent.Union3.Transparency = 1
	wait(0.1)
	
	script.Parent.Union1.Transparency = 1
	script.Parent.Union2.Transparency = 1
	script.Parent.Union3.Transparency = 0
	wait(0.1)
else
	script.Parent.Union1.Transparency = 1
	script.Parent.Union2.Transparency = 1
	script.Parent.Union3.Transparency = 1
end
end