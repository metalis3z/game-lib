local Light = script.Parent
while true do
	for i=10,8, -0.1 do   	
		Light.Range = i
		wait()
	end
	for i=8,10, 0.1 do   	
		Light.Range = i
		wait()
	end
end