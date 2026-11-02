local Debounce = false

function onTouched(hit)
	if Debounce == false then
		Debounce = true
		script.Parent.Zapped.Value = true
		--script.Parent.Damage.Disabled = true
		script.Parent.ShockSound:Play()
		script.Parent.Parent.LightPart.ShockLight.Enabled = true
		script.Parent.Parent.LightPart.ParticleEmitter.Enabled = true
		script.Parent.Zapped.Value = false
		wait(0.5)
		Debounce = false
	end
end
script.Parent.Touched:connect(onTouched)