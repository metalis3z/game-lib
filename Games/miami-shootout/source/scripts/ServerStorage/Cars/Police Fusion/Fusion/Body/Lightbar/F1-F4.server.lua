veh = script.Parent
while true do
wait(0)
if script.Parent.on.Value == true then
	veh.F1.Transparency = 0
	veh.F2.Transparency = 1
	veh.F3.Transparency = 1
	veh.F4.Transparency = 0
	wait(0.1)
	
	veh.F1.Transparency = 1
	veh.F2.Transparency = 0
	veh.F3.Transparency = 0
	veh.F4.Transparency = 1
	wait(0.1)
else
	veh.F1.Transparency = 1
	veh.F2.Transparency = 1
	veh.F3.Transparency = 1
	veh.F4.Transparency = 1
end
end