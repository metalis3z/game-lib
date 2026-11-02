
local module = {
	Name = script.Name,
	BoostImage = "rbxassetid://15055931415",
	Color = Color3.fromRGB(212, 203, 255),
	SColor = Color3.fromRGB(141, 135, 170),
	Time = 30,
	MaxStack = 10,
	Layout = 5005,
	StringNames = {"Player Movespeed"},
	Boosts = {
		{
			["Type"] = "Player Movespeed",
			["Mod"] = "Percent",
			["Amount"] = 10,
		},
	},
}

return module