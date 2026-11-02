local ServerScriptService = game:GetService("ServerScriptService")
local ChocolateKeycapManager = require(ServerScriptService:WaitForChild("ChocolateKeycapManager"))

return function(context, duration)
	duration = duration or 0

	local success, err = ChocolateKeycapManager.Start(duration > 0 and duration or nil)

	if not success then
		return err or "The event is already active!"
	end

	local executor = context.Executor
	local msg = string.format("[EVENT] 🍫 RAIN OF CHOCOLATE activated by %s! (All servers)", executor and executor.Name or "Admin")

	if duration and duration > 0 then
		local hours = math.floor(duration / 3600)
		local mins = math.floor((duration % 3600) / 60)
		local secs = duration % 60
		local timeStr = ""
		if hours > 0 then timeStr = timeStr .. hours .. "h " end
		if mins > 0 then timeStr = timeStr .. mins .. "m " end
		if secs > 0 then timeStr = timeStr .. secs .. "s" end
		msg = msg .. string.format(" Duration: %s. Auto-stop at the end.", timeStr)
	else
		msg = msg .. " Duration: permanent (use stopeventglobal to stop)."
	end

	return msg
end