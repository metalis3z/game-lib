--!strict
-- Behaviour modifiers bake into the command name (LoopKill), while the reach ones
-- stay out because the Perm pill and the Reapplies field already tell that story
local HIDDEN_MODIFIERS = {
	perm = true,
	join = true,
	global = true,
	wasglobal = true,
	undo = true,
	un = true,
	unperm = true,
	preview = true,
}

return function(commandName: string, modifiers: any): string
	if typeof(modifiers) ~= "table" then
		return commandName
	end
	local prefixes: {string} = {}
	for modifierName in modifiers :: {[any]: any} do
		local lowerName = tostring(modifierName):lower()
		if not HIDDEN_MODIFIERS[lowerName] then
			table.insert(prefixes, lowerName:sub(1, 1):upper() .. lowerName:sub(2))
		end
	end
	if #prefixes == 0 then
		return commandName
	end
	table.sort(prefixes)
	return table.concat(prefixes) .. commandName
end
