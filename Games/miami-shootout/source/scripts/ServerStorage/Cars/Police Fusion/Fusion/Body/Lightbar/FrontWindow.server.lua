veh = script.Parent
while true do
wait(0)
if script.Parent.on.Value == true then
	veh.FWB.Transparency = 0
	veh.FWR.Transparency = 1
	veh.FWW1.Transparency = 1
	veh.FWW2.Transparency = 0
	wait(0.3)
	
	veh.FWB.Transparency = 1
	veh.FWR.Transparency = 0
	veh.FWW1.Transparency = 0
	veh.FWW2.Transparency = 1
	wait(0.3)
else
	veh.FWB.Transparency = 1
	veh.FWR.Transparency = 1
	veh.FWW1.Transparency = 1
	veh.FWW2.Transparency = 1
end
end