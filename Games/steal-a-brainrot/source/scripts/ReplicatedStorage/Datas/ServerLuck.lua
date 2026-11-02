local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Updates = require(ReplicatedStorage.Shared.Updates)
local FFlags = require(ReplicatedStorage.Packages.FFlags)

-- Système de luck v2 avec vrais % de boost par rareté
-- Les % sont calculés depuis RarityPowers dans AnimalService : boost = multiplier ^ power
-- Exemple x8 luck : Legendary = 8^0.6 = +250%, Secret = 8^2.0 = +6300% (plafonné)
local ServerLuck = {
	{
		["Duration"]   = 900,
		["Multiplier"] = 2,
		["ProductId"]  = 3570837655,
		["Label"]      = "x2 Luck",
		-- Boost approximatif affiché aux joueurs (arrondi, lisible)
		["BoostInfo"]  = {
			Rare          = "+10%",
			Epic          = "+20%",
			Legendary     = "+50%",
			Mythic        = "+87%",
			["Brainrot God"] = "+160%",
			Secret        = "+300%",
			OG            = "+1030%",
		},
	},
	{
		["Duration"]   = 900,
		["Multiplier"] = 4,
		["ProductId"]  = 3570837656,
		["Label"]      = "x4 Luck",
		["BoostInfo"]  = {
			Rare          = "+21%",
			Epic          = "+41%",
			Legendary     = "+130%",
			Mythic        = "+250%",
			["Brainrot God"] = "+600%",
			Secret        = "+1500%",
			OG            = "+12700%",
		},
	},
	{
		["Duration"]   = 900,
		["Multiplier"] = 8,
		["ProductId"]  = 3570837657,
		["Icon"]       = "rbxassetid://124799036749678",
		["Tag"]        = "rainbow",
		["Label"]      = "x8 Luck",
		["BoostInfo"]  = {
			Rare          = "+40%",
			Epic          = "+90%",
			Legendary     = "+250%",
			Mythic        = "+550%",
			["Brainrot God"] = "+1740%",
			Secret        = "+6300%",
			OG            = "MAX (x500)",
		},
	},
}

return ServerLuck
