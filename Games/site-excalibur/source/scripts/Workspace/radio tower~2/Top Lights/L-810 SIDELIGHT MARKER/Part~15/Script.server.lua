while true do
wait(1)
if game.Lighting.TimeOfDay >= "18:00:00" then
script.Parent.PointLight.Range = 5
script.Parent.PointLight.Enabled = true
elseif game.Lighting.TimeOfDay >= "6:00:00" then
script.Parent.PointLight.Range = 0
end
end
