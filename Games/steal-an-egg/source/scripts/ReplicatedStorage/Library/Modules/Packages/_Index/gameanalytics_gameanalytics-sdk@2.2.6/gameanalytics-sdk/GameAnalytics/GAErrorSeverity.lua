-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function readonlytable(p1) --[[ readonlytable | Line: 1 ]]
	return setmetatable({}, {
		__metatable = false,
		__index = p1,
		__newindex = function(p1, p2, p3) --[[ __newindex | Line: 5 ]]
			error("Attempt to modify read-only table: " .. p1 .. ", key=" .. p2 .. ", value=" .. p3)
		end
	})
end

return readonlytable({
	debug = "debug",
	info = "info",
	warning = "warning",
	error = "error",
	critical = "critical"
})