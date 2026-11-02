-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: freeze, time of decompilation: Sun May  3 10:09:57 2026 ]]
local copy = require(script.Parent.copy)

return function(t1: {[any]: any}) --[[ freeze ]] -- line: 22
	-- upvalues: copy (copy)
	local v3 = copy(t1)

	table.freeze(v3)

	return v3
end
