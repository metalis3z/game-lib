wait(2)
ps = script.Parent.Parent.Parent.PartStorage
while true do
	wait(5) -- How long in between drops
	local part = Instance.new("Part",ps)
	part.BrickColor=script.Parent.Parent.Parent.DropColor.Value
	local cash = Instance.new("IntValue",part)
	cash.Name = "Cash"
	cash.Value = 22 -- How much the drops are worth
	part.CFrame = script.Parent.Drop.CFrame - Vector3.new(0,0,0)
	part.Size=Vector3.new(2.7,2.7,2.7)
	part.TopSurface = "Smooth"
	part.BottomSurface = "Smooth"
	part.Material = script.Parent.Parent.Parent.Material.Value
		fakeDebris = require(game.ReplicatedStorage.fakeDebris)
	fakeDebris.AddItem(part,20)
end