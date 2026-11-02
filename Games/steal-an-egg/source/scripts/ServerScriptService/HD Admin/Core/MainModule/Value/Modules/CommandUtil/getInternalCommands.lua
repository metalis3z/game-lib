--!strict
local forEveryCommand = require(script.Parent.forEveryCommand)

return function(group: ModuleScript)
	return function(childName: string): {any}
		local child = group:FindFirstChild(childName)
		if not child or not child:IsA("ModuleScript") then
			warn(`HD Admin: '{group.Name}' has no child command module '{childName}'`)
			return {}
		end
		local success, commands = pcall(require, child)
		if not success then
			warn(`HD Admin: command module '{group.Name}.{childName}' failed to load: {commands}`)
			return {}
		end
		-- Remember where each command came from so loadCommands can flag the
		-- child as active for the client scanner
		forEveryCommand(commands, function(command: any)
			if command.sourceModule == nil then
				command.sourceModule = childName
			end
		end)
		return commands :: {any}
	end
end
