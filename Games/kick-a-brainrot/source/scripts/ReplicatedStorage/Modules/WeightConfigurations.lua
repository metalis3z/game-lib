--!strict
-- LOCATION: ReplicatedStorage/Modules/WeightConfigurations

local WeightConfigurations = {}

WeightConfigurations.Weights = {
	["Small Normal"] = { 
		Power = 2, 
		Price = 100,
		ProductId = 3580373389, 
		ImageId = "rbxassetid://96576645351544",
	},
	["Big Normal"] = { 
		Power = 4, 
		Price = 500, 
		ProductId = 3580373522,
		ImageId = "rbxassetid://129638189981190",
	},
	["Small Electro"] = { 
		Power = 6, 
		Price = 3000,
		ProductId = 3580373682, 
		ImageId = "rbxassetid://97032237837079",
	},
	["Big Electro"] = { 
		Power = 9, 
		Price = 10000, 
		ProductId = 3580373824,
		ImageId = "rbxassetid://115044910189919",
	},
	["Small Ice"] = { 
		Power = 12, 
		Price = 25000,
		ProductId = 3580373992, 
		ImageId = "rbxassetid://119809304423459",
	},
	["Big Ice"] = { 
		Power = 16, 
		Price = 60000, 
		ProductId = 3580374126,
		ImageId = "rbxassetid://139998692049310",
	},
	["Small Lava"] = { 
		Power = 20, 
		Price = 100000,
		ProductId = 3580374323, 
		ImageId = "rbxassetid://126747316176658",
	},
	["Big Lava"] = { 
		Power = 25, 
		Price = 200000, 
		ProductId = 3580374487,
		ImageId = "rbxassetid://95633548995589",
	},
}

function WeightConfigurations.GetWeightData(weightName: string)
	return WeightConfigurations.Weights[weightName]
end

return WeightConfigurations