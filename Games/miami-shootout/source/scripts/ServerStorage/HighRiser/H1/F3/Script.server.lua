while true do
wait()
if script.Parent.Transparency == 1 then
script.Parent.SpotLight.Enabled = false
elseif script.Parent.Transparency == 0 then
script.Parent.SpotLight.Enabled = true
end
end