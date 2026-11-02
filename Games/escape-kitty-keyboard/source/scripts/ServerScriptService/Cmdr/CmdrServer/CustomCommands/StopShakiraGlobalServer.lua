local ServerScriptService = game:GetService("ServerScriptService")
local ShakiraEventManager = require(ServerScriptService:WaitForChild("ShakiraEventManager"))

return function(context)
	local success, err = ShakiraEventManager.Stop()

	if not success then
		return err or "The Shakira concert event is not active!"
	end

	local executor = context.Executor
	return string.format("[EVENT] 🎤 SHAKIRA CONCERT stopped by %s! (All servers)", executor and executor.Name or "Admin")
end