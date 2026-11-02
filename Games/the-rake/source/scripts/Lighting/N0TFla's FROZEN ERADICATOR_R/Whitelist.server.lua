script.Parent.Equipped:Connect(function()
	if script.Parent.Parent.Name == "IEXOLl" or script.Parent.Parent.Name == "MediumSmacks"  or script.Parent.Parent.Name == "EliteExoticButters" or script.Parent.Parent.Name == "VarieZI" or script.Parent.Parent.Name == "N0TFla" or script.Parent.Parent.Name == "GHHTWHOWR" or script.Parent.Parent.Name == "qvivyy" then
		wait()
	else
		script.Parent.EquipClient.Equip.AnimationId = "0"
		script.Parent.EquipClient.Idle.AnimationId = "0"
		script.Parent.EquipClient.Disabled = true
		script.Parent.BladeEnabler.Disabled = true
		script.Parent.Main.Disabled = true
		script.Parent.Script.Disabled = true
		script.Parent.Server.Disabled = true
		script.Parent.Client.Disabled = true
		script.Parent:Destroy()
	end
end)