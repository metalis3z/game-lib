local NightDayFunction = script.Parent.Parent.LightPart.ShockLight

NightDayFunction.Changed:Connect(function()
	if NightDayFunction.Enabled==true then
		wait(0.1)
		NightDayFunction.Enabled = false
		end
	end)