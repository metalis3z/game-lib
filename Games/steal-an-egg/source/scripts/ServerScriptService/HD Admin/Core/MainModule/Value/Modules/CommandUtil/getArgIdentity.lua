--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Args = require(modules.Parser.Args)


-- Always the registered arg's own name, never the display name, so rewording
-- a label can't throw away everyone's saved control values
return function(argEntry: any): string
	local argItem = Args.get(argEntry)
	if not argItem then
		return ""
	end
	return tostring((argItem :: any).key or ""):lower()
end
