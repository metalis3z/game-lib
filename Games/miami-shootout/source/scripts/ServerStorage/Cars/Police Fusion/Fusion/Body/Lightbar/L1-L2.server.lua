veh = script.Parent
while true do
wait(0)
if script.Parent.on.Value == true then
	veh.L1.Transparency = 0
	veh.L2.Transparency = 1
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 1
	wait(0.05)
	
	veh.L1.Transparency = 0
	veh.L2.Transparency = 1
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 1
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 0
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 1
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 0
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 1
	wait(0.05)
	
	veh.L1.Transparency = 1
	veh.L2.Transparency = 1
	wait(0.05)

else
	veh.L1.Transparency = 1
	veh.L2.Transparency = 1
end
end