veh = script.Parent
while true do
wait(0)
if script.Parent.on.Value == true then
	veh.T1.Transparency = 0
	veh.T2.Transparency = 1
	wait(0.1)
	
	veh.T1.Transparency = 1
	veh.T2.Transparency = 1
	wait(0.1)
	
	veh.T1.Transparency = 0
	veh.T2.Transparency = 1
	wait(0.1)
	
	veh.T1.Transparency = 1
	veh.T2.Transparency = 1
	wait(0.1)
	
	veh.T1.Transparency = 1
	veh.T2.Transparency = 0
	wait(0.1)
	
	veh.T1.Transparency = 1
	veh.T2.Transparency = 1
	wait(0.1)
	
	veh.T1.Transparency = 1
	veh.T2.Transparency = 0
	wait(0.1)
	
	veh.T1.Transparency = 1
	veh.T2.Transparency = 1
	wait(0.1)
else
	veh.T1.Transparency = 1
	veh.T2.Transparency = 1
end
end