local ServerScriptService = game:GetService("ServerScriptService")
local ShakiraEventManager = require(ServerScriptService:WaitForChild("ShakiraEventManager"))

return function(context, duration)
	duration = duration or 200

	local success, err = ShakiraEventManager.Start(duration)

	if not success then
		return err or "The Shakira concert event is already active!"
	end

	local executor = context.Executor
	local msg = string.format("[EVENT] 🎤 SHAKIRA CONCERT started by %s! (All servers)", executor and executor.Name or "Admin")

	if duration and duration > 0 then
		local mins = math.floor(duration / 60)
		local secs = duration % 60
		msg = msg .. string.format(" Duration: %dm %ds. Auto-stop at the end.", mins, secs)
	end

	return msg
end