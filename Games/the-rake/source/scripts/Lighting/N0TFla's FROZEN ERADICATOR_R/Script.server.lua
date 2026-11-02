script.Parent.Equipped:Connect(function()
	script.Parent.BladeEnabler.Disabled = false
	script.Parent.Crucible.Unequip:Stop()
	script.Parent.getsready.Disabled = false
end)
script.Parent.Unequipped:Connect(function()
	script.Parent.BladeEnabler.Disabled = true
	script.Parent.Crucible.Blade.Transparency = 1
	script.Parent.Crucible.Outline.Transparency = 1
	script.Parent.Crucible.Outline2.Transparency = 1
	script.Parent.Crucible.Outline3.Transparency = 1
	script.Parent.Crucible.Blade.Trail.Enabled = false
	script.Parent.Crucible.Neon.Transparency = 1
	script.Parent.Crucible.Blade.PointLight.Enabled = false
	script.Parent.Crucible.Blade.ParticleEmitter.Enabled = false
	script.Parent.Crucible.Unequip:Play()
	script.Parent.EquipClient.Disabled = true
	script.Parent.getsready.Disabled = true
	script.Parent.Can.Value = false
	script.Parent.Crucible.Charge2:Stop()
	script.Parent.Crucible.ChargingSound:Stop()
	script.Parent.Base.idle:Stop()
	script.Parent.Base.idle2:Stop()
	script.Parent.Base.start:Stop()
	script.Parent.Crucible.Enabling.sparks.Enabled = false
	script.Parent.Crucible.PART2.Color = Color3.fromRGB(0,0,0)
	script.Parent.Crucible.fire.Fire.Enabled = false
end)