while true do
	wait()
	if workspace.PowerOutValue.Value == 1 then
		script.Parent.Main.Disabled = true
		script.Parent.ShockPart.Damage.Disabled = true
		script.Parent.LightPart.Color = Color3.fromRGB(96, 96, 97)
		script.Parent.LightPart.PointLight.Enabled = false
		script.Parent.Parent.StaminaRefill.Disabled = true
		script.Parent.Parent.Stamina.Value = 0
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.Main.Disabled = false
		script.Parent.LightPart.Color = Color3.fromRGB(167, 166, 168)
		script.Parent.LightPart.PointLight.Enabled = true
	end
end