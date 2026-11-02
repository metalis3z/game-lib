while true do
wait(1)
if game.Lighting.TimeOfDay >= "18:00:00" then
	--script.Parent.Sound:Stop()
script.Parent.LightD.Enabled = false 
script.Parent.LightD.Script.Disabled = true
elseif game.Lighting.TimeOfDay >= "06:00:00" then
	--script.Parent.Sn:Stop()
script.Parent.LightD.Enabled = true
end
end