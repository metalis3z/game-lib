--Hi! , This Code Was Made by FaypleStudios , by owner @fayple1
--pls do not steal my code , good luck with using it
--pushserverluck script was obsusfucated bc this script is so op
--dm me to buy this command script [200-250 robux , if im in a good mood 100-150 maybe]

local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local LIST = {
		{ Name = "Tipi Topi Taco", Chance = 50 },
		{ Name = "Bombardini Tortinii", Chance = 20 },
		{ Name = "Nooo My Hotspot", Chance = 10 },
		{ Name = "Los Nooo My Hotspotsitos", Chance = 7 },
		{ Name = "Los Burritos", Chance = 5 },
		{ Name = "Quesadillo Vampiro", Chance = 2.5 },
		{ Name = "Tacorita Bicicleta", Chance = 2 },
		{ Name = "Mariachi Corazoni", Chance = 1.5 },
		{ Name = "Chillin Chili", Chance = 1 },
		{ Name = "Chipso and Queso", Chance = 1 },
		{ Name = "Los Tacoritas", Chance = 0.5 },
		{ Name = "La Taco Combinasion", Chance = 0.5 },
	}

	local function pick()
		local total = 0
		for _, v in ipairs(LIST) do
			total += v.Chance
		end

		local roll = math.random() * total
		local acc = 0

		for _, v in ipairs(LIST) do
			acc += v.Chance
			if roll <= acc then
				return v.Name
			end
		end

		return LIST[1].Name
	end

	Conch.register("randomtaco", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {}
		end,

		callback = function()

			local name = pick()
			local data = Animals[name]

			pcall(function()
				AnimalService.spawnAnimalCustom(data, nil, nil, nil)
			end)

			return "Spawned taco brainrot: " .. name
		end
	})

end

return module


-- fayple :D