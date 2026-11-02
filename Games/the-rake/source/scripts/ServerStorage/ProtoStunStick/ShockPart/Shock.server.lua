local Debounce = false
function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Debounce == false and Part.Parent:FindFirstChild("NPC") == nil then 
			script.Parent.Parent.Stamina.Value = 0
			script.Parent.ShockSound:Play()
			script.Parent.Parent.LightPart.ShockLight.Enabled = true
			script.Parent.Parent.LightPart.ParticleEmitter.Enabled = true
			local TrailElectricity = script.Parent.TrailElectricity:Clone()
			TrailElectricity.Parent = Part
			TrailElectricity.Enabled = true
			script.Parent.Damage.Disabled = false
script.Disabled=true
wait(0.5)
Debounce = false
end
end 
end 
script.Parent.Touched:connect(OnTouched)