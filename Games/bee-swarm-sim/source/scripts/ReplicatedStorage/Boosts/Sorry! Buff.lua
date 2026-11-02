
local module = {
	Name = "Sorry! Buff",
	BoostImage = "rbxassetid://17885249437",
	Color = Color3.fromRGB(106, 85, 73),
	SColor = Color3.fromRGB(77, 61, 53),
	Time = 43200,
	MaxStack = 1,
	Layout = 5002,
	StringNames = {"Pollen"},
	Boosts = {
		{
			["Type"] = "Pollen",
			["Mod"] = "Mult",
			["Amount"] = 2,
		},
	},
}

return module