grp1 = script.Parent.G1:GetChildren()
grp2 = script.Parent.G2:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true and script.Parent.Yelp.Value == false and script.Parent.Park.Value == false then
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.3)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.05)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	end
	wait(0.3)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
	wait(0.05)
	
else
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
end

if script.Parent.on.Value == true and script.Parent.Yelp.Value == true and script.Parent.Park.Value == false then
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	end
	wait(0.4)
	
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

if script.Parent.Park.Value == true then
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	end
	wait(0.05)
	
else
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	end
end
end

while script.Parent.Park.Value==true do
	script.Parent.on.Value=false
end