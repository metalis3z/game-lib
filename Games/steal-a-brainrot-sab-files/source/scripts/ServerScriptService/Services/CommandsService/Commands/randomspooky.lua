--Hi! , This Code Was Made by FaypleStudios , by owner @fayple1
--pls do not steal my code , good luck with using it
--pushserverluck script was obsusfucated bc this script is so op
--dm me to buy this command script [200-250 robux , if im in a good mood 100-150]

local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local LIST = {
		{ Name = "Vampira Cappucina", Chance = 50 },
		{ Name = "Zombie Tralala", Chance = 20 },
		{ Name = "Frankentteo", Chance = 10 },
		{ Name = "La Vacca Jacko Linterino", Chance = 6 },
		{ Name = "Trickolino", Chance = 5.5 },
		{ Name = "Telemorte", Chance = 5 },
		{ Name = "Los Spooky Combinasionas", Chance = 2.5 },
		{ Name = "La Casa Boo", Chance = 1 },
		
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

	Conch.register("randomspooky", {
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

			return "Spawned spooky brainrot: " .. name
		end
	})

end

return module

--fayple studios are the best 