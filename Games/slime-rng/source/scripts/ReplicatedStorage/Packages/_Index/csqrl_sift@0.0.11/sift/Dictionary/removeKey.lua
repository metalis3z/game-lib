-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeKey, time of decompilation: Sun May  3 10:10:18 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}, p1) --[[ removeKey ]] -- line: 21
	-- upvalues: copy (copy)
	local v4 = copy(t1)

	v4[p1] = nil

	return v4
end
