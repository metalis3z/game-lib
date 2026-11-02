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

StockData.Taco5 = TacoStockEvent
StockData.WorL = WorLStockEvent
StockData.WinterHour = WinterHourStockEvent
StockData.Taco6 = TacoStockEvent2
StockData.MainStock = MainStockEvent

return StockData