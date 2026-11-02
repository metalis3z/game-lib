local invert1,invert2,invert3 = 1,1,1
local model = script:WaitForChild("ObjectPointer").Value

model.Drawer1Main.ClickDetector.MouseClick:connect(function(player)
	
	for _,obj in ipairs(model:GetChildren()) do
		if obj.Name == "Drawer1" or obj.Name == "Drawer1Main" then
			obj.CFrame = obj.CFrame + (model.Drawer1Main.CFrame.lookVector * 3 * invert1)
			
		end
	end
			
	if invert1 == 1 then
		invert1 = -1
	else
		invert1 = 1
	end
end)

model.Drawer2Main.ClickDetector.MouseClick:connect(function(player)
	
	for _,obj in ipairs(model:GetChildren()) do
		if obj.Name == "Drawer2" or obj.Name == "Drawer2Main" then
			obj.CFrame = obj.CFrame + (model.Drawer2Main.CFrame.lookVector * 3 * invert2)
			
		end
	end
			
	if invert2 == 1 then
		invert2 = -1
	else
		invert2 = 1
	end
end)

model.Drawer3Main.ClickDetector.MouseClick:connect(function(player)
	
	for _,obj in ipairs(model:GetChildren()) do
		if obj.Name == "Drawer3" or obj.Name == "Drawer3Main" then
			obj.CFrame = obj.CFrame + (model.Drawer3Main.CFrame.lookVector * 3 * invert3)
			
		end
	end
			
	if invert3 == 1 then
		invert3 = -1
	else
		invert3 = 1
	end
end)