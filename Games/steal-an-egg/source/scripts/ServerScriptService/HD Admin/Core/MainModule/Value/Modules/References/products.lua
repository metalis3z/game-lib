-- Changing any products here violates HD Admin's LICENSE
-- and revokes your permission to legally use HD Admin

local function register(item: Product): Product
	return item :: Product
end

local products = {
	----------------
	["LaserEyes"] = register({
		id = 132505519521255,
		infoType = Enum.InfoType.Asset,
	}),

	----------------
	["OldLaserEyes"] = register({
		id = 1007746205,
		infoType = Enum.InfoType.GamePass,
	}),

	----------------
	["OldBooster"] = register({
		id = 1007884962,
		infoType = Enum.InfoType.GamePass,
	}),

	----------------
	["OldDonor"] = register({
		id = 5745895,
		infoType = Enum.InfoType.GamePass,
	}),

	----------------
	["Booster"] = register({
		id = 91265843061691,
		infoType = Enum.InfoType.Asset,
	}),

	----------------
	["BoosterDiscount"] = register({
		id = 78104307094868,
		infoType = Enum.InfoType.Asset,
	}),

	----------------
	-- These are placeholder assets until we finish the real cosmetics
	["SpecialAccessory1"] = register({
		id = 607702162,
		infoType = Enum.InfoType.Asset,
		accessoryName = "Roblox Baseball Cap",
		accessoryOrder = 1,
		comingSoon = true,
	}),
	["SpecialAccessory2"] = register({
		id = 376526673,
		infoType = Enum.InfoType.Asset,
		accessoryName = "Stylish Aviators",
		accessoryOrder = 2,
		comingSoon = true,
	}),
	["SpecialAccessory3"] = register({
		id = 1192464705,
		infoType = Enum.InfoType.Asset,
		accessoryName = "Bear Face Mask",
		accessoryOrder = 3,
		comingSoon = true,
	}),
	["SpecialAccessory4"] = register({
		id = 4849184439,
		infoType = Enum.InfoType.Asset,
		accessoryName = "Butterfly Hat",
		accessoryOrder = 4,
		comingSoon = true,
	}),
	["SpecialAccessory5"] = register({
		id = 17165040274,
		infoType = Enum.InfoType.Asset,
		accessoryName = "Rainbow Fun Fedora",
		accessoryOrder = 5,
		comingSoon = true,
	}),
	["SpecialAccessory6"] = register({
		id = 139152472,
		infoType = Enum.InfoType.Asset,
		accessoryName = "Holiday Crown",
		accessoryOrder = 6,
		comingSoon = true,
	}),

	----------------
	-- Coming soon
	["Donation50"] = register({
		id = 0,
		infoType = Enum.InfoType.Product,
		donationRobux = 50,
	}),
	["Donation100"] = register({
		id = 0,
		infoType = Enum.InfoType.Product,
		donationRobux = 100,
	}),
	["Donation250"] = register({
		id = 0,
		infoType = Enum.InfoType.Product,
		donationRobux = 250,
	}),
	["Donation500"] = register({
		id = 0,
		infoType = Enum.InfoType.Product,
		donationRobux = 500,
	}),
	["Donation1000"] = register({
		id = 0,
		infoType = Enum.InfoType.Product,
		donationRobux = 1000,
	}),

	----------------
}

export type ProductName = keyof<typeof(products)>
export type Product = {
	id: number,
	infoType: Enum.InfoType,
	accessoryName: string?,
	accessoryOrder: number?,
	comingSoon: boolean?,
	donationRobux: number?,
}

return products :: {[ProductName]: Product}
