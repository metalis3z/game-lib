local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Updates)

local LuckyBlocks = {}

local function rollByChance(animals)
	local roll = math.random() * 100
	local current = 0

	for _, animal in ipairs(animals) do
		local chance = tonumber(animal.Chance) or 0
		current += chance

		if roll <= current then
			return animal.Name
		end
	end

	return animals[#animals].Name
end

function LuckyBlocks.Roll(blockName)
	local blockData = LuckyBlocks[blockName]
	if not blockData or not blockData.Animals then
		warn("[LuckyBlocks] Block not found:", blockName)
		return nil
	end

	local animals = blockData.Animals

	if #animals == 0 then
		warn("[LuckyBlocks] No animals in block:", blockName)
		return nil
	end

	if animals[1] and animals[1].Chance ~= nil then
		return rollByChance(animals)
	end

	return animals[math.random(1, #animals)].Name
end

LuckyBlocks["Mythic Lucky Block"] = {
	ProductId = 3570837667,
	Timer = 600,
	Animals = {
		{ Name = "Spioniro Golubiro", Chance = 37 },
		{ Name = "Zibra Zubra Zibralini", Chance = 30 },
		{ Name = "Tigrilini Watermelini", Chance = 20 },
		{ Name = "Carrotini Brainini", Chance = 10 },
		{ Name = "Bananito Bandito", Chance = 3 }
	}
}

LuckyBlocks["Brainrot God Lucky Block"] = {
	ProductId = 3570837668,
	Timer = 900,
	Animals = {
		{ Name = "Tigroligre Frutonni", Chance = 54 },
		{ Name = "Orcalero Orcala", Chance = 30 },
		{ Name = "Bulbito Bandito Traktorito", Chance = 10 },
		{ Name = "Mastodontico Telepiedone", Chance = 5 },
		{ Name = "Pop Pop Sahur", Chance = 1 }
	}
}

LuckyBlocks["Secret Lucky Block"] = {
	ProductId = 3609989221,
	Timer = 1800,
	Animals = {
		{ Name = "La Grande Combinasion", Chance = 74.5 },
		{ Name = "Ketupat Kepat", Chance = 21 },
		{ Name = "Spaghetti Tualetti", Chance = 3 },
		{ Name = "Cerberus", Chance = 1 },
		{ Name = "Garama and Madundung", Chance = 0.5 },
		{ Name = "Skibidi Toilet", Chance = 0.05 }
	}
}

LuckyBlocks["Ultime Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "La Grande Combinasion", Chance = 74.5 },
		{ Name = "Garama and Madundung", Chance = 21 },
		{ Name = "Cerberus", Chance = 3 },
		{ Name = "La Secret Combinasion", Chance = 1 },
		{ Name = "Fortunu and Cashuru", Chance = 0.5 },
		{ Name = "Meowl", Chance = 0.05 }
	}
}

LuckyBlocks["Admin Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Carloo", Chance = 35 },
		{ Name = "Alessio", Chance = 25 },
		{ Name = "Los Bombinitos", Chance = 20 },
		{ Name = "Crabbo Limonetta", Chance = 10 },
		{ Name = "Blackhole Goat", Chance = 5 },
		{ Name = "Guerriro Digitale", Chance = 3 },
		{ Name = "67", Chance = 1.5 },
		{ Name = "La Grande Combinasion", Chance = 0.5 },
		{ Name = "Sammyni Fattini", Chance = 0.45 }
	}
}
LuckyBlocks["OG Lucky Block"] = {
	ProductId = 3329528437,
	Timer = 1800,
	Animals = {
		{ Name = "La Grande Combinasion", Chance = 0.1 },
		{ Name = "Garama and Madundung", Chance = 20 },
		{ Name = "La Secret Combinasion", Chance = 3 },
		{ Name = "Cerberus", Chance = 1 },
		{ Name = "Fortunu and Cashuru", Chance = 0.5 },
		{ Name = "Meowl", Chance = 0.05 },
	}
}

LuckyBlocks["Taco og Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Garama and Madundung", Chance = 49 },
		{ Name = "Ketupat Kepat", Chance = 32 },
		{ Name = "Ketchuru and Musturu", Chance = 10 },
		{ Name = "La Food Combinasion", Chance = 5 },
		{ Name = "Strawberry Elephant", Chance = 3 },
		{ Name = "Jelly Moby", Chance = 1 },
		{ Name = "Headless Horseman", Chance = 0.2 }
	}
}

LuckyBlocks["Los Lucky Blocks"] = {
	Timer = 0,
	Animals = {
		{ Name = "Los Bombinitos", Chance = 40 },
		{ Name = "Los Tungtungtungcitos", Chance = 25 },
		{ Name = "Los Orcalitos", Chance = 15 },
		{ Name = "Los Tipi Tacos", Chance = 10 },
		{ Name = "Los Tortus", Chance = 5 },
		{ Name = "Los Jobcitos", Chance = 3.5 },
		{ Name = "Los Combinasionas", Chance = 1 },
		{ Name = "Los 67", Chance = 0.5 },
		{ Name = "Los Sekolahs", Chance = 0.1 }
	}
}

