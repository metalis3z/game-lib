Light = script.Parent:WaitForChild("PointLight")
while true do
	wait(math.random(1,5))
	Light.Enabled = false
	wait(0.2)
	Light.Enabled = true
end