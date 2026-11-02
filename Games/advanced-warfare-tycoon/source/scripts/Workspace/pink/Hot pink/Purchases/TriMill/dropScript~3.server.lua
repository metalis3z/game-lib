wait(2)
ps = script.Parent.Parent.Parent.PartStorage
while true do
	wait(3)
	local part = Instance.new("Part",ps)
	local cash = Instance.new("IntValue",part)
	part.BrickColor=script.Parent.Parent.Parent.DropColor.Value
	cash.Name = "Cash"
	cash.Value = 5
	part.CFrame = script.Parent.Drop1.CFrame - Vector3.new(0,1.2,0)
	part.FormFactor = "Custom"
	part.Size=Vector3.new(.85,1,1.15)
	part.TopSurface = "Smooth"
	part.BottomSurface = "Smooth"
	part.Material = script.Parent.Parent.Parent.Material.Value
	fakeDebris = require(game.ReplicatedStorage.fakeDebris)
	fakeDebris.AddItem(part,20)
end