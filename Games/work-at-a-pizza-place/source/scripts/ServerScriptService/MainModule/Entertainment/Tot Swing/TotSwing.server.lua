local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

seat = model.Seat
cframes = {}
for _,i in ipairs(model:GetChildren()) do
	if not i:IsA("Script") and i:IsA("Part") and i.Name ~= "Hinge" then
		cframes[i] = i.CFrame
	end
end

model:MakeJoints()

function added(object)
	if seat.Occupant.Parent:FindFirstChild("SwingPlayer") == nil then
		local swing = script.SwingPlayer:clone()
		swing.Disabled = false
		swing.ObjectPointer.Value = model
		swing.Parent = seat.Occupant.Parent
	end
	
	for _,i in ipairs(model:GetChildren()) do
		if i.Name == "Rope"  or i.Name == "Seat" then
			i.Anchored = false
		end
	end
end

function removed(object)
	
	if object.Name == "SeatWeld" then
		wait(3)
		if seat:FindFirstChild("SeatWeld") == nil then
			for _,i in ipairs(model:GetChildren()) do
				if i.Name == "Rope" or i.Name == "Seat" then	
					i.Anchored = true
					i.CFrame = cframes[i]
				end
			end
			model:MakeJoints()
		end
	end
end
seat.ChildAdded:connect(added)
seat.ChildRemoved:connect(removed)