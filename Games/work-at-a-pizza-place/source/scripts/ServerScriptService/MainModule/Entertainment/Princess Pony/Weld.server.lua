local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value


function Weld(x,y)
	local W = Instance.new("Weld")
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end





	
Weld(model.Handle, model.Seat)
model.Seat.Anchored = false
	model.Handle.Anchored = false
