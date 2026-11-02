local ServerScriptService = game:GetService("ServerScriptService")
local ChocolateKeycapManager = require(ServerScriptService:WaitForChild("ChocolateKeycapManager"))

return function(context)
	local success, err = ChocolateKeycapManager.Stop()

	if not success then
		return err or "The event is not active!"
	end

	local executor = context.Executor
	return string.format("[EVENT] 🍫 RAIN OF CHOCOLATE stopped by %s! (All servers)", executor and executor.Name or "Admin")
end