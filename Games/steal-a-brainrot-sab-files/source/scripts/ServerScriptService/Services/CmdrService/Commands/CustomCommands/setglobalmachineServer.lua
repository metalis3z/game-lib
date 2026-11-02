local ServerScriptService = game:GetService("ServerScriptService")
local Services = ServerScriptService:WaitForChild("Services")

local MachineService = require(Services:WaitForChild("MachineService"))

return function(context, machineName, enabled)
	local success, result = pcall(function()
		if enabled then
			return MachineService:ReplaceGlobalMachine(machineName)
		else
			return MachineService:RemoveGlobalMachine(machineName)
		end
	end)

	if not success then
		warn("[Cmdr:globalmachine] " .. tostring(result))
		return "Command failed: " .. tostring(result)
	end

	if not result then
		return ("Unknown machine: %s"):format(tostring(machineName))
	end

	if enabled then
		return ("Globally activated machine: %s"):format(machineName)
	else
		return ("Removed global override for %s's group and restored its default machine."):format(machineName)
	end
end