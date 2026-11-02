local module = {}

for i = 1,100 do
	if i < 10 then
		table.insert(module,"http://www.roblox.com/asset/?id=318096027") -- IMAGE FOR RANK 1-9; 
	elseif i >= 10 and i < 20 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944906") -- image for rank 10-19;
	elseif i >= 20 and i < 30 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944908") -- 20 to 29
	elseif i >= 30 and i < 40 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944905") -- 30 to 39 ---------
	elseif i >= 40 and i < 50 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944910") -- 40 to 49
	elseif i >= 50 and i < 60 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944911") -- 50 to 59
	elseif i >= 60 and i < 70 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944922") -- 60 to 70
	elseif i >= 70 and i < 80 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944909") -- 70 to 79
	elseif i >= 80 and i < 90 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944915") -- 80 to 89
	elseif i >= 90 and i < 100 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944913") -- 90 to 99;
	elseif i >= 100 then
		table.insert(module,"http://www.roblox.com/asset/?id=317944907") -- 1 hunna
	end 
end

return module; 