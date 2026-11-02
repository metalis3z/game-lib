-- CommandsService/Commands/spawnluckyblockglobal
-- Usage: /spawnluckyblockglobal <Lucky Block> [Amount] [Mutation]
-- Spawns on THIS server, then broadcasts so every live server spawns too.

local MessagingService = game:GetService("MessagingService")
local TOPIC = "SpawnLuckyBlockGlobal"

return function(Conch, Config)
	Conch.register("spawnluckyblockglobal", {
		permissions = { (Config and Config.RequiredRole) or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "LuckyBlock",
					name = "Lucky Block",
				},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true,
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true,
			}
		end,

		callback = function(luckyBlock, amount, mutation)
			amount = tonumber(amount) or 1
			if amount < 1 then
				return false, "Amount must be at least 1"
			end
			if amount > 100 then amount = 100 end -- safety cap

			local roadService = _G and _G.RoadAnimalService
			if not (roadService and roadService.Spawner and roadService.Spawner.SpawnSpecificAnimal) then
				return false, "RoadAnimalService not running"
			end

			local mutParam
			if mutation == nil or mutation == "" or tostring(mutation):lower() == "normal" then
				mutParam = nil
			else
				mutParam = mutation
			end

			-- 1) Spawn locally first
			local okCount = 0
			for i = 1, amount do
				local ok, res = pcall(function()
					-- Your existing local command calls this same API for Lucky Blocks
					return roadService.Spawner:SpawnSpecificAnimal(luckyBlock, nil, mutParam)
				end)
				if ok and res then okCount = okCount + 1 end
			end

			-- 2) Broadcast to all servers (listener skips same JobId to avoid double)
			pcall(function()
				MessagingService:PublishAsync(TOPIC, {
					luckyBlock = luckyBlock,
					amount = amount,
					mutation = mutParam,
					originJobId = game.JobId,
					originPlaceId = game.PlaceId,
					ts = os.time(),
				})
			end)

			if okCount == 0 then
				return false, string.format("Failed to spawn any %s locally (broadcast sent).", tostring(luckyBlock))
			end
			return string.format("Spawned %d %s locally and broadcast to all servers.", okCount, tostring(luckyBlock))
		end,
	})
end
