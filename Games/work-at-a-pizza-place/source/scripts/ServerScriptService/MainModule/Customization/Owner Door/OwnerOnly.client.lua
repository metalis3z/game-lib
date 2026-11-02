local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

if house.Owner.Value == game.Players.LocalPlayer then
	model.DoorClosed.CanCollide = false
end