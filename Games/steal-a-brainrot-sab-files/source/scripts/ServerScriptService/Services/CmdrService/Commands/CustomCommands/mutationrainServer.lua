local ServerScriptService = game:GetService("ServerScriptService")
local AnimalService = require(ServerScriptService.Services.AnimalService)

return function(context, amount: number, mutation: string?)
	local executor = context.Executor
	if not executor then
		return "❌ No executor."
	end

	local ok, err = AnimalService:StartGlobalMutationRain(mutation, amount, executor.UserId)
	if ok then
		local label = (mutation and mutation ~= "") and mutation or "cycle (all mutations)"
		return string.format(
			"🌧️ Global  started — %s for the next %d brainrots on every server.",
			label, math.floor(tonumber(amount) or 0)
		)
	else
		return "❌ " .. tostring(err or "Failed to start global .")
	end
end
