while true do
	wait()
	if script.Parent.Stamina.Value == 0 then
		script.Parent.StunStickBarUI.Frame.Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		script.Parent.StunStickBarUI.Frame.TextLabel.Visible = true
	elseif script.Parent.Stamina.Value == 10 then
		script.Parent.StunStickBarUI.Frame.Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		script.Parent.StunStickBarUI.Frame.TextLabel.Visible = false
	end
end