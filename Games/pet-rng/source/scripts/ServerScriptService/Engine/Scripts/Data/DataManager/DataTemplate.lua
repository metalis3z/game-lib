local data = {
	["Pets"] = {},
	["EquipedPet"] = "",
	["Items"] = {},
	["Boosts"] = {
		["Luck Boost I"] = {Time=0, luck=2},
		["Luck Boost II"] = {Time=0, luck=5},
		["Luck Boost III"] = {Time=0, luck=10},
		["Golden Dice"] = {Rolls=0, luck=2},
		["Diamond Dice"] = {Rolls=0, luck=5},
		["Rainbow Dice"] = {Rolls=0, luck=10},
		["Luck Aura"] = false,
		["Electro Bubble"] = false,
		["Burst Aura"] = false,
		["Shining Star"] = false,
		["Foggy Aura"] = false,
		["Bubble Burst"] = false,
		["Recharged Aura"] = false,
	},
	["Settings"] = {
		["SFX"] = true,
		["Music"] = true,
		["HidePets"] = false
	},
	["World"] = "Basic",
	["Chest"] = {
		["ClaimTime"] = 0
	},
	["RedeemedCodes"] = {},
	["Rolls"] = 0,
	["LogInTimes"] = 0
}

return data
