while true do
wait(1)
if game.Lighting.TimeOfDay >= "18:00:00" then
script.Parent.LightN.Enabled = true
script.Parent.LightN.Script.Disabled = false
--script.Parent.Sound:Stop()
elseif game.Lighting.TimeOfDay >= "06:00:00" then
	--script.Parent.Sn:Stop()
	script.Parent.LightD.Script.Disabled = false
script.Parent.LightN.Enabled = false
script.Parent.LightN.Script.Disabled = true
end
end
