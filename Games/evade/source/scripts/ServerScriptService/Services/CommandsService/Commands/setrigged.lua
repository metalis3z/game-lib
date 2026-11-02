local module = function(Conch, Config)
	Conch.register("setrigged", {
		permissions = { Config.RequiredRole or "super-user" },
		description = "Define which animal will come from a specific Lucky Block",

		arguments = function()
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local LuckyBlocksModule = require(ReplicatedStorage.Datas.LuckyBlocks)
			local AnimalsModule = require(ReplicatedStorage.Datas.Animals)

			local luckyBlockNames = {}
			for name, data in pairs(LuckyBlocksModule) do
				if type(data) == "table" and type(data.Animals) == "table" then
					table.insert(luckyBlockNames, name)
				end
			end

			local animalNames = {}
			for name, _ in pairs(AnimalsModule) do
				table.insert(animalNames, name)
			end

			table.sort(luckyBlockNames)
			table.sort(animalNames)

			return {
				{
					kind = "enum",
					name = "LuckyBlock",
					enum = luckyBlockNames,
					description = "Choose which Lucky Block to edit",
				},
				{
					kind = "enum",
					name = "Animal",
					enum = animalNames,
					description = "Brainrot Name",
				},
				{
					kind = "string",
					name = "Player",
					description = "Player nickname",
				},
			}
		end,

		callback = function(LuckyBlock, Animal, Player)
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local LuckyBlocksModule = require(ReplicatedStorage.Datas.LuckyBlocks)
			local AnimalsModule = require(ReplicatedStorage.Datas.Animals)

			local luckyData = LuckyBlocksModule[LuckyBlock]
			if type(luckyData) ~= "table" then
				return false, "Invalid Lucky Block: " .. tostring(LuckyBlock)
			end

			if type(luckyData.Animals) ~= "table" then
				return false, "Lucky Block has no animals configured."
			end

			if not AnimalsModule[Animal] then
				return false, "Invalid animal: " .. tostring(Animal)
			end

			-- Limpa todos os animais, deixando só o escolhido
			for k in pairs(luckyData.Animals) do
				luckyData.Animals[k] = nil
			end
			luckyData.Animals[Animal] = 1 -- quantidade ou peso padrão

			-- Se forneceu nick, força apenas para esse jogador
			if Player and Player ~= "" then
				luckyData.ForcedPlayer = Player
				luckyData.GetAnimalForPlayer = function(p)
					if p == Player then
						return Animal
					else
						local keys = {}
						for k, _ in pairs(luckyData.Animals) do
							table.insert(keys, k)
						end
						return keys[math.random(1, #keys)]
					end
				end
			end

			return string.format("Lucky Block '%s' will now always drop the animal '%s'%s.", 
				LuckyBlock, 
				Animal, 
				(Player and Player ~= "") and (" para o jogador '"..Player.."'") or ""
			)
		end,
	})
end

return module