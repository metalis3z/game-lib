local Debounce = false
function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Debounce == false and Part.Parent:FindFirstChild("NPC") == nil then 
			local RandomSound = math.random(1,3)
			if RandomSound == 1 then
				script.Parent.ShockSound1:Play()
			elseif RandomSound == 2 then
				script.Parent.ShockSound2:Play()
			elseif RandomSound == 3 then
				script.Parent.ShockSound3:Play()
			end
			script.Parent.Parent.LightPart.ShockLight.Enabled = true
			script.Parent.Parent.LightPart.ShockEmitter.Enabled = true
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