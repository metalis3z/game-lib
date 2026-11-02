local model = script:WaitForChild("ObjectPointer").Value

b1 = model.Bubble1
b2 = model.Bubble2

function added(part)
	if part:IsA("Weld") then
		b1.Mesh.Scale = Vector3.new(1.5,2,1.5)
		b1.Sit:Play()
		b2.Mesh.Scale = Vector3.new(2,2,2)
	end
end

function removed(part)
	
	if part:IsA("Weld") then
		b1.Mesh.Scale = Vector3.new(1,4,1)
		b1.GetUp:Play()
		b2.Mesh.Scale = Vector3.new(1,4,1)
	end
end

model.Seat.ChildAdded:connect(added)
model.Seat.ChildRemoved:connect(removed)

