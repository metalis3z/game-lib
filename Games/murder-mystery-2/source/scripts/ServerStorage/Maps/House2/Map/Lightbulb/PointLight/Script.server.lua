Light = script.Parent
while true do
	wait(math.random(2,7))
	Light.Range = 0
	wait(math.random(1,2))
	for i=0,10, 0.2 do
		Light.Range = i
		wait()
	end
end