LuckyBlocks["Spooky Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Mummy Ambalabu", Chance = 32.7 },
		{ Name = "Cappuccino Clownino", Chance = 32.5 },
		{ Name = "Jackorilla", Chance = 19.5 },
		{ Name = "Pumpkini Spyderini", Chance = 9 },
		{ Name = "Trickolino", Chance = 3 },
		{ Name = "Telemorte", Chance = 2 },
		{ Name = "Los Spooky Combinasionas", Chance = 0.8 },
		{ Name = "La Casa Boo", Chance = 0.2 }
	}
}

LuckyBlocks["Los Taco Blocks"] = {
	Timer = 0,
	Animals = {
		{ Name = "Los Chihuaninis", Chance = 55 },
		{ Name = "Los Gattitos", Chance = 35 },
		{ Name = "Los Cucarachas", Chance = 3 },
		{ Name = "Los Quesadillas", Chance = 2.4 },
		{ Name = "Los Burritos", Chance = 0.5 },
		{ Name = "Los Amigos", Chance = 0.075 }
	}
}

LuckyBlocks["Festive Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Chrismasmamat", Chance = 33 },
		{ Name = "Pandanini Frostini", Chance = 30 },
		{ Name = "Triplito Tralaleritos", Chance = 23 },
		{ Name = "Santa Hotspot", Chance = 9 },
		{ Name = "Chimnino", Chance = 0.8 },
		{ Name = "Los 25", Chance = 2.2 },
		{ Name = "La Ginger Sekolah", Chance = 0.3 },
		{ Name = "Reinito Sleighito", Chance = 0.1 }
	}
}

LuckyBlocks["Premium Festive Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Chrismasmamat", Chance = 30.9 },
		{ Name = "Pandanini Frostini", Chance = 30 },
		{ Name = "Triplito Tralaleritos", Chance = 25 },
		{ Name = "Santa Hotspot", Chance = 10 },
		{ Name = "Los 25", Chance = 2.5 },
		{ Name = "Chimnino", Chance = 1 },
		{ Name = "La Ginger Sekolah", Chance = 0.5 },
		{ Name = "Reinito Sleighito", Chance = 0.1 }
	}
}

LuckyBlocks["Heart Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Luv Luv Luv", Chance = 35 },
		{ Name = "Karkerheart Luvkur", Chance = 30 },
		{ Name = "Love Love Love Sahur", Chance = 23 },
		{ Name = "Cupid Hotspot", Chance = 9 },
		{ Name = "Noo my Heart", Chance = 2 },
		{ Name = "Chicleteira Cupideira", Chance = 0.8 },
		{ Name = "Rosetti Tualetti", Chance = 0.5 },
		{ Name = "Rosey and Teddy", Chance = 0.03 }
	}
}

LuckyBlocks["Premium Heart Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Luv Luv Luv", Chance = 30.95 },
		{ Name = "Karkerheart Luvkur", Chance = 30 },
		{ Name = "Love Love Love Sahur", Chance = 25 },
		{ Name = "Cupid Hotspot", Chance = 10 },
		{ Name = "Noo my Heart", Chance = 2.5 },
		{ Name = "Chicleteira Cupideira", Chance = 1 },
		{ Name = "Rosetti Tualetti", Chance = 0.5 },
		{ Name = "Rosey and Teddy", Chance = 0.05 }
	}
}

LuckyBlocks["Leprechaun Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Patteo", Chance = 35 },
		{ Name = "Clovkur Kurkur", Chance = 30 },
		{ Name = "La Vacca Lepre Lepreino", Chance = 23 },
		{ Name = "Luck Luck Luck Sahur", Chance = 9 },
		{ Name = "Noo my Gold", Chance = 2 },
		{ Name = "Snailo Clovero", Chance = 0.8 },
		{ Name = "Gold Gold Gold", Chance = 0.4 },
		{ Name = "Fortunu and Cashuru", Chance = 0.1 }
	}
}

LuckyBlocks["Premium Leprechaun Lucky Block"] = {
	Timer = 0,
	Animals = {
		{ Name = "Patteo", Chance = 30.9 },
		{ Name = "Clovkur Kurkur", Chance = 30 },
		{ Name = "La Vacca Lepre Lepreino", Chance = 25 },
		{ Name = "Luck Luck Luck Sahur", Chance = 10 },
		{ Name = "Noo my Gold", Chance = 2.5 },
		{ Name = "Snailo Clovero", Chance = 1 },
		{ Name = "Gold Gold Gold", Chance = 0.5 },
		{ Name = "Fortunu and Cashuru", Chance = 0.1 }
	}
}

LuckyBlocks["Coffin Tung Tung Tung Sahur"] = {
	Timer = 0,
	Animals = {
		{ Name = "Tung Tung Tung Sahur", Chance = 100 }
	}
}

return LuckyBlocks