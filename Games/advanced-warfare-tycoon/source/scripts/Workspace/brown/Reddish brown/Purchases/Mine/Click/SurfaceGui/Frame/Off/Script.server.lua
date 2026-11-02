act = script.Parent.Parent.Parent.Parent.Parent.Act
c = script.Parent.Parent.C
function click()
	if act.Value == true then
		act.Value = false
		c.Text = "Currently: OFF"
	end
end
script.Parent.MouseButton1Down:connect(click)