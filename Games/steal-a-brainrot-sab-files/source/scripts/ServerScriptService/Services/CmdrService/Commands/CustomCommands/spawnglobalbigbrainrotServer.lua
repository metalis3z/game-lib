return function(context, animalName, amount, mutation, size, traits)
	local Players = game:GetService("Players")
	local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
	local player = Players:GetPlayerByUserId(context.Executor.UserId)
	if not player then
		return "❌ Could not find your player instance."
	end

	local spawnCount = math.clamp(math.floor(tonumber(amount) or 1), 1, 50)

	if size ~= nil then
		local sz = tonumber(size)
		if not sz then
			return "❌ Size must be a valid number."
		end
		size = sz
	end

	local pubOk, pubErr = pcall(function()
		MessagingService:PublishAsync("GlobalBrainrotSpawn", {
			sourceJobId       = game.JobId,
			senderUserId      = player.UserId,
			senderDisplayName = player.DisplayName,
			animalName        = animalName,
			mutation          = mutation or "",
			traits            = traits or "",
			size              = size,
			amount            = spawnCount,
		})
	end)
	if not pubOk then
		warn(string.format("[spawnbigbrainrot] Global publish failed: %s", tostring(pubErr)))
	end

	local successCount = 0
	local lastError = nil

	for i = 1, spawnCount do
		local ok, result = _G.SpawnLocalAnimal(
			player.UserId,  -- playerOrId
			animalName,     -- animalName
			mutation,       -- mutation
			traits,         -- traitList
			nil,            -- speed
			false,          -- sammyspawn
			nil,            -- rarity
			nil,            -- generation
			nil,            -- cost
			nil,            -- fakemode
			nil,            -- spawnmode
			nil,            -- displayname
			size,           -- Size
			nil             -- CustomSpawnVFX
		)
		if ok then
			successCount = successCount + 1
		else
			lastError = result
		end
	end

	local mutationText = (mutation and mutation ~= "" and mutation ~= "Default") and (" (" .. mutation .. ")") or ""
	local sizeText     = size and (" size " .. tostring(size)) or ""
	local traitsText   = (traits and traits ~= "" and traits ~= "None") and (" with traits [" .. traits .. "]") or ""

	if successCount == spawnCount then
		return string.format("🌍 Spawned '%s'%s%s%s x%d successfully!", animalName, mutationText, sizeText, traitsText, successCount)
	elseif successCount > 0 then
		return string.format("⚠️ Spawned %d/%d '%s'%s%s%s. Last error: %s", successCount, spawnCount, animalName, mutationText, sizeText, traitsText, tostring(lastError))
	else
		return string.format("❌ Failed to spawn '%s': %s", animalName, tostring(lastError))
	end
end