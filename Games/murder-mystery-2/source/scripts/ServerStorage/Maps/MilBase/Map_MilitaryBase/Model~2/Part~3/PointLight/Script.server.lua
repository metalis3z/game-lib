Light = script.Parent
while true do
	Light.Enabled = true
	wait(math.random()*1)
	Light.Enabled = false
	wait(math.random()*3)
end