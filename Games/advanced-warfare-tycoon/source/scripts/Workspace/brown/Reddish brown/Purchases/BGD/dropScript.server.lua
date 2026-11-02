wait(2)
ps = script.Parent.Parent.Parent.PartStorage
while true do
	wait(5) -- How long in between drops
	local part = Instance.new("Part",ps)
	local cash = Instance.new("IntValue",part)
	part.BrickColor=BrickColor.new("New Yeller")
	cash.Name = "Cash"
	cash.Value = 2500 -- How much the drops are worth
	part.CFrame = script.Parent.Drop.CFrame - Vector3.new(0,2.5,0)
	part.Size=Vector3.new(1.5,1.5,1.5) -- Size of the drops
	part.TopSurface = "Smooth"
	part.BottomSurface = "Smooth"
	part.Material = "Granite"
	fakeDebris = require(game.ReplicatedStorage.fakeDebris)
	fakeDebris.AddItem(part,20)
end