while true do
	wait()
	if workspace.PowerOutValue.Value == 1 then
		script.Parent.ShockPart.Damage.Disabled = true
		script.Parent.LightPart.Color = Color3.fromRGB(96, 96, 97)
		script.Parent.LightPart.PointLight.Enabled = false
		script.Parent.StaminaRefill.Disabled = true
		script.Parent.Stamina.Value = 0
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.LightPart.Color = Color3.fromRGB(102, 255, 250)
		script.Parent.LightPart.PointLight.Enabled = true
		script.Parent.StaminaRefill.Disabled = false
	end
end