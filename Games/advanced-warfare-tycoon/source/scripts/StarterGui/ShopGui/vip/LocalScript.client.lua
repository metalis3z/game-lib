wait()


function buttondown()
	wait()
	script.Parent.Visible = false
	wait()
	script.Parent.Parent.vpi.Visible = true
end


script.Parent.MouseButton1Down:connect(buttondown)

