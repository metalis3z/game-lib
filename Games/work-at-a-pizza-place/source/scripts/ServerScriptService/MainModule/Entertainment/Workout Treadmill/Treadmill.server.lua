local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

model.Vayer.Velocity = model.Vayer.CFrame.lookVector * -16
