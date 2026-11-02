
local model = script:WaitForChild("ObjectPointer").Value
b1 = model.Ball

function squish(vector)
	for _,i in ipairs(model:GetChildren()) do
		if i.Name == "SQ" then
			i.Mesh.Scale = vector
		end
	end
end

function added(part)
	if part:IsA("Weld") then
		b1.Mesh.Scale = Vector3.new(1.5,1,1.5)
		squish(Vector3.new(1,1,2))
		b1.Sit:Play()
	end
end

function removed(part)
	
	if part:IsA("Weld") then
		b1.Mesh.Scale = Vector3.new(1,2,1)
		squish(Vector3.new(1,1,1))
		b1.GetUp:Play()
	end
end

model.Seat.ChildAdded:connect(added)
model.Seat.ChildRemoved:connect(removed)

