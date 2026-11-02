script.Parent.MouseButton1Click:connect(function()
    if script.Parent.Parent.ScrollingFrame2.Visible == false then
		script.Parent.Parent.ScrollingFrame2.Visible = true
		script.Parent.Text = 'Close'
	
	else
		script.Parent.Parent.ScrollingFrame2.Visible = false
	end script.Parent.Text = 'Emotes(R6)'
 end)