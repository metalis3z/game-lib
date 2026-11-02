while true do
wait(0)
if script.Parent.on.Value == true then
	script.Parent.Text1.Transparency = 0
	script.Parent.Text2.Transparency = 1
	script.Parent.Text3.Transparency = 1
	wait(0.3)
	
	script.Parent.Text1.Transparency = 1
	script.Parent.Text2.Transparency = 0
	script.Parent.Text3.Transparency = 1
	wait(0.3)
	
	script.Parent.Text1.Transparency = 1
	script.Parent.Text2.Transparency = 1
	script.Parent.Text3.Transparency = 0
	wait(0.6)
	
else
	script.Parent.Text1.Transparency = 1
	script.Parent.Text2.Transparency = 1
	script.Parent.Text3.Transparency = 1
end
end