local ServerScriptService = game:GetService("ServerScriptService")
local AnnouncementService = require(ServerScriptService.Services.AnnouncementService)

return function(context, text)
	if type(text) ~= "string" or #text == 0 then
		return "❌ Announcement text is empty"
	end

	task.spawn(AnnouncementService.AnnounceToServer, context.Executor, text, nil)
	return "✅ Announcement sent!"
end