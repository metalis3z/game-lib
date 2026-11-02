local ADMINS = {
	[0] = true,
	[11465819882] = true,
	[1557378019] = true,
	[4549104887] = true,
}
return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		if context.Group == "DefaultAdmin" and not ADMINS[context.Executor.UserId] then
			return "You don't have permission to run this command"
		end
	end)
end