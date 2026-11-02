wait(2.5)
ps = script.Parent.Parent.Parent.PartStorage
DS = game.Lighting.Script:Clone()
while true do
	wait(4) -- How long in between drops
	local part = Instance.new("Part",ps)
	local cash = Instance.new("IntValue",part)
	cash.Name = "Cash"
	cash.Value = 11 -- How much the drops are worth
	part.CFrame = script.Parent.Drop3.CFrame - Vector3.new(0,1,0)
	part.FormFactor = "Custom"
	part.Size=Vector3.new(1.41,1,2.69) -- Size of the drops
		part.BrickColor = BrickColor.new("New Yeller")
		part.TopSurface = "Smooth"
		part.BottomSurface = "Smooth"
			part.Material = script.Parent.Parent.Parent.Material.Value
		DS.Parent = part
			part.Transparency = .4
	game.Debris:AddItem(part,20) -- How long until the drops expire
end