local ServerStorage = game:GetService("ServerStorage")

return function(context, message)
	local BroadcastAnnouncement = ServerStorage:WaitForChild("BroadcastAnnouncement", 10)
	if not BroadcastAnnouncement then
		return "Announcement system is not ready."
	end

	local ok, success, result = pcall(function()
		return BroadcastAnnouncement:Invoke(context.Executor, message)
	end)
	if not ok then
		warn("Cmdr announce failed:", success)
		return "Failed to send announcement. Check the server output."
	end

	return result or (success and "Announcement sent." or "Failed to send announcement.")
end