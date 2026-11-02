-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: set, time of decompilation: Sun May  3 10:10:19 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}, p1, p2) --[[ set ]] -- line: 21
	-- upvalues: copy (copy)
	local v5 = copy(t1)

	v5[p1] = p2

	return v5
end
