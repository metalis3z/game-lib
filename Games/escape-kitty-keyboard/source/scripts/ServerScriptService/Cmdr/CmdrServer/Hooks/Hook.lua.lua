if game:GetService("RunService"):IsClient() then return function() end end
local ServerStorage = game:GetService("ServerStorage")

local AuthorizedUsers = require(ServerStorage.Data.AuthorizedUsers)
local AfterRole       = require(ServerStorage.Data.AfterRole)

return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		local group = context.Group

		if group == "DefaultOpen" then return end

		local userId = context.Executor.UserId
		local role   = AuthorizedUsers[userId]

		if not role then
			return "WARNING: You do not have an authorized role to run this run."
		end

		local allowedGroups = AfterRole[role]
		if not allowedGroups then
			return "🚫 Your role has no permissions configured."
		end
		
		for _, allowedGroup in ipairs(allowedGroups) do
			if allowedGroup == group then
				return
			end
		end

		return string.format("🚫 Your role (%s) cannot run commands in group: %s", role, group)
	end)
end