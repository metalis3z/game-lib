local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuckyBlocksModule = require(ReplicatedStorage.Datas.LuckyBlocks)
local AnimalsModule = require(ReplicatedStorage.Datas.Animals)

return function(context, LuckyBlock, Animal, Player)
	local luckyData = LuckyBlocksModule[LuckyBlock]
	if type(luckyData) ~= "table" then
		return "❌ Invalid Lucky Block: " .. tostring(LuckyBlock)
	end

	if type(luckyData.Animals) ~= "table" then
		return "❌ Lucky Block has no animals configured."
	end

	if not AnimalsModule[Animal] then
		return "❌ Invalid animal: " .. tostring(Animal)
	end

	for k in pairs(luckyData.Animals) do
		luckyData.Animals[k] = nil
	end
	luckyData.Animals[Animal] = 1

	if Player and Player ~= "" then
		luckyData.ForcedPlayer = Player
		luckyData.GetAnimalForPlayer = function(p)
			if p == Player then
				return Animal
			else
				local keys = {}
				for k in pairs(luckyData.Animals) do
					table.insert(keys, k)
				end
				return keys[math.random(1, #keys)]
			end
		end
	end

	local executor = context.Executor

	local finalMessage = string.format(
		"🍀 Lucky Block Set by %s\n\n📦 Block: %s\n🐾 Animal: %s%s",
		executor.Name,
		LuckyBlock,
		Animal,
		(Player and Player ~= "") and ("\n👤 Forced Player: " .. Player) or ""
	)

	print(finalMessage)
	return finalMessage
end