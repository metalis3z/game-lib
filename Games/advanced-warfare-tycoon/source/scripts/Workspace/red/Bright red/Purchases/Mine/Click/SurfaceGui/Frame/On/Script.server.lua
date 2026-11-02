act = script.Parent.Parent.Parent.Parent.Parent.Act
c = script.Parent.Parent.C
function click()
	if act.Value == false then
		act.Value = true
		c.Text = "Currently: ON"
	end
end
script.Parent.MouseButton1Down:connect(click)