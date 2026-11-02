while true do
	wait()
	if workspace.PowerOutValue.Value == 1 then
		script.Parent.Frame.Bar.BackgroundTransparency = 1
		script.Parent.Frame.TextLabel.Visible = false
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.Frame.Bar.BackgroundTransparency = 0	
	end
end