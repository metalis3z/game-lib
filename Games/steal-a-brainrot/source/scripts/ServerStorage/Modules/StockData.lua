local StockData = {}

local TacoStockEvent = {
	["La Taco Combinasion"] = {
		Order = 1,
		Inputs = {
			"Quesadilla Crocodila",
			"Burrito Bandito",
			"Los Nooo My Hotspotsitos",
			"Mariachi Corazoni"
		},
		Output = "La Taco Combinasion"
	}
}

local WorLStockEvent = {
	["W or L"] = {
		Order = 2,
		Inputs = {
			"Cuadramat and Pakrahmatmamat",
			"Los Quesadillas",
			"Los Burritos",
			"Los 67"
		},
		Output = "W or L"
	}
}

local WinterHourStockEvent = {
	["La Jolly Grande"] = {
		Order = 3,
		Inputs = {
			"Ballerina Peppermintina",
			"Reindeer Tralala",
			"Santteo",
			"List List List Sahur"
		},
		Output = "La Jolly Grande"
	}
}

local TacoStockEvent2 = {
	["Swaggy Bros"] = {
		Order = 4,
		Inputs = {
			"Swag Soda",
			"Los 25",
			"Los Burritos",
			"67"
		},
		Output = "Swaggy Bros"
	}
}

local MainStockEvent = {
	["Tuff Toucan"] = {
		Order = 5,
		Inputs = {
			"Tootini Shrimpini",
			"Rocco Disco",
			"Bunito Bunito Spinito"
		},
		Output = "Tuff Toucan"
	}
}

local TacoStockEvent3 = {
	["La Romantic Grande"] = {
		Order = 6,
		Inputs = {
			"La Grande Combinasion",
			"Los Burritos",
			"Noo my Heart",
			"Chicleteira Cupideira"
		},
		Output = "La Romantic Grande"
	}
}

local TacoStockEvent4 = {

	["Tacorillo Crocodillo"] = {
		Order = 7,
		Inputs = {
			"Los Quesadillas",
			"Burrito Bandito",
			"Quesadilla Crocodila"
		},
		Output = "Tacorillo Crocodillo"
	},

	["Nacho Spyder"] = {
		Order = 8,
		Inputs = {
			"Tictac Sahur",
			"Bacuru and Egguru",
			"Sammyni Spyderini"
		},
		Output = "Nacho Spyder"
	}

}

local TacoStockEvent5 = {
	["La Lucky Grande"] = {
		Order = 6,
		Inputs = {
			"La Grande Combinasion",
			"Noo my Gold",
			"Snailo Clovero"
		},
		Output = "La Lucky Grande"
	}
}

local TacoStockEvent6 = {
	["Tucano Capitano"] = {
		Order = 6,
		Inputs = {
			"Capitano Moby",
			"Garama and Madundung",
			"Tukanno Bananno"
		},
		Output = "Gamer Bros"
	}
}

StockData.Taco4 = TacoStockEvent
StockData.WorL = WorLStockEvent
StockData.WinterHour = WinterHourStockEvent
StockData.Taco5 = TacoStockEvent2
StockData.MainStock = MainStockEvent
StockData.Taco6 = TacoStockEvent3
StockData.Taco7 = TacoStockEvent4
StockData.Taco8 = TacoStockEvent5
StockData.Taco9 = TacoStockEvent6

return StockData