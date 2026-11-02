local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

function added(part)
	if part:IsA("Weld") then
		model.Open1.Transparency = 0
		model.Open2.Transparency = 0
		model.Open3.Transparency = 0
		model.Open4.Transparency = 0
	end
end

function removed(part)
	if part:IsA("Weld") then
		model.Open1.Transparency = 1
		model.Open2.Transparency = 1
		model.Open3.Transparency = 1
		model.Open4.Transparency = 1
	end
end

model.Seat.ChildAdded:connect(added)
model.Seat.ChildRemoved:connect(removed)

