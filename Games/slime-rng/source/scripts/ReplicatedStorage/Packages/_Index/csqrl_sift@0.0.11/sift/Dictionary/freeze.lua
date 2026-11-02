-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: freeze, time of decompilation: Sun May  3 10:10:14 2026 ]]
require(script.Parent.Parent.Types)

local copy = require(script.Parent.copy)

return function(p1) --[[ freeze ]] -- line: 23
	-- upvalues: copy (copy)
	local v3 = copy(p1)

	table.freeze(v3)

	return v3
end
