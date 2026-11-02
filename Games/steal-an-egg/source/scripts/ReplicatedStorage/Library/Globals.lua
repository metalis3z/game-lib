-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local freeze = table.freeze

return freeze((setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 2 ]]
		error(("Unknown Module \'%*\'"):format(p2))
	end
})))