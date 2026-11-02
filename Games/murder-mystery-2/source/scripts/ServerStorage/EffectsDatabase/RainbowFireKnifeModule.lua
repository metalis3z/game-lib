return function(Knife)
	local Changer = script.Script:Clone()
	local Fire = Instance.new("Fire", Knife.Handle)
	Fire.Heat = 9
	Fire.Size = 2
	Fire.SecondaryColor = Color3.new(0/255,0/255,0/255)
	Fire.Enabled = true
	Changer.Parent = Fire
end