grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
		grp1[i].Transparency = 0
		grp1[i].Light.Enabled = true
	end
	wait(0.35)
	
	for i = 1,#grp1 do
		grp1[i].Transparency = 1
		grp1[i].Light.Enabled = false
	end
	wait(0.35)
else
	for i = 1,#grp1 do
		grp1[i].Transparency = 1
		grp1[i].Light.Enabled = false
	end
end
end