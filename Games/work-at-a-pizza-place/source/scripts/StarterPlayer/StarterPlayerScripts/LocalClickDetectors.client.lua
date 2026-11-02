local connections = {}
function search(dir)
	for _,obj in ipairs(dir:GetChildren()) do
		search(obj)
		if obj:IsA("ClickDetector") and obj.Name ~= "Hand" then
			connections[obj] = obj.MouseClick:connect(function()
				workspace.ClickDetectorClicked:FireServer(obj)
			end)
		end
	end
end

search(workspace)




function DescendantAdded(obj)
	if obj:IsA("ClickDetector") and obj.Name ~= "Hand" then
		connections[obj] = obj.MouseClick:connect(function()
			workspace.ClickDetectorClicked:FireServer(obj)
		end)
	end
end

workspace.Houses.DescendantAdded:connect(DescendantAdded)
workspace.Boats.DescendantAdded:connect(DescendantAdded)
workspace.Cars.DescendantAdded:connect(DescendantAdded)
workspace.Trucks.DescendantAdded:connect(DescendantAdded)


function DescendantRemoving(obj)
	if obj:IsA("ClickDetector") and obj.Name ~= "Hand" then
		connections[obj]:disconnect()
		connections[obj] = nil
	end
end

workspace.Houses.DescendantRemoving:connect(DescendantRemoving)
workspace.Boats.DescendantRemoving:connect(DescendantRemoving)
workspace.Cars.DescendantRemoving:connect(DescendantRemoving)
workspace.Trucks.DescendantRemoving:connect(DescendantRemoving)


workspace.RegisterClickDetector.OnClientEvent:connect(function(root)
	search(root)
end)

--wait(20)
---workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-500,-7,-500), Vector3int16.new(500,-2,500)),Enum.CellMaterial.Water,0,0)

--[[
function search2(dir)
	for _,obj in ipairs(dir:GetChildren()) do
		search2(obj)
		if obj:IsA("ClickDetector") and not obj:FindFirstChild("Detector") then
			local a = Instance.new("BindableEvent",obj)
			a.Name = "Detector"
			
		end
	end
end
search2(game.ServerStorage["Christmas Decorations"])
search2(game.ServerStorage["HalloweenDecorations"])
search2(game.ServerStorage["ThanksgivingDecorations"])]]