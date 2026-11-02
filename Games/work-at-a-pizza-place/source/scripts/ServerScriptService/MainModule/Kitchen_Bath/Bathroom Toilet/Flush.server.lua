local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
t1 = model.T1
t2 = model.T2
seat = model.Seat




function removed(part)
	if part:IsA("Weld") then
		workspace.Main.FurnitureSound:FireAllClients(model.Seat.Flush,model,"Play")
	end
end


open = true
function click(player)
	 if open then
		open = false
		t1.Transparency = 0
		t2.Transparency = 1
		seat.Disabled = true
	else
		open = true
		t1.Transparency = 1
		t2.Transparency = 0
		seat.Disabled = false
	end
end

model.ClickDetector.MouseClick:connect(click)
model.Seat.ChildRemoved:connect(removed)

