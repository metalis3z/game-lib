local items = {
	["Test Item"] = {
		Luck = 0,
		Description = "This is a test item",
		Requirements = {
			["Common"] = 1,
			["Uncommon"] = 0,
			["Rare"] = 0,
			["Epic"] = 0,
			["Legendary"] = 0,
			["Mythic"] = 0
		}
	},
	["Luck Potion I"] = {
		Luck = 2,
		Description = "+2 Luck For 5 Minutes",
		Requirements = {
			["Common"] = 20,
			["Uncommon"] = 15,
			["Rare"] = 5,
			["Epic"] = 0,
			["Legendary"] = 0,
			["Mythic"] = 0
		}
	}
}

return items
