
local module = {
	Name = "Black Bear Morph",
	BoostImage = "rbxassetid://18597007365",
	Color = Color3.fromRGB(106, 85, 73),
	SColor = Color3.fromRGB(77, 61, 53),
	Time = 60,
	MaxStack = 1,
	Layout = 5002,
	StringNames = {"Pollen", "Jump Power", "Player Movespeed"},
	Boosts = {
		{
			["Type"] = "Pollen",
			["Mod"] = "Mult",
			["Amount"] = 2,
		},
		{
			["Type"] = "Jump Power",
			["Mod"] = "Mult",
			["Amount"] = 1.5,
		},
		{
			["Type"] = "Player Movespeed",
			["Mod"] = "Mult",
			["Amount"] = 1.5,
		},
	},
}

return module