while true do
	wait()
	if script.Parent.Power.Value == 0 then
		script.Parent.UvBarUI.Frame.Battery.Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	elseif 	script.Parent.Power.Value == 200 then
		script.Parent.UvBarUI.Frame.Battery.Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	elseif workspace.PowerOutValue.Value == 1 then
		script.Parent.UvBarUI.Frame.Battery.Bar.BackgroundTransparency = 1
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.UvBarUI.Frame.Battery.Bar.BackgroundTransparency = 0	
	end
end