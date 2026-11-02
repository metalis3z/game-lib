script.Parent.MouseButton1Click:connect(function()
    if script.Parent.Parent.ScrollingFrame.Visible == false then
		script.Parent.Parent.ScrollingFrame.Visible = true
		script.Parent.Text = 'Close'
	
	else
		script.Parent.Parent.ScrollingFrame.Visible = false
	end script.Parent.Text = 'Emotes(R15)'
 end)