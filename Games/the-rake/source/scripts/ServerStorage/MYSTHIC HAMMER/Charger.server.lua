
script.Parent.Equipped:Connect(function()
	script.Parent.Base.HAMMER.light.Enabled = false
	wait(0.03)
	script.Parent.EquipClient.Disabled = false
	wait(3)
	script.Parent.Base.HAMMER.CHARGING:Play()
	wait(3)
	script.Parent.Base.HAMMER.PointLight.Enabled = true
	script.Parent.Base.HAMMER.CHARGED:Play()
	script.Parent.Base.HAMMER.Transparency = 0
	script.Parent.Base.HAMMER.MeshPart.Transparency = 0
	script.Parent.Base.FakeHammer.Transparency = 1
	script.Parent.Base.HAMMER.ChargedParticle.Enabled = true
	script.Parent.Base.HAMMER.Enabling.Enabled = true
	wait(0.25)
	script.Parent.Base.HAMMER.light.Enabled = true
	script.Parent.Base.HAMMER.Enabling.Enabled = false
	script.Parent.Base.HAMMER.PointLight.Enabled = false
end)