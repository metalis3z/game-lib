--!strict
local modules = script:FindFirstAncestor("MainModule").Value.Modules

-- Undo has to survive or ';unvote' would strip back to a plain statement and run
-- a second vote instead of ending the first. Preview survives because it only
-- opens the caller's run menu, and so do the unregistered stamps (globalUID,
-- wasGlobal, globalOrigin) that a received broadcast needs to know where it came from
local KEPT_MODIFIERS: {[string]: true} = {
	preview = true,
	undo = true,
}

-- Commands with disableModifiers behave as if nothing like perm / global / loop
-- was ever typed
return function(command: any, modifiers: {[string]: any}): {[string]: any}
	if not (command and command.disableModifiers == true) then
		return modifiers
	end
	local Modifiers = require(modules.Parser.Modifiers) :: any
	local stripped = {}
	for key, value in modifiers do
		local isRegistered = typeof(key) == "string" and Modifiers.get(key) ~= nil
		if not isRegistered or KEPT_MODIFIERS[tostring(key):lower()] then
			stripped[key] = value
		end
	end
	return stripped
end
