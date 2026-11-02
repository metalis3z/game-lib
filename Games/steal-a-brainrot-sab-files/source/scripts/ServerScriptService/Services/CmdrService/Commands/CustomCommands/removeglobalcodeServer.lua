return function(context, code)
	if not code or code == "" then
		return "Missing code."
	end

	local CodesService = require(game:GetService("ServerScriptService").Services.CodesService)

	local ok, reason = CodesService.RemoveCode(code, context.Executor.UserId)
	if not ok then
		return "Failed: " .. tostring(reason or "unknown error")
	end

	return string.format("Global code '%s' removed across all servers \xe2\x9c\x85", string.upper(code))
end
