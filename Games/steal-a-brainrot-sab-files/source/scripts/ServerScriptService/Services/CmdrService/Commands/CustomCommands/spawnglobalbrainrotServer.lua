return function(context, animalName,amount, mutation, traits, speed, jobid)
	local Players = game:GetService("Players")
	local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
	local player = Players:GetPlayerByUserId(context.Executor.UserId)
	if not player then
		return "❌ Could not find your player instance."
	end
	jobid = (jobid and jobid ~= "") and jobid or nil
	if jobid and not MessagingService:IsKnownJobId(jobid) then
		return string.format("invalid jobid '%s'.", jobid)
	end
	local spawnCount = math.clamp(math.floor(tonumber(amount) or 1), 1, 50)
	if speed ~= nil then
		local s = tonumber(speed)
		if not s then
			return "❌ Speed must be a valid number."
		elseif s <= 2 then
			return "❌ Speed must be greater than 2."
		elseif s >= 100000 then
			return "❌ Speed must be less than 100,000."
		end
		speed = s
	end
	local successCount = 0
	local failCount = 0
	local ok, err = pcall(function()
		MessagingService:PublishAsync("GlobalBrainrotSpawn", {
			sourceJobId       = game.JobId,
			senderUserId      = player.UserId,
			senderDisplayName = player.DisplayName,
			animalName        = animalName,
			mutation          = mutation or "",
			traits            = traits or "",
			speed             = speed,
			amount            = spawnCount,
		}, jobid)
	end)
	if ok then
		successCount = spawnCount
	else
		failCount = spawnCount
		warn(string.format("[spawnroadbrainrotglobal] Global publish failed: %s", tostring(err)))
	end
	if not jobid or jobid == game.JobId then
		for i = 1, spawnCount do
			_G.SpawnLocalAnimal(player.UserId, animalName, mutation, traits, speed)
		end
	end
	local mutationText = (mutation and mutation ~= "" and mutation ~= "Default") and (" (" .. mutation .. ")") or ""
	local traitsText   = (traits and traits ~= "" and traits ~= "None") and (" with traits [" .. traits .. "]") or ""
	local speedText    = speed and (" at speed " .. tostring(speed)) or ""
	local amountText   = spawnCount > 1 and (" x" .. spawnCount) or ""
	if failCount == 0 then
		return string.format("🌍 Globally spawned '%s'%s%s%s%s successfully!", animalName, mutationText, traitsText, speedText, amountText)
	else
		return string.format("⚠️ Spawned %d/%d '%s'%s%s%s globally. %d failed (check output).", successCount, spawnCount, animalName, mutationText, traitsText, speedText, failCount)
	end
end