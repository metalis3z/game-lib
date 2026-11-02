repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local cr = script.Parent.Crucible
local char = script.Parent.Parent
local active = char:WaitForChild("Humanoid"):LoadAnimation(script.Active)
script.Parent.Equipped:Connect(function()
	script.Parent.EquipClient.Disabled = true
	cr.Blade.Transparency = 1
	cr.Outline.Transparency = 1
	cr.Outline2.Transparency = 1
	cr.Outline3.Transparency = 1
	cr.Blade.Trail.Enabled = false
	cr.Blade.PointLight.Enabled = false
	cr.Blade.ParticleEmitter.Enabled = false
	cr.Neon.Transparency = 1
	cr.Beam1.Beam.Enabled = false
	cr.Beam2.Beam.Enabled = false
	cr.Blade.ENABLELIGHT.Enabled = false
	cr.Blade.ParticleEmitter2.Enabled = false
	wait(0.03)
	script.Parent.EquipClient.Disabled = false
	script.Parent.Crucible.ChargingSound:Play()
	wait(2.8)
	script.Parent.Crucible.Charge2:Play()
	wait(0.89)
	active:Play()
	wait(1.01)
	script.Parent.Base.start:Play()
	cr.Blade.ENABLELIGHT.Enabled = true
	cr.Blade.Transparency = 0
	cr.Outline.Transparency = 0.3
	cr.Outline2.Transparency = 0.3
	cr.Outline3.Transparency = 0.3
	cr.Blade.PointLight.Enabled = true
	cr.Blade.ParticleEmitter.Enabled = true
	cr.Blade.ParticleEmitter2.Enabled = true
	cr.Neon.Transparency = 0
	cr.Beam1.Beam.Enabled = true
	cr.Beam2.Beam.Enabled = true
	script.Parent.Base.idle:Play()
	script.Parent.Crucible.Enabling.sparks.Enabled = true
	script.Parent.Base.idle2:Play()
	wait(0.15)
	cr.Blade.ENABLELIGHT.Enabled = false
end)