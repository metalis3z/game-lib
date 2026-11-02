script.Parent.Equipped:Connect(function()
	script.Parent.Charger.Disabled = false
	script.Parent.Base.HAMMER.light.Enabled = false
	script.Parent.Base.HAMMER.Equip:Play()
	script.Parent.getsready.Disabled = false
end)

script.Parent.Unequipped:Connect(function()
	script.Parent.Base.HAMMER.Equip:Stop()
	script.Parent.Base.HAMMER.PointLight.Enabled = false
	script.Parent.Base.HAMMER.CHARGED:Stop()
	script.Parent.Base.HAMMER.CHARGING:Stop()
	script.Parent.Base.HAMMER.ChargedParticle.Enabled = false
	script.Parent.Base.FakeHammer.Transparency = 0
	script.Parent.Base.HAMMER.Transparency = 1
	script.Parent.Base.HAMMER.MeshPart.Transparency = 1
	script.Parent.Base.HAMMER.PointLight.Brightness = 0
	script.Parent.Charger.Disabled = true
	script.Parent.getsready.Disabled = true
	script.Parent.Canbeused.Value = false
	script.Parent.EquipClient.Disabled = true
	script.Parent.Base.HAMMER.light.Enabled = false
end)