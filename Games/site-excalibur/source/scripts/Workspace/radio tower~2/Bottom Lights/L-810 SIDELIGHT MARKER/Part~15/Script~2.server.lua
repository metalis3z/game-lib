while true do
wait(1)
if game.Lighting.TimeOfDay >= "18:00:00" then
script.Parent.Light.Enabled = true
script.Parent.Transparency = 0.5
elseif game.Lighting.TimeOfDay >= "06:00:00" then
script.Parent.Material = "SmoothPlastic"
script.Parent.PointLight.Enabled = false
script.Parent.Transparency = 1
script.Parent.Light.Enabled = false
end
end
