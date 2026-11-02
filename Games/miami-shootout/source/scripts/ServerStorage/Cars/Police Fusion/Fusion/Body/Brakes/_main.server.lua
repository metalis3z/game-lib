grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
		grp1[i].Material = "Neon"
		grp1[i].Light.Enabled = true
	end
else
	for i = 1,#grp1 do
		grp1[i].Material = "SmoothPlastic"
		grp1[i].Light.Enabled = false
	end
end
end