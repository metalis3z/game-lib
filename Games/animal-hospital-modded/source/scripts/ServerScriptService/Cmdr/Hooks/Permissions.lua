local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CmdrConfig = require(ReplicatedStorage.Configs.Cmdr)

return function (registry)
	registry:RegisterHook("BeforeRun", function(context)
		if context.Group == "DefaultAdmin" and not table.find(CmdrConfig.Admins, context.Executor.UserId) then
			return "You don't have permission to run this command!"
		end
	end)
end