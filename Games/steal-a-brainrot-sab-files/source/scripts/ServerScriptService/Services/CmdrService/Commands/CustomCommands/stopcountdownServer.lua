
local ServerScriptService = game:GetService("ServerScriptService")
local CountdownService    = require(ServerScriptService.Services.GlobalCountdownService)

return function(context, confirm)
	if confirm ~= true then
		return "[StopAllTimers] Pass 'true' as the confirm argument to proceed. "
			.. "This will forcefully clear ALL timers, including whitelisted ones."
	end

	local executor   = context.Executor
	local executorId = executor and executor.UserId or 0
	local name       = executor and executor.Name   or "Unknown"

	local success, message = CountdownService.StopAllTimers(executorId)

	if success then
		return string.format(
			"[StopAllTimers] ✓ %s (%d) forcefully stopped all timers. %s",
			name,
			executorId,
			message
		)
	else
		return string.format(
			"[StopAllTimers] ✗ Failed — %s",
			tostring(message)
		)
	end
end