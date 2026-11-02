wait(2)
ps = script.Parent.Parent.Parent.PartStorage
while true do
	wait(1.25)
	local part = Instance.new("Part",ps)
	local cash = Instance.new("IntValue",part)
	part.BrickColor=script.Parent.Parent.Parent.DropColor.Value
	cash.Name = "Cash"
	cash.Value = 4
	part.CFrame = script.Parent.Drop2.CFrame - Vector3.new(0,1,0)
	part.Size=Vector3.new(1,1,1)
	part.TopSurface = "Smooth"
	part.BottomSurface = "Smooth"
	part.Material = script.Parent.Parent.Parent.Material.Value
	fakeDebris = require(game.ReplicatedStorage.fakeDebris)
	fakeDebris.AddItem(part,20)
end