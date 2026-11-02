--credit to quartz games studio
task.defer(function() --[[ Line: 21 ]]
	game:GetService("RunService")

	local VERSION = require(script.Parent.VERSION)

	VERSION.getAppVersion()
	VERSION.getLatestVersion()

	local _ = not VERSION.isUpToDate()
end)

return {}