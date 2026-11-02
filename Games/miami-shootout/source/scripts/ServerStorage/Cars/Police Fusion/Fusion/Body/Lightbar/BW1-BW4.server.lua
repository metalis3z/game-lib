veh = script.Parent
while true do
wait(0)
if script.Parent.on.Value == true then
	veh.BW1.Transparency = 0
	veh.BW2.Transparency = 1
	veh.BW3.Transparency = 0
	veh.BW4.Transparency = 1
	wait(0.2)
	
	veh.BW1.Transparency = 1
	veh.BW2.Transparency = 0
	veh.BW3.Transparency = 1
	veh.BW4.Transparency = 0
	wait(0.2)
	
	veh.BW1.Transparency = 0
	veh.BW2.Transparency = 1
	veh.BW3.Transparency = 0
	veh.BW4.Transparency = 1
	wait(0.2)
	
	veh.BW1.Transparency = 1
	veh.BW2.Transparency = 0
	veh.BW3.Transparency = 1
	veh.BW4.Transparency = 0
	wait(0.2)
	
	veh.BW1.Transparency = 0
	veh.BW2.Transparency = 0
	veh.BW3.Transparency = 1
	veh.BW4.Transparency = 1
	wait(0.2)
	
	veh.BW1.Transparency = 1
	veh.BW2.Transparency = 1
	veh.BW3.Transparency = 0
	veh.BW4.Transparency = 0
	wait(0.2)
	
	veh.BW1.Transparency = 0
	veh.BW2.Transparency = 0
	veh.BW3.Transparency = 1
	veh.BW4.Transparency = 1
	wait(0.2)
	
	veh.BW1.Transparency = 1
	veh.BW2.Transparency = 1
	veh.BW3.Transparency = 0
	veh.BW4.Transparency = 0
	wait(0.2)
else
    veh.BW1.Transparency = 1
	veh.BW2.Transparency = 1
	veh.BW3.Transparency = 1
	veh.BW4.Transparency = 1
end
end