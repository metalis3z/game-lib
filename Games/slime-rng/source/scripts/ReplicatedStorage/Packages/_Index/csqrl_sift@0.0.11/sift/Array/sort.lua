-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: sort, time of decompilation: Sun May  3 10:10:06 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}, p1: ((...any) -> ...any)?) --[[ sort ]] -- line: 22
	-- upvalues: copy (copy)
	local v4 = copy(t1)

	table.sort(v4, p1)

	return v4
end
