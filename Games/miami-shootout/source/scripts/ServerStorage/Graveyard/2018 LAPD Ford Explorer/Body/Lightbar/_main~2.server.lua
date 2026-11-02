grp1 = script.Parent.G1:GetChildren()
grp2 = script.Parent.G2:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.1)
	
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	end
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	end
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.1)
else
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
end
end