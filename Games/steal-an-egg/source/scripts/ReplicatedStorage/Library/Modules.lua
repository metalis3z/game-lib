-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

setmetatable(t, {
	__index = function(p1, p2) --[[ Line: 3 ]]
		error((("Unknown Module \'%s\'"):format(p2)))
	end
})
table.freeze(t)

return t